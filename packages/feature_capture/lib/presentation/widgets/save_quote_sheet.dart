import 'package:core/theme/spacing.dart';
import 'package:core/theme/theme_extensions.dart';
import 'package:feature_capture/presentation/marking/marking_bloc.dart';
import 'package:feature_capture/presentation/marking/marking_event.dart';
import 'package:feature_capture/presentation/marking/marking_state.dart';
import 'package:feature_capture/presentation/widgets/book_picker_field.dart';
import 'package:feature_capture/presentation/widgets/book_picker_sheet.dart';
import 'package:feature_capture/presentation/widgets/quote_edit_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:shared/domain/entities/quote_theme.dart';
import 'package:shared/presentation/extensions/context_extensions.dart';
import 'package:shared/presentation/navigation/navigation_extensions.dart';
import 'package:shared/presentation/widgets/circle_icon_button.dart';
import 'package:shared/presentation/widgets/ink_tap_box.dart';
import 'package:shared/presentation/widgets/name_input_dialog.dart';
import 'package:shared/presentation/widgets/page_number_field.dart';
import 'package:shared/presentation/widgets/selectable_chip.dart';
import 'package:shared/presentation/widgets/sheet_drag_handle.dart';
import 'package:shared/presentation/widgets/voice_note_recorder.dart';

const _sheetMaxSize = 0.95;
const _closeButtonSize = 36.0;
const _actionButtonSize = 56.0;
const _fieldGap = Spacing.xxxs;
const _noteMinLines = 1;
const _noteMaxLines = 4;

Future<void> showSaveQuoteSheet(BuildContext context) async {
  final bloc = context.read<MarkingBloc>();
  await showModalBottomSheet<void>(
    context: context,
    isScrollControlled: true,
    useRootNavigator: true,
    backgroundColor: Colors.transparent,
    showDragHandle: false,
    builder: (_) => BlocProvider.value(value: bloc, child: const _SaveQuoteSheet()),
  );
  if (bloc.state case MarkingSaved(:final isEditing) when context.mounted) {
    context.showToast(context.s.markingSavedMessage);
    if (isEditing) {
      context.closeScreen();
      return;
    }
    context.goLibrary();
  }
}

class const _SaveQuoteSheet() extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bottomInset = MediaQuery.viewInsetsOf(context).bottom;
    // * the sheet wraps its content and only starts scrolling once it would outgrow the screen
    final available = (MediaQuery.sizeOf(context).height - bottomInset) * _sheetMaxSize;
    return Padding(
      padding: EdgeInsets.only(bottom: bottomInset),
      child: ConstrainedBox(
        constraints: BoxConstraints(maxHeight: available),
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: context.c.surfaceContainerLowest,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(Spacing.radiusXxl)),
          ),
          child: BlocConsumer<MarkingBloc, MarkingState>(
            listenWhen: (previous, current) => current is MarkingSaved,
            listener: (context, state) => Navigator.of(context).pop(),
            builder: (context, state) => switch (state) {
              MarkingReady() => _Form(state: state),
              _ => const SizedBox.shrink(),
            },
          ),
        ),
      ),
    );
  }
}

class const _Form({
  required final MarkingReady _state,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final unsureCount = _state.uncertainQuoteRanges.length;
    final quoteBlock = <Widget>[
      QuoteEditCard(
        text: _state.quote,
        uncertainRanges: _state.uncertainQuoteRanges,
        onChanged: (value) => context.read<MarkingBloc>().add(MarkingQuoteEdited(value)),
      ),
      if (unsureCount > 0) ...[
        const SizedBox(height: Spacing.s),
        _UnsureHint(count: unsureCount),
      ],
    ];
    final sourceBlock = <Widget>[
      _SourceRow(state: _state),
      const SizedBox(height: Spacing.s),
      VoiceNoteRecorder(
        path: _state.voiceNotePath,
        durationMs: _state.voiceNoteDurationMs,
        onRecorded: (path, durationMs) => context.read<MarkingBloc>().add(
          MarkingVoiceNoteRecorded(path, durationMs),
        ),
        onCleared: () => context.read<MarkingBloc>().add(const MarkingVoiceNoteCleared()),
      ),
    ];
    final note = _NoteField(initialText: _state.note ?? "");
    final tailBlock = <Widget>[
      _ThemeChips(themes: _state.availableThemes, selected: _state.selectedThemeIds),
      const SizedBox(height: Spacing.m),
      _Actions(state: _state),
    ];
    return SafeArea(
      top: false,
      child: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(Spacing.l, Spacing.xs, Spacing.l, Spacing.s),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SheetDragHandle(),
            const SizedBox(height: Spacing.m),
            const _Header(),
            const SizedBox(height: Spacing.m),
            if (context.layout.isLandscape)
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        ...quoteBlock,
                        const SizedBox(height: Spacing.m),
                        note,
                      ],
                    ),
                  ),
                  const SizedBox(width: Spacing.l),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        ...sourceBlock,
                        const SizedBox(height: Spacing.s),
                        ...tailBlock,
                      ],
                    ),
                  ),
                ],
              )
            else ...[
              ...quoteBlock,
              const SizedBox(height: Spacing.m),
              ...sourceBlock,
              const SizedBox(height: Spacing.s),
              note,
              const SizedBox(height: Spacing.s),
              ...tailBlock,
            ],
          ],
        ),
      ),
    );
  }
}

class const _Header() extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Text(context.s.markingSaveSheetTitle, style: context.t.titleLarge),
        ),
        const SizedBox(width: Spacing.s),
        CircleIconButton(
          icon: Icons.close,
          tooltip: context.s.close,
          size: _closeButtonSize,
          iconSize: Spacing.iconS,
          foregroundColor: context.c.onSurfaceVariant,
          onPressed: () => Navigator.of(context).pop(),
        ),
      ],
    );
  }
}

class const _SourceRow({
  required final MarkingReady _state,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: BookPickerField(
              title: _state.bookTitle,
              coverImage: _state.bookCoverImage,
              onTap: () => showBookPickerSheet(context),
            ),
          ),
          const SizedBox(width: _fieldGap),
          PageNumberField(
            pages: _state.pageNumbers,
            onChanged: (pages) => context.read<MarkingBloc>().add(
              MarkingPageNumbersChanged(pages),
            ),
          ),
        ],
      ),
    );
  }
}

class const _UnsureHint({
  required final int _count,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final color = context.status.uncertain.solid;
    return Row(
      children: [
        Icon(Icons.warning_rounded, size: Spacing.iconS, color: color),
        const SizedBox(width: Spacing.xs),
        Expanded(
          child: Text(
            context.s.markingUnsureWordsLabel(_count),
            style: context.t.labelMedium?.copyWith(color: color),
          ),
        ),
      ],
    );
  }
}

class const _NoteField({
  required final String _initialText,
}) extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final controller = useTextEditingController(text: _initialText);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: Spacing.m, vertical: Spacing.s),
      decoration: BoxDecoration(
        color: context.c.surfaceContainerHigh,
        borderRadius: BorderRadius.circular(Spacing.radiusL),
      ),
      child: TextField(
        controller: controller,
        minLines: _noteMinLines,
        maxLines: _noteMaxLines,
        textCapitalization: TextCapitalization.sentences,
        style: context.typography.readingBody,
        onChanged: (value) => context.read<MarkingBloc>().add(MarkingNoteChanged(value)),
        decoration: InputDecoration(
          isDense: true,
          filled: false,
          border: InputBorder.none,
          enabledBorder: InputBorder.none,
          focusedBorder: InputBorder.none,
          contentPadding: EdgeInsets.zero,
          hintText: context.s.markingNoteHint,
          hintStyle: context.typography.readingBody.copyWith(
            color: context.palette.paperTextFaint,
          ),
        ),
      ),
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
          outlined: true,
          onTap: () => _promptNewTheme(context),
        ),
      ],
    );
  }
}

Future<void> _promptNewTheme(BuildContext context) async {
  final bloc = context.read<MarkingBloc>();
  final name = await showNameInputDialog(
    context,
    title: context.s.themesNewThemeTitle,
    hint: context.s.themesNewThemeHint,
  );
  if (name != null && name.trim().isNotEmpty) bloc.add(MarkingThemeCreateRequested(name));
}

class const _Actions({
  required final MarkingReady _state,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _FavoriteButton(isFavorite: _state.isFavorite),
        const SizedBox(width: Spacing.s),
        Expanded(
          child: FilledButton(
            style: FilledButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(Spacing.radiusL),
              ),
            ),
            onPressed: _state.isSaving || _state.bookId == null
                ? null
                : () => context.read<MarkingBloc>().add(const MarkingSaveRequested()),
            child: _state.isSaving
                ? const SizedBox(
                    height: Spacing.iconM,
                    width: Spacing.iconM,
                    child: CircularProgressIndicator(strokeWidth: Spacing.borderWidthMedium),
                  )
                : Text(context.s.markingSaveButton),
          ),
        ),
      ],
    );
  }
}

class const _FavoriteButton({
  required final bool _isFavorite,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: context.s.quoteDetailFavoriteLabel,
      child: SizedBox.square(
        dimension: _actionButtonSize,
        child: InkTapBox(
          onTap: () => context.read<MarkingBloc>().add(const MarkingFavoriteToggled()),
          color: _isFavorite ? context.c.primary : context.c.surfaceContainerHigh,
          radius: Spacing.radiusL,
          child: Icon(
            Icons.star_rounded,
            size: Spacing.iconM,
            semanticLabel: context.s.quoteDetailFavoriteLabel,
            color: _isFavorite
                ? context.c.onPrimary
                : context.palette.resolve(AccentColor.amber).onFillVariant,
          ),
        ),
      ),
    );
  }
}
