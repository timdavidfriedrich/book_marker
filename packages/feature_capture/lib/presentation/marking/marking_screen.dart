import 'dart:io';

import 'package:core/theme/spacing.dart';
import 'package:core/theme/theme_extensions.dart';
import 'package:feature_capture/domain/mark_text.dart';
import 'package:feature_capture/domain/recognized_page.dart';
import 'package:feature_capture/presentation/marking/marking_bloc.dart';
import 'package:feature_capture/presentation/marking/marking_event.dart';
import 'package:feature_capture/presentation/marking/marking_state.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:shared/presentation/extensions/app_error_extensions.dart';
import 'package:shared/presentation/extensions/context_extensions.dart';
import 'package:shared/presentation/navigation/navigation_extensions.dart';
import 'package:shared/presentation/widgets/circle_icon_button.dart';
import 'package:shared/presentation/widgets/ink_tap_box.dart';
import 'package:shared/presentation/widgets/page_pill.dart';
import 'package:shared/presentation/widgets/paper_card.dart';

const _lineBorderOpacity = 0.15;
const _wrapHyphens = {"-", "‐", "­"};

String _spanText(String raw) {
  final text = raw.trim();
  if (text.isNotEmpty && _wrapHyphens.contains(text[text.length - 1])) {
    return text.substring(0, text.length - 1);
  }
  return "$text ";
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
    final canContinue = _state.selectedIndexes.isNotEmpty;
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
          const SizedBox(height: Spacing.m),
          Expanded(
            child: PaperCard(
              padding: const EdgeInsets.all(Spacing.m),
              child: mode.value == 0
                  ? _ReadingText(state: _state)
                  : _PhotoSelectable(state: _state),
            ),
          ),
          const SizedBox(height: Spacing.m),
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
    final authors = _state.bookAuthors.isEmpty
        ? context.s.bookAuthorsUnknown
        : _state.bookAuthors.join(", ");
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        CircleIconButton(
          icon: Icons.arrow_back,
          tooltip: context.s.back,
          onPressed: context.closeScreen,
        ),
        const SizedBox(width: Spacing.s),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                _state.bookTitle.isEmpty ? context.s.libraryUnknownBook : _state.bookTitle,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: context.t.titleLarge,
              ),
              Text(
                authors,
                style: context.typography.monoLabel.copyWith(color: context.c.onSurfaceVariant),
              ),
            ],
          ),
        ),
        if (_state.pageNumber case final int page) ...[
          const SizedBox(width: Spacing.s),
          PagePill(page: page, accent: AccentColor.coral),
        ],
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

class const _ReadingText({
  required final MarkingReady _state,
}) extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final lines = _state.page.lines;
    final bloc = context.read<MarkingBloc>();
    final recognizers = useMemoized(
      () => List.generate(
        lines.length,
        (index) => TapGestureRecognizer()..onTap = () => bloc.add(MarkingLineToggled(index)),
      ),
      [lines.length],
    );
    useEffect(() {
      return () {
        for (final recognizer in recognizers) {
          recognizer.dispose();
        }
      };
    }, [recognizers]);

    if (lines.isEmpty) {
      return Center(
        child: Text(context.s.markingNoTextMessage, textAlign: TextAlign.center),
      );
    }

    final highlight = context.palette.amber.solid;
    return SingleChildScrollView(
      child: Text.rich(
        TextSpan(
          children: [
            for (var index = 0; index < lines.length; index++)
              TextSpan(
                text: _spanText(lines[index].text),
                recognizer: recognizers[index],
                style: _state.selectedIndexes.contains(index)
                    ? context.typography.readingBody.copyWith(
                        background: Paint()..color = highlight,
                      )
                    : context.typography.readingBody,
              ),
          ],
        ),
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
                for (var index = 0; index < page.lines.length; index++)
                  _LineBox(
                    line: page.lines[index],
                    size: size,
                    isSelected: _state.selectedIndexes.contains(index),
                    onTap: () => context.read<MarkingBloc>().add(MarkingLineToggled(index)),
                  ),
              ],
            );
          },
        ),
      ),
    );
  }
}

class const _LineBox({
  required final RecognizedLine _line,
  required final Size _size,
  required final bool _isSelected,
  required final VoidCallback _onTap,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: _line.left * _size.width,
      top: _line.top * _size.height,
      width: _line.width * _size.width,
      height: _line.height * _size.height,
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: _onTap,
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: _isSelected ? context.palette.amber.solid.withValues(alpha: 0.4) : null,
            border: Border.all(
              color: _isSelected
                  ? context.palette.amber.solid
                  : context.c.onSurface.withValues(alpha: _lineBorderOpacity),
              width: Spacing.borderWidthThin,
            ),
          ),
        ),
      ),
    );
  }
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
    final pageController = useTextEditingController();
    return DraggableScrollableSheet(
      initialChildSize: 0.55,
      minChildSize: 0.55,
      maxChildSize: 0.95,
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
            final orderedIndexes = state.selectedIndexes.toList()..sort();
            final quote = joinMarkedLines(
              orderedIndexes.map((index) => state.page.lines[index].text),
            );
            return ListView(
              controller: scrollController,
              padding: EdgeInsets.fromLTRB(
                Spacing.l,
                Spacing.s,
                Spacing.l,
                Spacing.l + MediaQuery.viewInsetsOf(context).bottom,
              ),
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
                ),
                const SizedBox(height: Spacing.m),
                Container(
                  padding: const EdgeInsets.all(Spacing.m),
                  decoration: BoxDecoration(
                    color: context.palette.amber.fill,
                    borderRadius: BorderRadius.circular(Spacing.radiusL),
                  ),
                  child: Text('“$quote”', style: context.typography.readingQuoteItalic),
                ),
                const SizedBox(height: Spacing.m),
                _PageField(
                  controller: pageController,
                  wasDetected: state.page.detectedPageNumber != null,
                ),
                const SizedBox(height: Spacing.s),
                const _NotePlaceholder(),
                const SizedBox(height: Spacing.m),
                const _VoicePlaceholder(),
                const SizedBox(height: Spacing.m),
                Row(
                  children: [
                    _StarToggle(isStarred: state.isStarred),
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
      padding: const EdgeInsets.symmetric(horizontal: Spacing.m, vertical: Spacing.xxs),
      decoration: BoxDecoration(
        color: context.c.surfaceContainerHigh,
        borderRadius: BorderRadius.circular(Spacing.radiusM),
      ),
      child: Row(
        children: [
          Text(
            context.s.markingPageFieldLabel,
            style: context.typography.monoLabel.copyWith(color: context.c.onSurfaceVariant),
          ),
          const SizedBox(width: Spacing.s),
          SizedBox(
            width: 64,
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

class const _NotePlaceholder() extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(Spacing.m),
      decoration: BoxDecoration(
        color: context.c.surfaceContainerHigh,
        borderRadius: BorderRadius.circular(Spacing.radiusM),
      ),
      child: Text(
        context.s.markingNoteHint,
        style: context.t.bodyLarge?.copyWith(color: context.c.onSurfaceVariant),
      ),
    );
  }
}

class const _VoicePlaceholder() extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: Spacing.m, vertical: Spacing.s),
      decoration: BoxDecoration(
        color: context.palette.coral.solid,
        borderRadius: BorderRadius.circular(Spacing.radiusFull),
      ),
      child: Row(
        children: [
          Container(
            width: 28,
            height: 28,
            alignment: Alignment.center,
            decoration: BoxDecoration(color: context.palette.coral.onSolid, shape: BoxShape.circle),
            child: Icon(Icons.mic_rounded, size: Spacing.iconS, color: context.palette.coral.solid),
          ),
          const SizedBox(width: Spacing.s),
          Expanded(
            child: Text(
              context.s.markingVoiceHint,
              style: context.t.bodyLarge?.copyWith(color: context.palette.coral.onSolid),
            ),
          ),
          Icon(Icons.graphic_eq, color: context.palette.coral.onSolid, size: Spacing.iconM),
        ],
      ),
    );
  }
}

class const _StarToggle({
  required final bool _isStarred,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CircleIconButton(
      icon: _isStarred ? Icons.star_rounded : Icons.star_outline_rounded,
      tooltip: context.s.bookmarkDetailStarredLabel,
      size: 56,
      backgroundColor: _isStarred ? context.palette.amber.solid : context.palette.amber.fill,
      foregroundColor: _isStarred ? context.palette.amber.onSolid : context.palette.amber.solid,
      onPressed: () => context.read<MarkingBloc>().add(const MarkingStarToggled()),
    );
  }
}
