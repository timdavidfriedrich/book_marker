import 'package:core/theme/spacing.dart';
import 'package:feature_capture/domain/uncertain_ranges.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:shared/presentation/extensions/context_extensions.dart';
import 'package:shared/presentation/widgets/quote_paper_card.dart';

const _quoteLineHeight = 1.55;
const _quoteMaxLines = 8;

class const QuoteEditCard({
  required final String _text,
  required final List<(int, int)> _uncertainRanges,
  required final ValueChanged<String> _onChanged,
  super.key,
}) extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final controller = _useUncertainTextController(_text);
    // * the controller tracks its own edits, so the bloc only resyncs once both agree on the text
    if (controller.text == _text) controller.uncertainRanges = _uncertainRanges;
    return QuotePaperCard(
      child: TextField(
        controller: controller,
        minLines: 1,
        maxLines: _quoteMaxLines,
        textCapitalization: TextCapitalization.sentences,
        style: context.typography.readingQuoteItalic.copyWith(
          color: context.palette.paperText,
          height: _quoteLineHeight,
        ),
        onChanged: _onChanged,
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
  }
}

_UncertainTextController _useUncertainTextController(String text) {
  final controller = useMemoized(() => _UncertainTextController()..text = text);
  useEffect(() => controller.dispose, [controller]);
  return controller;
}

class _UncertainTextController() extends TextEditingController {
  List<(int, int)> uncertainRanges = const [];

  @override
  set value(TextEditingValue newValue) {
    if (newValue.text != text) {
      uncertainRanges = remapUncertainRanges(
        uncertainRanges,
        previous: text,
        next: newValue.text,
      );
    }
    super.value = newValue;
  }

  @override
  TextSpan buildTextSpan({
    required BuildContext context,
    TextStyle? style,
    required bool withComposing,
  }) {
    final marks = uncertainRanges;
    if (marks.isEmpty) {
      return super.buildTextSpan(context: context, style: style, withComposing: withComposing);
    }
    final marked = (style ?? const TextStyle()).copyWith(
      decoration: TextDecoration.underline,
      decorationStyle: TextDecorationStyle.dotted,
      decorationColor: context.status.uncertain.solid,
      decorationThickness: Spacing.borderWidthMedium,
    );
    final spans = <TextSpan>[];
    var offset = 0;
    for (final (start, end) in marks) {
      if (start < offset || end <= start || end > text.length) continue;
      if (start > offset) spans.add(TextSpan(text: text.substring(offset, start)));
      spans.add(TextSpan(text: text.substring(start, end), style: marked));
      offset = end;
    }
    if (offset < text.length) spans.add(TextSpan(text: text.substring(offset)));
    return TextSpan(style: style, children: spans);
  }
}
