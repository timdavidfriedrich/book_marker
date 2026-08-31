import 'dart:async';
import 'dart:io';

import 'package:core/theme/spacing.dart';
import 'package:core/theme/theme_extensions.dart';
import 'package:feature_capture/domain/mark_text.dart';
import 'package:feature_capture/domain/recognized_page.dart';
import 'package:feature_capture/presentation/extensions/recognized_page_extensions.dart';
import 'package:feature_capture/presentation/marking/marking_bloc.dart';
import 'package:feature_capture/presentation/marking/marking_event.dart';
import 'package:feature_capture/presentation/marking/marking_state.dart';
import 'package:feature_capture/presentation/widgets/book_chooser_bar.dart';
import 'package:feature_capture/presentation/widgets/uncertain_word_chip.dart';
import 'package:feature_capture/presentation/widgets/word_correction_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:path_provider/path_provider.dart';
import 'package:record/record.dart';
import 'package:shared/domain/entities/book.dart';
import 'package:shared/domain/entities/quote_theme.dart';
import 'package:shared/presentation/extensions/accent_extensions.dart';
import 'package:shared/presentation/extensions/app_error_extensions.dart';
import 'package:shared/presentation/extensions/context_extensions.dart';
import 'package:shared/presentation/navigation/navigation_extensions.dart';
import 'package:shared/presentation/widgets/book_cover.dart';
import 'package:shared/presentation/widgets/circle_icon_button.dart';
import 'package:shared/presentation/widgets/ink_tap_box.dart';
import 'package:shared/presentation/widgets/name_input_dialog.dart';
import 'package:shared/presentation/widgets/page_pill.dart';
import 'package:shared/presentation/widgets/paper_card.dart';
import 'package:shared/presentation/widgets/selectable_chip.dart';
import 'package:shared/presentation/widgets/sheet_content.dart';
import 'package:uuid/uuid.dart';

const _uuid = Uuid();
const _minVoiceNoteMs = 500;
const _highlightPadding = 2.0;
const _legendSampleWidth = 28.0;
const _legendSampleHeight = 16.0;
const _highlightFillOpacity = 0.22;
const _sheetCollapsedSize = 0.55;
const _sheetExpandedSize = 0.95;
const _pageFieldWidth = 56.0;
const _pickerCoverWidth = 36.0;
const _pickerCoverHeight = 48.0;

String _formatDuration(int milliseconds) {
  final duration = Duration(milliseconds: milliseconds);
  final minutes = duration.inMinutes;
  final seconds = duration.inSeconds % 60;
  return "$minutes:${seconds.toString().padLeft(2, "0")}";
}

class const MarkingScreen({
  super.key,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocConsumer<MarkingBloc, MarkingState>(
          listenWhen: (previous, current) => current is MarkingReady && current.saveError != null,
          listener: (context, state) {
            if (state is MarkingReady) {
              if (state.saveError case final error?) {
                context.showToast(error.toMessage(context));
              }
            }
          },
          builder: (context, state) => switch (state) {
            MarkingProcessing() || MarkingSaved() => const _ProcessingView(),
            MarkingFailure(:final error) => Center(
              child: Padding(
                padding: const EdgeInsets.all(Spacing.l),
                child: Text(error.toMessage(context), textAlign: TextAlign.center),
              ),
            ),
            MarkingReady() => _Editor(state: state),
          },
        ),
      ),
    );
  }
}

class const _ProcessingView() extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const CircularProgressIndicator(),
          const SizedBox(height: Spacing.m),
          Text(context.s.markingProcessingMessage, style: context.typography.monoLabel),
        ],
      ),
    );
  }
}

class const _Editor({
  required final MarkingReady _state,
}) extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final mode = useState(0);
    final canContinue = _state.selectedWordIndexes.isNotEmpty;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: Spacing.l),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(height: Spacing.s),
          _Header(state: _state),
          const SizedBox(height: Spacing.m),
          Row(
            children: [
              _ModeToggle(index: mode.value, onChanged: (value) => mode.value = value),
            ],
          ),
          if (_state.page.wordGroups().any((group) => group.number != null)) ...[
            const SizedBox(height: Spacing.s),
            const _UncertainLegend(),
          ],
          const SizedBox(height: Spacing.m),
          Expanded(
            child: PaperCard(
              padding: const EdgeInsets.all(Spacing.m),
              child: IndexedStack(
                index: mode.value,
                sizing: StackFit.expand,
                children: [
                  _ReadingText(state: _state),
                  _PhotoSelectable(state: _state),
                ],
              ),
            ),
          ),
          const SizedBox(height: Spacing.m),
          BookChooserBar(
            title: _state.bookTitle,
            thumbnailUrl: _state.bookThumbnailUrl,
            accent: _state.bookId.accent,
            label: context.s.captureMarkingInto,
            onSwitch: _state.books.isEmpty ? null : () => _showBookPicker(context),
          ),
          const SizedBox(height: Spacing.s),
          FilledButton(
            onPressed: canContinue ? () => _openSaveSheet(context) : null,
            child: Text(context.s.markingContinueButton),
          ),
          const SizedBox(height: Spacing.s),
        ],
      ),
    );
  }
}

class const _Header({
  required final MarkingReady _state,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          children: [
            CircleIconButton(
              icon: Icons.arrow_back,
              tooltip: context.s.back,
              onPressed: context.closeScreen,
            ),
            const Spacer(),
            if (_state.pageNumber case final int page)
              PagePill(page: page, accent: AccentColor.coral),
          ],
        ),
      ],
    );
  }
}

class const _ModeToggle({
  required final int _index,
  required final ValueChanged<int> _onChanged,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(Spacing.xxxs),
      decoration: BoxDecoration(
        color: context.c.surfaceContainerHigh,
        borderRadius: BorderRadius.circular(Spacing.radiusFull),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          for (final entry in [context.s.markingModeText, context.s.markingModePhoto].indexed)
            InkTapBox(
              onTap: () => _onChanged(entry.$1),
              radius: Spacing.radiusFull,
              color: entry.$1 == _index ? context.c.inverseSurface : Colors.transparent,
              padding: const EdgeInsets.symmetric(horizontal: Spacing.m, vertical: Spacing.xs),
              child: Text(
                entry.$2,
                style: context.t.labelMedium?.copyWith(
                  fontSize: 14,
                  color: entry.$1 == _index
                      ? context.c.onInverseSurface
                      : context.c.onSurfaceVariant,
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class const _UncertainLegend() extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Badge(
          label: const Text("1"),
          alignment: AlignmentDirectional.topEnd,
          offset: uncertainBadgeInlineOffset,
          child: Container(
            width: _legendSampleWidth,
            height: _legendSampleHeight,
            decoration: BoxDecoration(
              color: context.palette.sky.fill,
              borderRadius: BorderRadius.circular(Spacing.radiusS),
            ),
          ),
        ),
        const SizedBox(width: Spacing.m + uncertainBadgeSize),
        Expanded(
          child: Text(
            context.s.markingUncertainLegend,
            style: context.typography.monoCaption.copyWith(color: context.c.onSurfaceVariant),
          ),
        ),
      ],
    );
  }
}

class const _ReadingText({
  required final MarkingReady _state,
}) extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final words = _state.page.words;
    if (words.isEmpty) {
      return Center(child: Text(context.s.markingNoTextMessage, textAlign: TextAlign.center));
    }
    final bloc = context.read<MarkingBloc>();
    final layout = useMemoized(() {
      final groups = _state.page.wordGroups();
      final spans = <InlineSpan>[];
      final ranges = [
        for (var index = 0; index < words.length; index++) <int>[0, 0],
      ];
      var offset = 0;
      for (var groupIndex = 0; groupIndex < groups.length; groupIndex++) {
        final group = groups[groupIndex];
        final int length;
        if (group.number case final int number) {
          spans.add(
            WidgetSpan(
              alignment: PlaceholderAlignment.middle,
              child: UncertainWordChip(
                text: group.text,
                number: number,
                onTap: () => showWordCorrectionSheet(context, wordIndex: group.indexes.first),
              ),
            ),
          );
          length = 1;
        } else {
          spans.add(TextSpan(text: group.text));
          length = group.text.length;
        }
        for (final index in group.indexes) {
          ranges[index] = [offset, offset + length];
        }
        offset += length;
        if (groupIndex < groups.length - 1) {
          spans.add(const TextSpan(text: " "));
          offset += 1;
        }
      }
      return (spans: spans, ranges: ranges);
    }, [_state.page]);

    final textSpan = useMemoized(
      () => TextSpan(children: layout.spans, style: context.typography.readingBody),
      [layout],
    );

    void selectionChanged(TextSelection selection) {
      if (selection.start < 0 || selection.end < 0) return;
      final next = <int>{};
      for (var index = 0; index < layout.ranges.length; index++) {
        if (layout.ranges[index][0] < selection.end && layout.ranges[index][1] > selection.start) {
          next.add(index);
        }
      }
      if (bloc.state case final MarkingReady current
          when next.length == current.selectedWordIndexes.length &&
              next.containsAll(current.selectedWordIndexes)) {
        return;
      }
      bloc.add(MarkingWordsSelected(next));
    }

    return SingleChildScrollView(
      child: SelectableText.rich(
        textSpan,
        onSelectionChanged: (selection, cause) => selectionChanged(selection),
      ),
    );
  }
}

class const _PhotoSelectable({
  required final MarkingReady _state,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final page = _state.page;
    return Center(
      child: AspectRatio(
        aspectRatio: page.aspectRatio,
        child: LayoutBuilder(
          builder: (context, constraints) {
            final size = constraints.biggest;
            return Stack(
              children: [
                Positioned.fill(child: Image.file(File(_state.imagePath), fit: BoxFit.fill)),
                for (final group in page.wordGroups())
                  if (group.number case final int number)
                    for (var member = 0; member < group.indexes.length; member++)
                      _UncertainHighlight(
                        word: page.words[group.indexes[member]],
                        number: member == 0 ? number : null,
                        size: size,
                        onTap: () => showWordCorrectionSheet(
                          context,
                          wordIndex: group.indexes.first,
                        ),
                      ),
                for (final index in _state.selectedWordIndexes)
                  if (index < page.words.length) _WordBox(word: page.words[index], size: size),
              ],
            );
          },
        ),
      ),
    );
  }
}

class const _WordBox({
  required final RecognizedWord _word,
  required final Size _size,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: _word.left * _size.width,
      top: _word.top * _size.height,
      width: _word.width * _size.width,
      height: _word.height * _size.height,
      child: DecoratedBox(
        decoration: BoxDecoration(color: context.palette.amber.solid.withValues(alpha: 0.4)),
      ),
    );
  }
}

class const _UncertainHighlight({
  required final RecognizedWord _word,
  required final int? _number,
  required final Size _size,
  required final VoidCallback _onTap,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final swatch = context.palette.sky;
    return Positioned(
      left: _word.left * _size.width - _highlightPadding,
      top: _word.top * _size.height - _highlightPadding,
      width: _word.width * _size.width + _highlightPadding * 2,
      height: _word.height * _size.height + _highlightPadding * 2,
      child: Badge(
        isLabelVisible: _number != null,
        label: Text("${_number ?? 0}"),
        alignment: AlignmentDirectional.topEnd,
        offset: const Offset(uncertainBadgeSize / 2, -uncertainBadgeSize / 2),
        child: DecoratedBox(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(Spacing.radiusS),
            border: Border.all(color: swatch.solid, width: Spacing.borderWidthThin),
          ),
          child: InkTapBox(
            onTap: _onTap,
            color: swatch.solid.withValues(alpha: _highlightFillOpacity),
            radius: Spacing.radiusS,
            child: const SizedBox.expand(),
          ),
        ),
      ),
    );
  }
}

int _uncertainSelectionCount(MarkingReady state) {
  return state.selectedWordIndexes
      .where((index) => index < state.page.words.length && state.page.words[index].isUncertain)
      .length;
}

Future<void> _openSaveSheet(BuildContext context) async {
  final bloc = context.read<MarkingBloc>();
  await showModalBottomSheet<void>(
    context: context,
    isScrollControlled: true,
    useRootNavigator: true,
    backgroundColor: Colors.transparent,
    builder: (_) => BlocProvider.value(value: bloc, child: const _SaveSheet()),
  );
  if (bloc.state is MarkingSaved && context.mounted) {
    context.showToast(context.s.markingSavedMessage);
    context.goLibrary();
  }
}

class const _SaveSheet() extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final initialState = context.read<MarkingBloc>().state;
    final initialPage = switch (initialState) {
      MarkingReady(:final pageNumber) => pageNumber?.toString() ?? "",
      _ => "",
    };
    final initialQuote = switch (initialState) {
      MarkingReady(:final selectedWordIndexes, :final page) => joinMarkedWords(
        page.words,
        selectedWordIndexes,
      ),
      _ => "",
    };
    final pageController = useTextEditingController(text: initialPage);
    final noteController = useTextEditingController();
    final quoteController = useTextEditingController(text: initialQuote);
    final bottomInset = MediaQuery.viewInsetsOf(context).bottom;
    final keyboardVisible = bottomInset > 0;
    return Padding(
      padding: EdgeInsets.only(bottom: bottomInset),
      child: DraggableScrollableSheet(
        initialChildSize: keyboardVisible ? _sheetExpandedSize : _sheetCollapsedSize,
        minChildSize: keyboardVisible ? _sheetExpandedSize : _sheetCollapsedSize,
        maxChildSize: _sheetExpandedSize,
        builder: (context, scrollController) => DecoratedBox(
          decoration: BoxDecoration(
            color: context.c.surfaceContainerLowest,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(Spacing.radiusXxl)),
          ),
          child: BlocConsumer<MarkingBloc, MarkingState>(
            listenWhen: (previous, current) => current is MarkingSaved,
            listener: (context, state) => Navigator.of(context).pop(),
            builder: (context, state) {
              if (state is! MarkingReady) return const SizedBox.shrink();
              return ListView(
                controller: scrollController,
                padding: const EdgeInsets.fromLTRB(Spacing.l, Spacing.s, Spacing.l, Spacing.s),
                children: [
                  Center(
                    child: Container(
                      width: 44,
                      height: 5,
                      decoration: BoxDecoration(
                        color: context.c.outline,
                        borderRadius: BorderRadius.circular(Spacing.radiusFull),
                      ),
                    ),
                  ),
                  const SizedBox(height: Spacing.m),
                  Row(
                    children: [
                      Container(
                        width: 24,
                        height: 24,
                        decoration: BoxDecoration(
                          color: context.palette.teal.solid,
                          shape: BoxShape.circle,
                        ),
                      ),
                      const SizedBox(width: Spacing.s),
                      Expanded(
                        child: Text(
                          context.s.markingSaveSheetTitle(
                            state.bookTitle.isEmpty
                                ? context.s.libraryUnknownBook
                                : state.bookTitle,
                          ),
                          style: context.t.titleLarge,
                        ),
                      ),
                      const SizedBox(width: Spacing.s),
                      CircleIconButton(
                        icon: Icons.close,
                        tooltip: context.s.close,
                        onPressed: () => Navigator.of(context).pop(),
                      ),
                    ],
                  ),
                  const SizedBox(height: Spacing.m),
                  Container(
                    padding: const EdgeInsets.all(Spacing.m),
                    decoration: BoxDecoration(
                      color: context.palette.amber.fill,
                      borderRadius: BorderRadius.circular(Spacing.radiusL),
                    ),
                    child: TextField(
                      controller: quoteController,
                      minLines: 1,
                      maxLines: 5,
                      style: context.typography.readingQuoteItalic,
                      onChanged: (value) =>
                          context.read<MarkingBloc>().add(MarkingQuoteEdited(value)),
                      decoration: const InputDecoration(
                        isDense: true,
                        filled: false,
                        border: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        contentPadding: EdgeInsets.zero,
                      ),
                    ),
                  ),
                  if (_uncertainSelectionCount(state) case final count when count > 0) ...[
                    const SizedBox(height: Spacing.s),
                    _UnsureHint(count: count),
                  ],
                  const SizedBox(height: Spacing.m),
                  BookChooserBar(
                    title: state.bookTitle,
                    thumbnailUrl: state.bookThumbnailUrl,
                    accent: state.bookId.accent,
                    label: context.s.markingBookFieldLabel,
                    onSwitch: state.books.isEmpty ? null : () => _showBookPicker(context),
                  ),
                  const SizedBox(height: Spacing.s),
                  Row(
                    children: [
                      _PageField(
                        controller: pageController,
                        wasDetected: state.page.detectedPageNumber != null,
                      ),
                      const SizedBox(width: Spacing.s),
                      Expanded(
                        child: _VoiceNoteRecorder(
                          voiceNotePath: state.voiceNotePath,
                          voiceNoteDurationMs: state.voiceNoteDurationMs,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: Spacing.s),
                  _NoteField(controller: noteController),
                  const SizedBox(height: Spacing.m),
                  _ThemeChips(themes: state.availableThemes, selected: state.selectedThemeIds),
                  const SizedBox(height: Spacing.m),
                  Row(
                    children: [
                      _FavoriteToggle(isFavorite: state.isFavorite),
                      const SizedBox(width: Spacing.s),
                      Expanded(
                        child: FilledButton(
                          onPressed: state.isSaving
                              ? null
                              : () => context.read<MarkingBloc>().add(const MarkingSaveRequested()),
                          child: state.isSaving
                              ? const SizedBox(
                                  height: Spacing.iconM,
                                  width: Spacing.iconM,
                                  child: CircularProgressIndicator(
                                    strokeWidth: Spacing.borderWidthMedium,
                                  ),
                                )
                              : Text(context.s.markingDoneButton),
                        ),
                      ),
                    ],
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}

class const _UnsureHint({
  required final int _count,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(Icons.error_outline, size: Spacing.iconS, color: context.palette.coral.solid),
        const SizedBox(width: Spacing.xs),
        Expanded(
          child: Text(
            context.s.markingUnsureWordsLabel(_count),
            style: context.typography.monoCaption.copyWith(color: context.palette.coral.solid),
          ),
        ),
      ],
    );
  }
}

Future<void> _showBookPicker(BuildContext context) async {
  final bloc = context.read<MarkingBloc>();
  await showModalBottomSheet<void>(
    context: context,
    useRootNavigator: true,
    isScrollControlled: true,
    builder: (_) => BlocProvider.value(value: bloc, child: const _BookPickerSheet()),
  );
}

class const _BookPickerSheet() extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MarkingBloc, MarkingState>(
      builder: (context, state) {
        if (state is! MarkingReady) return const SizedBox.shrink();
        return SheetContent(
          children: [
            Text(context.s.markingBookPickerTitle, style: context.t.titleMedium),
            const SizedBox(height: Spacing.m),
            Flexible(
              child: ListView.separated(
                shrinkWrap: true,
                padding: EdgeInsets.zero,
                itemCount: state.books.length,
                separatorBuilder: (context, index) => const SizedBox(height: Spacing.xs),
                itemBuilder: (context, index) => _BookPickerRow(
                  book: state.books[index],
                  selected: state.books[index].id == state.bookId,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}

class const _BookPickerRow({
  required final Book _book,
  required final bool _selected,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final authors = _book.authors.isEmpty ? context.s.bookAuthorsUnknown : _book.authors.join(", ");
    return InkTapBox(
      color: _selected ? context.palette.teal.fill : context.c.surfaceContainerHigh,
      radius: Spacing.radiusL,
      padding: const EdgeInsets.all(Spacing.s),
      onTap: () {
        context.read<MarkingBloc>().add(MarkingBookChanged(_book.id));
        Navigator.of(context).pop();
      },
      child: Row(
        children: [
          BookCover(
            accent: _book.id.accent,
            url: _book.thumbnailUrl,
            width: _pickerCoverWidth,
            height: _pickerCoverHeight,
            radius: Spacing.radiusS,
          ),
          const SizedBox(width: Spacing.s),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  _book.title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: context.t.titleMedium,
                ),
                Text(
                  authors,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: context.typography.monoLabel.copyWith(
                    color: context.c.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: Spacing.s),
          Icon(
            _selected ? Icons.check_circle : Icons.circle_outlined,
            color: _selected ? context.palette.teal.solid : context.c.outline,
            size: Spacing.iconM,
          ),
        ],
      ),
    );
  }
}

class const _PageField({
  required final TextEditingController _controller,
  required final bool _wasDetected,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: Spacing.m, vertical: Spacing.s),
      decoration: BoxDecoration(
        color: context.c.surfaceContainerHigh,
        borderRadius: BorderRadius.circular(Spacing.radiusM),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            context.s.markingPageFieldLabel,
            style: context.typography.monoLabel.copyWith(color: context.c.onSurfaceVariant),
          ),
          const SizedBox(width: Spacing.s),
          SizedBox(
            width: _pageFieldWidth,
            child: TextField(
              controller: _controller,
              keyboardType: TextInputType.number,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              style: context.typography.monoLabelStrong.copyWith(
                fontSize: 18,
                color: context.c.onSurface,
              ),
              decoration: const InputDecoration(
                isDense: true,
                filled: false,
                contentPadding: EdgeInsets.zero,
                border: InputBorder.none,
                enabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
              ),
              onChanged: (value) =>
                  context.read<MarkingBloc>().add(MarkingPageNumberChanged(int.tryParse(value))),
            ),
          ),
          if (_wasDetected)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: Spacing.xs, vertical: Spacing.xxxs),
              decoration: BoxDecoration(
                color: context.palette.teal.solid,
                borderRadius: BorderRadius.circular(Spacing.radiusFull),
              ),
              child: Text(
                context.s.markingPageAutoLabel,
                style: context.typography.monoBadge.copyWith(color: context.palette.teal.onSolid),
              ),
            ),
        ],
      ),
    );
  }
}

class const _NoteField({
  required final TextEditingController _controller,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: Spacing.m, vertical: Spacing.m),
      decoration: BoxDecoration(
        color: context.c.surfaceContainerHigh,
        borderRadius: BorderRadius.circular(Spacing.radiusM),
      ),
      child: TextField(
        controller: _controller,
        minLines: 3,
        maxLines: 6,
        textCapitalization: TextCapitalization.sentences,
        style: context.t.bodyLarge,
        onChanged: (value) => context.read<MarkingBloc>().add(MarkingNoteChanged(value)),
        decoration: InputDecoration(
          isDense: true,
          filled: false,
          border: InputBorder.none,
          enabledBorder: InputBorder.none,
          focusedBorder: InputBorder.none,
          contentPadding: EdgeInsets.zero,
          hintText: context.s.markingNoteHint,
        ),
      ),
    );
  }
}

class const _VoiceNoteRecorder({
  required final String? _voiceNotePath,
  required final int? _voiceNoteDurationMs,
}) extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final recorder = useMemoized(AudioRecorder.new);
    useEffect(() => recorder.dispose, [recorder]);
    final isRecording = useState(false);
    final stopwatch = useMemoized(Stopwatch.new);
    final elapsed = useState(Duration.zero);

    useEffect(() {
      if (!isRecording.value) return null;
      final timer = Timer.periodic(const Duration(milliseconds: 200), (_) {
        elapsed.value = stopwatch.elapsed;
      });
      return timer.cancel;
    }, [isRecording.value]);

    Future<void> start() async {
      if (!await recorder.hasPermission()) {
        if (context.mounted) context.showToast(context.s.errorUnexpected);
        return;
      }
      final directory = await getApplicationDocumentsDirectory();
      final path = "${directory.path}/voice_${_uuid.v4()}.m4a";
      await recorder.start(const RecordConfig(), path: path);
      stopwatch
        ..reset()
        ..start();
      elapsed.value = Duration.zero;
      isRecording.value = true;
    }

    Future<void> stop() async {
      if (!isRecording.value) return;
      stopwatch.stop();
      final path = await recorder.stop();
      isRecording.value = false;
      final milliseconds = stopwatch.elapsedMilliseconds;
      if (path != null && milliseconds > _minVoiceNoteMs && context.mounted) {
        context.read<MarkingBloc>().add(MarkingVoiceNoteRecorded(path, milliseconds));
      }
    }

    final coral = context.palette.coral;
    if (_voiceNotePath != null && !isRecording.value) {
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: Spacing.m, vertical: Spacing.xs),
        decoration: BoxDecoration(
          color: coral.solid,
          borderRadius: BorderRadius.circular(Spacing.radiusFull),
        ),
        child: Row(
          children: [
            Icon(Icons.graphic_eq, color: coral.onSolid, size: Spacing.iconM),
            const SizedBox(width: Spacing.s),
            Expanded(
              child: Text(
                context.s.quoteVoiceNoteLabel(_formatDuration(_voiceNoteDurationMs ?? 0)),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: context.t.bodyLarge?.copyWith(color: coral.onSolid),
              ),
            ),
            IconButton(
              onPressed: () => context.read<MarkingBloc>().add(const MarkingVoiceNoteCleared()),
              icon: const Icon(Icons.close),
              iconSize: Spacing.iconM,
              color: coral.onSolid,
            ),
          ],
        ),
      );
    }

    final label = isRecording.value
        ? _formatDuration(elapsed.value.inMilliseconds)
        : context.s.markingVoiceNoteHint;
    return Listener(
      onPointerDown: (_) => start(),
      onPointerUp: (_) => stop(),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: Spacing.m, vertical: Spacing.s),
        decoration: BoxDecoration(
          color: coral.solid,
          borderRadius: BorderRadius.circular(Spacing.radiusFull),
        ),
        child: Row(
          children: [
            Container(
              width: 28,
              height: 28,
              alignment: Alignment.center,
              decoration: BoxDecoration(color: coral.onSolid, shape: BoxShape.circle),
              child: Icon(Icons.mic_rounded, size: Spacing.iconS, color: coral.solid),
            ),
            const SizedBox(width: Spacing.s),
            Expanded(
              child: Text(
                label,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: context.t.bodyLarge?.copyWith(color: coral.onSolid),
              ),
            ),
            Icon(
              isRecording.value ? Icons.fiber_manual_record : Icons.graphic_eq,
              color: coral.onSolid,
              size: Spacing.iconM,
            ),
          ],
        ),
      ),
    );
  }
}

class const _FavoriteToggle({
  required final bool _isFavorite,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CircleIconButton(
      icon: _isFavorite ? Icons.star_rounded : Icons.star_outline_rounded,
      tooltip: context.s.quoteDetailFavoriteLabel,
      size: 56,
      backgroundColor: _isFavorite ? context.palette.amber.solid : context.palette.amber.fill,
      foregroundColor: _isFavorite ? context.palette.amber.onSolid : context.palette.amber.solid,
      onPressed: () => context.read<MarkingBloc>().add(const MarkingFavoriteToggled()),
    );
  }
}

class const _ThemeChips({
  required final List<QuoteTheme> _themes,
  required final Set<String> _selected,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: Spacing.xs,
      runSpacing: Spacing.xs,
      children: [
        for (final theme in _themes)
          SelectableChip(
            label: theme.name,
            selected: _selected.contains(theme.id),
            selectedColor: context.palette.teal.solid,
            selectedTextColor: context.palette.teal.onSolid,
            onTap: () => context.read<MarkingBloc>().add(MarkingThemeToggled(theme.id)),
          ),
        SelectableChip(
          label: context.s.markingNewThemeChip,
          selected: false,
          onTap: () => _promptNewMarkingTheme(context),
        ),
      ],
    );
  }
}

Future<void> _promptNewMarkingTheme(BuildContext context) async {
  final bloc = context.read<MarkingBloc>();
  final name = await showNameInputDialog(
    context,
    title: context.s.themesNewThemeTitle,
    hint: context.s.themesNewThemeHint,
  );
  if (name != null && name.trim().isNotEmpty) bloc.add(MarkingThemeCreateRequested(name));
}
