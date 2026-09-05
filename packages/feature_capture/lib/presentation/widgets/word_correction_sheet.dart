import 'package:core/theme/spacing.dart';
import 'package:feature_capture/domain/mark_text.dart';
import 'package:feature_capture/presentation/marking/marking_bloc.dart';
import 'package:feature_capture/presentation/marking/marking_event.dart';
import 'package:feature_capture/presentation/marking/marking_state.dart';
import 'package:feature_capture/presentation/widgets/word_join_row.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:shared/domain/entities/recognized_word_extensions.dart';
import 'package:shared/presentation/extensions/context_extensions.dart';
import 'package:shared/presentation/widgets/circle_icon_button.dart';
import 'package:shared/presentation/widgets/sheet_drag_handle.dart';

const _fieldActionSize = 30.0;
const _fieldActionIconSize = 16.0;

Future<void> showWordCorrectionSheet(BuildContext context, {required int wordIndex}) async {
  final bloc = context.read<MarkingBloc>();
  final applied = await showModalBottomSheet<bool>(
    context: context,
    isScrollControlled: true,
    useRootNavigator: true,
    backgroundColor: Colors.transparent,
    showDragHandle: false,
    builder: (_) => BlocProvider.value(
      value: bloc,
      child: _WordCorrectionSheet(wordIndex: wordIndex),
    ),
  );
  if (applied != true || !context.mounted) return;
  ScaffoldMessenger.of(context).hideCurrentSnackBar();
  context.showToast(
    context.s.markingCorrectionAppliedMessage,
    action: SnackBarAction(
      label: context.s.undo,
      onPressed: () => bloc.add(const MarkingWordCorrectionUndone()),
    ),
  );
}

class const _WordCorrectionSheet({
  required final int _wordIndex,
}) extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final state = context.read<MarkingBloc>().state;
    if (state is! MarkingReady) return const SizedBox.shrink();
    final words = state.words;
    final group = words.groupAt(_wordIndex);
    if (group == null) return const SizedBox.shrink();
    final first = group.indexes.first;
    final last = group.indexes.last;
    final previous = first > 0 ? words[first - 1] : null;
    final next = last + 1 < words.length ? words[last + 1] : null;
    final controller = useTextEditingController(text: group.text);
    final undoPrevious = useState<String?>(null);
    final undoNext = useState<String?>(null);
    final text = useValueListenable(controller).text.trim();

    void togglePrevious() {
      if (undoPrevious.value case final String restored) {
        controller.text = restored;
        undoPrevious.value = null;
        return;
      }
      if (previous == null) return;
      undoPrevious.value = controller.text;
      controller.text = _joined(previous.text, controller.text);
    }

    void toggleNext() {
      if (undoNext.value case final String restored) {
        controller.text = restored;
        undoNext.value = null;
        return;
      }
      if (next == null) return;
      undoNext.value = controller.text;
      controller.text = _joined(controller.text, next.text);
    }

    void apply() {
      if (text.isEmpty) return;
      context.read<MarkingBloc>().add(
        MarkingWordCorrected(
          undoPrevious.value == null ? first : first - 1,
          undoNext.value == null ? last : last + 1,
          text,
        ),
      );
      Navigator.of(context).pop(true);
    }

    return Padding(
      padding: EdgeInsets.only(bottom: MediaQuery.viewInsetsOf(context).bottom),
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: context.c.surfaceContainerLowest,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(Spacing.radiusXxl)),
        ),
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(Spacing.l, Spacing.xs, Spacing.l, Spacing.l),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SheetDragHandle(),
              const SizedBox(height: Spacing.s),
              _Header(onClose: () => Navigator.of(context).pop()),
              const SizedBox(height: Spacing.l),
              WordJoinRow(
                pages: state.pages,
                words: words,
                indexes: group.indexes,
                joinedPrevious: undoPrevious.value != null,
                joinedNext: undoNext.value != null,
                onPreviousTap: togglePrevious,
                onNextTap: toggleNext,
              ),
              const SizedBox(height: Spacing.s),
              _CorrectionField(
                controller: controller,
                isEmpty: text.isEmpty,
                onClear: controller.clear,
                onSubmitted: apply,
              ),
              const SizedBox(height: Spacing.m),
              FilledButton(
                onPressed: text.isEmpty ? null : apply,
                style: FilledButton.styleFrom(
                  disabledBackgroundColor: context.c.surfaceContainerHigh,
                  disabledForegroundColor: context.c.onSurfaceVariant,
                ),
                child: Text(context.s.markingCorrectionApplyButton),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

String _joined(String head, String tail) => "${lineBreakStem(head, tail) ?? head}$tail";

class const _Header({
  required final VoidCallback _onClose,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Text(context.s.markingCorrectionTitle, style: context.t.titleLarge),
        ),
        const SizedBox(width: Spacing.s),
        CircleIconButton(
          icon: Icons.close,
          tooltip: context.s.close,
          onPressed: _onClose,
        ),
      ],
    );
  }
}

class const _CorrectionField({
  required final TextEditingController _controller,
  required final bool _isEmpty,
  required final VoidCallback _onClear,
  required final VoidCallback _onSubmitted,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(Spacing.m, Spacing.s, Spacing.s, Spacing.s),
      decoration: BoxDecoration(
        color: context.c.surfaceContainerHigh,
        borderRadius: BorderRadius.circular(Spacing.radiusL),
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _controller,
              autofocus: true,
              textInputAction: TextInputAction.done,
              onSubmitted: (_) => _onSubmitted(),
              style: context.typography.readingInput,
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
          if (!_isEmpty) ...[
            const SizedBox(width: Spacing.xs),
            CircleIconButton(
              icon: Icons.close,
              tooltip: context.s.markingCorrectionClearButton,
              size: _fieldActionSize,
              iconSize: _fieldActionIconSize,
              backgroundColor: context.c.surfaceContainerHighest,
              foregroundColor: context.c.onSurfaceVariant,
              onPressed: _onClear,
            ),
          ],
        ],
      ),
    );
  }
}
