import 'dart:io';

import 'package:core/theme/spacing.dart';
import 'package:feature_capture/presentation/marking/marking_bloc.dart';
import 'package:feature_capture/presentation/marking/marking_event.dart';
import 'package:feature_capture/presentation/marking/marking_state.dart';
import 'package:feature_capture/presentation/widgets/book_chooser_bar.dart';
import 'package:feature_capture/presentation/widgets/uncertain_word_chip.dart';
import 'package:feature_capture/presentation/widgets/word_correction_sheet.dart';
import 'package:feature_capture/presentation/widgets/word_selection_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:shared/domain/entities/book.dart';
import 'package:shared/domain/entities/quote_theme.dart';
import 'package:shared/domain/entities/recognized_word.dart';
import 'package:shared/domain/entities/recognized_word_extensions.dart';
import 'package:shared/presentation/extensions/app_error_extensions.dart';
import 'package:shared/presentation/extensions/context_extensions.dart';
import 'package:shared/presentation/extensions/screen_layout_extensions.dart';
import 'package:shared/presentation/navigation/navigation_extensions.dart';
import 'package:shared/presentation/widgets/book_cover.dart';
import 'package:shared/presentation/widgets/circle_icon_button.dart';
import 'package:shared/presentation/widgets/drag_dismiss_sheet.dart';
import 'package:shared/presentation/widgets/ink_tap_box.dart';
import 'package:shared/presentation/widgets/loading_screen.dart';
import 'package:shared/presentation/widgets/name_input_dialog.dart';
import 'package:shared/presentation/widgets/page_dots.dart';
import 'package:shared/presentation/widgets/page_number_field.dart';
import 'package:shared/presentation/widgets/page_pill.dart';
import 'package:shared/presentation/widgets/paper_card.dart';
import 'package:shared/presentation/widgets/segmented_toggle.dart';
import 'package:shared/presentation/widgets/selectable_chip.dart';
import 'package:shared/presentation/widgets/sheet_content.dart';
import 'package:shared/presentation/widgets/voice_note_recorder.dart';

const _highlightPadding = 2.0;
const _pageCacheWidth = 1600;
const _legendSampleWidth = 28.0;
const _legendSampleHeight = 16.0;
const _highlightFillOpacity = 0.22;
const _sheetCollapsedSize = 0.55;
const _sheetExpandedSize = 0.95;
const _pickerCoverWidth = 36.0;
const _pickerCoverHeight = 48.0;
const _sideColumnWidth = 320.0;
const _saveMarkerSize = 24.0;
const _handleWidth = 44.0;
const _handleHeight = 5.0;

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
            MarkingProcessing() || MarkingSaved() => LoadingScreen(
              message: context.s.markingProcessingMessage,
            ),
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

class const _Editor({
  required final MarkingReady _state,
}) extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final mode = useState(0);
    final canContinue = _state.selectedWordIndexes.isNotEmpty;
    final hasUncertainWords = _state.words.wordGroups().any((group) => group.number != null);
    final page = PaperCard(
      padding: const EdgeInsets.all(Spacing.m),
      child: IndexedStack(
        index: mode.value,
        sizing: StackFit.expand,
        children: [
          _ReadingText(state: _state),
          _PhotoSelectable(state: _state),
        ],
      ),
    );
    final chooser = BookChooserBar(
      title: _state.bookTitle,
      coverImage: _state.bookCoverImage,
      label: context.s.captureMarkingInto,
      onSwitch: _state.books.isEmpty ? null : () => _showBookPicker(context),
    );
    final continueButton = FilledButton(
      onPressed: canContinue ? () => _openSaveSheet(context) : null,
      child: Text(context.s.markingContinueButton),
    );
    // * landscape keeps the recognised page as tall as possible and stacks its tools beside it
    if (context.layout.isLandscape) {
      return Padding(
        padding: const EdgeInsets.all(Spacing.m),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(child: page),
            const SizedBox(width: Spacing.m),
            SizedBox(
              width: _sideColumnWidth,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  _Header(state: _state),
                  const SizedBox(height: Spacing.m),
                  _ModeToggle(index: mode.value, onChanged: (value) => mode.value = value),
                  if (hasUncertainWords) ...[
                    const SizedBox(height: Spacing.s),
                    const _UncertainLegend(),
                  ],
                  const Spacer(),
                  chooser,
                  const SizedBox(height: Spacing.s),
                  continueButton,
                ],
              ),
            ),
          ],
        ),
      );
    }
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: Spacing.l),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(height: Spacing.s),
          _Header(state: _state),
          const SizedBox(height: Spacing.m),
          _ModeToggle(index: mode.value, onChanged: (value) => mode.value = value),
          if (hasUncertainWords) ...[
            const SizedBox(height: Spacing.s),
            const _UncertainLegend(),
          ],
          const SizedBox(height: Spacing.m),
          Expanded(child: page),
          const SizedBox(height: Spacing.m),
          chooser,
          const SizedBox(height: Spacing.s),
          continueButton,
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
            if (_state.pageNumbers.isNotEmpty) PagePill(pages: _state.pageNumbers),
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
    return SegmentedToggle(
      labels: [context.s.markingModeText, context.s.markingModePhoto],
      selectedIndex: _index,
      onChanged: _onChanged,
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
              color: context.status.uncertain.fill,
              borderRadius: BorderRadius.circular(Spacing.radiusS),
            ),
          ),
        ),
        const SizedBox(width: Spacing.m + uncertainBadgeSize),
        Expanded(
          child: Text(
            context.s.markingUncertainLegend,
            style: context.typography.caption.copyWith(color: context.c.onSurfaceVariant),
          ),
        ),
      ],
    );
  }
}

class const _ReadingText({
  required final MarkingReady _state,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    if (_state.words.isEmpty) {
      return Center(
        child: Text(
          context.s.markingNoTextMessage,
          textAlign: TextAlign.center,
          style: context.typography.readingBody.copyWith(color: context.palette.paperTextFaint),
        ),
      );
    }
    return SingleChildScrollView(
      child: WordSelectionText(
        words: _state.words,
        selectedWordIndexes: _state.selectedWordIndexes,
        onSelectionChanged: (indexes) =>
            context.read<MarkingBloc>().add(MarkingWordsSelected(indexes)),
        onUncertainWordTap: (wordIndex) => showWordCorrectionSheet(context, wordIndex: wordIndex),
      ),
    );
  }
}

class const _PhotoSelectable({
  required final MarkingReady _state,
}) extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final controller = usePageController();
    final visiblePage = useState(0);
    return Column(
      children: [
        Expanded(
          child: PageView.builder(
            controller: controller,
            itemCount: _state.pages.length,
            onPageChanged: (index) => visiblePage.value = index,
            itemBuilder: (context, index) => _PhotoPage(state: _state, pageIndex: index),
          ),
        ),
        if (_state.pages.length > 1) ...[
          const SizedBox(height: Spacing.s),
          PageDots(count: _state.pages.length, index: visiblePage.value),
        ],
      ],
    );
  }
}

class const _PhotoPage({
  required final MarkingReady _state,
  required final int _pageIndex,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final page = _state.pages[_pageIndex];
    final words = _state.words;
    return LayoutBuilder(
      builder: (context, constraints) => SingleChildScrollView(
        child: ConstrainedBox(
          constraints: BoxConstraints(minHeight: constraints.maxHeight),
          child: Center(
            child: AspectRatio(
              aspectRatio: page.aspectRatio,
              child: LayoutBuilder(
                builder: (context, pageConstraints) {
                  final size = pageConstraints.biggest;
                  return Stack(
                    children: [
                      Positioned.fill(
                        child: Image.file(
                          File(page.imagePath),
                          cacheWidth: _pageCacheWidth,
                          fit: BoxFit.fill,
                        ),
                      ),
                      for (final group in words.wordGroups())
                        if (group.number case final int number)
                          for (var member = 0; member < group.indexes.length; member++)
                            if (words[group.indexes[member]].pageIndex == _pageIndex)
                              _UncertainHighlight(
                                word: words[group.indexes[member]],
                                number: member == 0 ? number : null,
                                size: size,
                                onTap: () => showWordCorrectionSheet(
                                  context,
                                  wordIndex: group.indexes.first,
                                ),
                              ),
                      for (final index in _state.selectedWordIndexes)
                        if (index < words.length && words[index].pageIndex == _pageIndex)
                          _WordBox(word: words[index], size: size),
                    ],
                  );
                },
              ),
            ),
          ),
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
        decoration: BoxDecoration(color: context.c.primary.withValues(alpha: 0.4)),
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
    final swatch = context.status.uncertain;
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
      .where((index) => index < state.words.length && state.words[index].isUncertain)
      .length;
}

Future<void> _openSaveSheet(BuildContext context) async {
  final bloc = context.read<MarkingBloc>();
  await showModalBottomSheet<void>(
    context: context,
    isScrollControlled: true,
    useRootNavigator: true,
    backgroundColor: Colors.transparent,
    showDragHandle: false,
    builder: (_) => BlocProvider.value(value: bloc, child: const _SaveSheet()),
  );
  if (bloc.state case MarkingSaved(:final isEditing) when context.mounted) {
    context.showToast(context.s.markingSavedMessage);
    // * an edit returns to the quote it came from, a fresh capture ends in the library
    if (isEditing) {
      context.closeScreen();
      return;
    }
    context.goLibrary();
  }
}

class const _SaveSheet() extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final initialState = context.read<MarkingBloc>().state;
    final initialQuote = switch (initialState) {
      MarkingReady(quoteOverride: final String quote) => quote,
      MarkingReady(:final selectedWordIndexes, :final words) => words.joinMarked(
        selectedWordIndexes,
      ),
      _ => "",
    };
    final initialNote = switch (initialState) {
      MarkingReady(:final String note) => note,
      _ => "",
    };
    final noteController = useTextEditingController(text: initialNote);
    final quoteController = useTextEditingController(text: initialQuote);
    final bottomInset = MediaQuery.viewInsetsOf(context).bottom;
    final keyboardVisible = bottomInset > 0;
    final collapsedSize = context.layout.sheetSize(_sheetCollapsedSize);
    return Padding(
      padding: EdgeInsets.only(bottom: bottomInset),
      child: DragDismissSheet(
        restingSize: keyboardVisible ? _sheetExpandedSize : collapsedSize,
        expandedSize: _sheetExpandedSize,
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
              final quoteField = Container(
                padding: const EdgeInsets.all(Spacing.m),
                decoration: BoxDecoration(
                  color: context.c.primaryContainer,
                  borderRadius: BorderRadius.circular(Spacing.radiusL),
                ),
                child: TextField(
                  controller: quoteController,
                  minLines: 1,
                  maxLines: 5,
                  style: context.typography.readingQuoteItalic.copyWith(
                    color: context.c.onPrimaryContainer,
                  ),
                  onChanged: (value) => context.read<MarkingBloc>().add(MarkingQuoteEdited(value)),
                  decoration: const InputDecoration(
                    isDense: true,
                    filled: false,
                    border: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    contentPadding: EdgeInsets.zero,
                  ),
                ),
              );
              final unsureCount = _uncertainSelectionCount(state);
              final chooser = BookChooserBar(
                title: state.bookTitle,
                coverImage: state.bookCoverImage,
                label: context.s.markingBookFieldLabel,
                onSwitch: state.books.isEmpty ? null : () => _showBookPicker(context),
              );
              final pageField = Align(
                alignment: Alignment.centerLeft,
                child: PageNumberField(
                  pages: state.pageNumbers,
                  wasDetected: state.detectedPageNumbers.isNotEmpty,
                  onChanged: (pages) => context.read<MarkingBloc>().add(
                    MarkingPageNumbersChanged(pages),
                  ),
                ),
              );
              final voiceNote = VoiceNoteRecorder(
                path: state.voiceNotePath,
                durationMs: state.voiceNoteDurationMs,
                onRecorded: (path, durationMs) => context.read<MarkingBloc>().add(
                  MarkingVoiceNoteRecorded(path, durationMs),
                ),
                onCleared: () => context.read<MarkingBloc>().add(const MarkingVoiceNoteCleared()),
              );
              final actions = Row(
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
              );
              final header = Row(
                children: [
                  Container(
                    width: _saveMarkerSize,
                    height: _saveMarkerSize,
                    decoration: BoxDecoration(
                      color: context.c.secondary,
                      shape: BoxShape.circle,
                    ),
                  ),
                  const SizedBox(width: Spacing.s),
                  Expanded(
                    child: Text(
                      context.s.markingSaveSheetTitle(
                        state.bookTitle.isEmpty ? context.s.libraryUnknownBook : state.bookTitle,
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
              );
              return ListView(
                controller: scrollController,
                padding: const EdgeInsets.fromLTRB(Spacing.l, Spacing.s, Spacing.l, Spacing.s),
                children: [
                  Center(
                    child: Container(
                      width: _handleWidth,
                      height: _handleHeight,
                      decoration: BoxDecoration(
                        color: context.c.outline,
                        borderRadius: BorderRadius.circular(Spacing.radiusFull),
                      ),
                    ),
                  ),
                  const SizedBox(height: Spacing.m),
                  header,
                  const SizedBox(height: Spacing.m),
                  // * a single column stretches every field across a landscape viewport
                  if (context.layout.isLandscape)
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              quoteField,
                              if (unsureCount > 0) ...[
                                const SizedBox(height: Spacing.s),
                                _UnsureHint(count: unsureCount),
                              ],
                              const SizedBox(height: Spacing.m),
                              _NoteField(controller: noteController),
                            ],
                          ),
                        ),
                        const SizedBox(width: Spacing.l),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              chooser,
                              const SizedBox(height: Spacing.s),
                              pageField,
                              const SizedBox(height: Spacing.l),
                              voiceNote,
                              const SizedBox(height: Spacing.m),
                              _ThemeChips(
                                themes: state.availableThemes,
                                selected: state.selectedThemeIds,
                              ),
                              const SizedBox(height: Spacing.m),
                              actions,
                            ],
                          ),
                        ),
                      ],
                    )
                  else ...[
                    quoteField,
                    if (unsureCount > 0) ...[
                      const SizedBox(height: Spacing.s),
                      _UnsureHint(count: unsureCount),
                    ],
                    const SizedBox(height: Spacing.m),
                    chooser,
                    const SizedBox(height: Spacing.s),
                    pageField,
                    const SizedBox(height: Spacing.l),
                    voiceNote,
                    const SizedBox(height: Spacing.s),
                    _NoteField(controller: noteController),
                    const SizedBox(height: Spacing.m),
                    _ThemeChips(themes: state.availableThemes, selected: state.selectedThemeIds),
                    const SizedBox(height: Spacing.m),
                    actions,
                  ],
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
        Icon(Icons.error_outline, size: Spacing.iconS, color: context.c.tertiary),
        const SizedBox(width: Spacing.xs),
        Expanded(
          child: Text(
            context.s.markingUnsureWordsLabel(_count),
            style: context.typography.caption.copyWith(color: context.c.tertiary),
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
    isScrollControlled: true,
    useRootNavigator: true,
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
      color: _selected ? context.c.secondaryContainer : context.c.surfaceContainerHigh,
      radius: Spacing.radiusL,
      padding: const EdgeInsets.all(Spacing.s),
      onTap: () {
        context.read<MarkingBloc>().add(MarkingBookChanged(_book.id));
        Navigator.of(context).pop();
      },
      child: Row(
        children: [
          BookCover(
            title: _book.title,
            image: _book.coverImage,
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
                  style: context.typography.label.copyWith(
                    color: context.c.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: Spacing.s),
          Icon(
            _selected ? Icons.check_circle : Icons.circle_outlined,
            color: _selected ? context.c.secondary : context.c.outline,
            size: Spacing.iconM,
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

class const _FavoriteToggle({
  required final bool _isFavorite,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CircleIconButton(
      icon: _isFavorite ? Icons.star_rounded : Icons.star_outline_rounded,
      tooltip: context.s.quoteDetailFavoriteLabel,
      size: 56,
      backgroundColor: _isFavorite ? context.c.primary : context.c.primaryContainer,
      foregroundColor: _isFavorite ? context.c.onPrimary : context.c.primary,
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
            selectedColor: context.c.secondary,
            selectedTextColor: context.c.onSecondary,
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
