import 'package:core/security/recovery_code.dart';
import 'package:core/theme/spacing.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:shared/presentation/extensions/context_extensions.dart';

const _columns = 2;
const _chipHeight = 46.0;
const _chipRadius = 14.0;
const _codeLetterSpacing = 0.1;
const _codeFontSize = 18.0;
const _aspectDivisor = 2.6;
const _focusBorderWidth = 1.8;
const _placeholder = "····";

class const RecoveryCodeInputGrid({
  required final ValueChanged<String> _onChanged,
  required final bool _isEnabled,
  super.key,
}) extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final controllers = useMemoized(
      () => List.generate(RecoveryCode.groupCount, (_) => TextEditingController()),
    );
    final focusNodes = useMemoized(
      () => List.generate(RecoveryCode.groupCount, (_) => FocusNode()),
    );
    useEffect(
      () => () {
        for (final controller in controllers) {
          controller.dispose();
        }
        for (final node in focusNodes) {
          node.dispose();
        }
      },
      const [],
    );

    // * spilled forward rather than truncated, so pasting the whole code into
    // * any group fills the rest of them
    void handleChanged(int index, String value) {
      var cursor = index;
      var rest = RecoveryCode.normalise(value);
      while (true) {
        final take = rest.length < RecoveryCode.groupSize ? rest.length : RecoveryCode.groupSize;
        controllers[cursor].value = TextEditingValue(
          text: rest.substring(0, take),
          selection: TextSelection.collapsed(offset: take),
        );
        rest = rest.substring(take);
        if (rest.isEmpty || cursor + 1 >= RecoveryCode.groupCount) break;
        cursor += 1;
      }
      if (controllers.every((controller) => controller.text.length == RecoveryCode.groupSize)) {
        // * complete, so getting the keyboard out of the way puts the button
        // * back on screen instead of leaving it under 238px of keys
        FocusScope.of(context).unfocus();
      } else if (controllers[cursor].text.length == RecoveryCode.groupSize &&
          cursor + 1 < RecoveryCode.groupCount) {
        focusNodes[cursor + 1].requestFocus();
      }
      _onChanged(controllers.map((controller) => controller.text).join());
    }

    void stepBack(int index) {
      final previous = controllers[index - 1];
      focusNodes[index - 1].requestFocus();
      previous.selection = TextSelection.collapsed(offset: previous.text.length);
    }

    return Container(
      padding: const EdgeInsets.all(Spacing.s),
      decoration: BoxDecoration(
        color: context.c.surfaceContainer,
        borderRadius: const BorderRadius.all(Radius.circular(Spacing.radiusXxl)),
      ),
      child: GridView.count(
        crossAxisCount: _columns,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        mainAxisSpacing: Spacing.xxs,
        crossAxisSpacing: Spacing.xxs,
        childAspectRatio: RecoveryCode.groupCount / _aspectDivisor,
        children: [
          for (var index = 0; index < RecoveryCode.groupCount; index += 1)
            _CodeField(
              controller: controllers[index],
              focusNode: focusNodes[index],
              isEnabled: _isEnabled,
              isLast: index == RecoveryCode.groupCount - 1,
              onChanged: (value) => handleChanged(index, value),
              onBackspaceOnEmpty: index == 0 ? null : () => stepBack(index),
            ),
        ],
      ),
    );
  }
}

class const _CodeField({
  required final TextEditingController _controller,
  required final FocusNode _focusNode,
  required final bool _isEnabled,
  required final bool _isLast,
  required final ValueChanged<String> _onChanged,
  required final VoidCallback? _onBackspaceOnEmpty,
}) extends HookWidget {
  @override
  Widget build(BuildContext context) {
    useListenable(_controller);
    useListenable(_focusNode);
    final style = TextStyle(
      fontFamily: "monospace",
      fontFamilyFallback: const ["Menlo", "Roboto Mono", "Courier New"],
      fontSize: _codeFontSize,
      fontWeight: FontWeight.w600,
      letterSpacing: _codeFontSize * _codeLetterSpacing,
      color: context.palette.paperText,
    );
    return Container(
      height: _chipHeight,
      decoration: BoxDecoration(
        color: context.palette.paperFill,
        borderRadius: const BorderRadius.all(Radius.circular(_chipRadius)),
        border: _focusNode.hasFocus
            ? Border.all(color: context.c.onSurface, width: _focusBorderWidth)
            : null,
      ),
      child: _Backspacer(
        onBackspaceOnEmpty: _onBackspaceOnEmpty,
        isEmpty: _controller.text.isEmpty,
        child: TextField(
          controller: _controller,
          focusNode: _focusNode,
          enabled: _isEnabled,
          onChanged: _onChanged,
          textAlign: TextAlign.center,
          textCapitalization: TextCapitalization.characters,
          autocorrect: false,
          enableSuggestions: false,
          textInputAction: _isLast ? TextInputAction.done : TextInputAction.next,
          style: style,
          cursorColor: context.palette.paperText,
          decoration: InputDecoration(
            border: InputBorder.none,
            focusedBorder: InputBorder.none,
            enabledBorder: InputBorder.none,
            disabledBorder: InputBorder.none,
            isCollapsed: true,
            hintText: _placeholder,
            hintStyle: style.copyWith(color: context.palette.paperTextFaint),
          ),
        ),
      ),
    );
  }
}

// * a soft keyboard sends no change event for backspace in an already empty
// * field, so stepping back a group has to come from the key itself
class const _Backspacer({
  required final Widget _child,
  required final bool _isEmpty,
  required final VoidCallback? _onBackspaceOnEmpty,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final onBackspace = _onBackspaceOnEmpty;
    if (onBackspace == null) return _child;
    return Focus(
      onKeyEvent: (node, event) {
        if (event is KeyDownEvent && event.logicalKey == LogicalKeyboardKey.backspace && _isEmpty) {
          onBackspace();
          return KeyEventResult.handled;
        }
        return KeyEventResult.ignored;
      },
      child: _child,
    );
  }
}
