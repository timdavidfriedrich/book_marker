import 'package:core/theme/corner_radii.dart';
import 'package:core/theme/spacing.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:shared/presentation/extensions/context_extensions.dart';
import 'package:shared/presentation/widgets/adaptive_actions.dart';
import 'package:shared/presentation/widgets/ink_tap_box.dart';

const _groupRadius = Spacing.radiusXl;
const _groupGap = Spacing.xxxs;
const _tilePadding = EdgeInsets.all(Spacing.m);
const _actionsGap = Spacing.l * 2;

Future<bool?> showSignOutDialog(BuildContext context) {
  return showDialog<bool>(
    context: context,
    builder: (_) => Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: Spacing.dialogMaxWidth),
        child: const _SignOutDialog(),
      ),
    ),
  );
}

class const _SignOutDialog() extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final removesLocalData = useState(false);
    final controller = useTextEditingController();
    final typed = useValueListenable(controller).text;
    final word = context.s.signOutConfirmWord;
    // * exact match, case sensitive: the whole point is that it cannot be
    // * dismissed by reflex
    final canRemove = typed == word;

    return Dialog(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(Spacing.l),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(context.s.signOutTitle, style: context.t.headlineSmall),
            const SizedBox(height: Spacing.s),
            Text(
              context.s.signOutQuestion,
              style: context.t.bodyMedium?.copyWith(color: context.c.onSurfaceVariant),
            ),
            const SizedBox(height: Spacing.m),
            _Choice(
              title: context.s.signOutKeepTitle,
              body: context.s.signOutKeepBody,
              isSelected: !removesLocalData.value,
              isFirst: true,
              isLast: false,
              onTap: () => removesLocalData.value = false,
            ),
            const SizedBox(height: _groupGap),
            _Choice(
              title: context.s.signOutRemoveTitle,
              body: context.s.signOutRemoveBody,
              warning: removesLocalData.value ? context.s.signOutRemoveWarning : null,
              isSelected: removesLocalData.value,
              isFirst: false,
              isLast: true,
              isDestructive: true,
              onTap: () => removesLocalData.value = true,
            ),
            if (removesLocalData.value) ...[
              const SizedBox(height: Spacing.m),
              Text(
                context.s.signOutConfirmHint(word),
                style: context.t.bodySmall?.copyWith(color: context.c.onSurfaceVariant),
              ),
              const SizedBox(height: Spacing.xs),
              TextField(
                controller: controller,
                autocorrect: false,
                enableSuggestions: false,
                textCapitalization: TextCapitalization.characters,
                decoration: InputDecoration(
                  hintText: word,
                  suffixIcon: canRemove
                      ? Icon(Icons.check, color: context.c.primary, size: Spacing.iconM)
                      : null,
                ),
              ),
            ],
            const SizedBox(height: _actionsGap),
            AdaptiveActions(
              children: [
                OutlinedButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: Text(context.s.cancel),
                ),
                FilledButton(
                  onPressed: removesLocalData.value && !canRemove
                      ? null
                      : () => Navigator.of(context).pop(removesLocalData.value),
                  style: removesLocalData.value
                      ? FilledButton.styleFrom(
                          backgroundColor: context.c.error,
                          foregroundColor: context.c.onError,
                        )
                      : null,
                  child: Text(
                    removesLocalData.value ? context.s.signOutRemoveAction : context.s.signOutTitle,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class const _Choice({
  required final String _title,
  required final String _body,
  required final bool _isSelected,
  required final bool _isFirst,
  required final bool _isLast,
  required final VoidCallback _onTap,
  final String? _warning,
  final bool _isDestructive = false,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final isAlarming = _isDestructive && _isSelected;
    final foreground = isAlarming ? context.c.onErrorContainer : context.c.onSurface;
    return InkTapBox(
      onTap: _onTap,
      color: isAlarming ? context.c.errorContainer : context.c.surfaceContainer,
      shape: RoundedRectangleBorder(
        borderRadius: CornerRadii.grouped(
          outer: _groupRadius,
          isFirst: _isFirst,
          isLast: _isLast,
        ),
      ),
      padding: _tilePadding,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            _isSelected ? Icons.radio_button_checked : Icons.radio_button_unchecked,
            size: Spacing.iconM,
            color: foreground,
          ),
          const SizedBox(width: Spacing.m),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(_title, style: context.t.titleSmall?.copyWith(color: foreground)),
                const SizedBox(height: Spacing.xxxs),
                Text(
                  _body,
                  style: context.t.bodySmall?.copyWith(
                    color: isAlarming ? foreground : context.c.onSurfaceVariant,
                  ),
                ),
                if (_warning case final warning?) ...[
                  const SizedBox(height: Spacing.xs),
                  Text(
                    warning,
                    style: context.t.bodySmall?.copyWith(color: foreground),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}
