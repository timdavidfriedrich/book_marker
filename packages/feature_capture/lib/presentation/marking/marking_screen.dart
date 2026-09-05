import 'package:core/theme/spacing.dart';
import 'package:feature_capture/presentation/marking/marking_bloc.dart';
import 'package:feature_capture/presentation/marking/marking_event.dart';
import 'package:feature_capture/presentation/marking/marking_state.dart';
import 'package:feature_capture/presentation/widgets/book_picker_field.dart';
import 'package:feature_capture/presentation/widgets/book_picker_sheet.dart';
import 'package:feature_capture/presentation/widgets/photo_marking_view.dart';
import 'package:feature_capture/presentation/widgets/save_quote_sheet.dart';
import 'package:feature_capture/presentation/widgets/uncertain_word_chip.dart';
import 'package:feature_capture/presentation/widgets/word_correction_sheet.dart';
import 'package:feature_capture/presentation/widgets/word_selection_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:shared/presentation/extensions/app_error_extensions.dart';
import 'package:shared/presentation/extensions/context_extensions.dart';
import 'package:shared/presentation/navigation/navigation_extensions.dart';
import 'package:shared/presentation/widgets/circle_icon_button.dart';
import 'package:shared/presentation/widgets/loading_screen.dart';
import 'package:shared/presentation/widgets/page_pill.dart';
import 'package:shared/presentation/widgets/paper_card.dart';
import 'package:shared/presentation/widgets/segmented_toggle.dart';

const _legendSampleWidth = 28.0;
const _legendSampleHeight = 16.0;
const _sideColumnWidth = 320.0;

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
    final page = PaperCard(
      padding: const EdgeInsets.all(Spacing.m),
      child: IndexedStack(
        index: mode.value,
        sizing: StackFit.expand,
        children: [
          _ReadingText(state: _state),
          PhotoMarkingView(
            pages: _state.pages,
            words: _state.words,
            selectedWordIndexes: _state.selectedWordIndexes,
            onUncertainWordTap: (wordIndex) =>
                showWordCorrectionSheet(context, wordIndex: wordIndex),
          ),
        ],
      ),
    );
    final chooser = BookPickerField(
      title: _state.bookTitle,
      coverImage: _state.bookCoverImage,
      onTap: () => showBookPickerSheet(context),
    );
    final continueButton = FilledButton(
      onPressed: canContinue ? () => showSaveQuoteSheet(context) : null,
      child: Text(context.s.markingContinueButton),
    );
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
                  if (_state.hasUncertainWords) ...[
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
          if (_state.hasUncertainWords) ...[
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
    return Row(
      children: [
        CircleIconButton(
          icon: Icons.arrow_back,
          tooltip: context.s.back,
          onPressed: context.closeScreen,
        ),
        const Spacer(),
        if (_state.pageNumbers.isNotEmpty) PagePill(pages: _state.pageNumbers),
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
