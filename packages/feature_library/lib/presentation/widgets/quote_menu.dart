import 'package:feature_library/presentation/quote_detail/quote_detail_bloc.dart';
import 'package:feature_library/presentation/quote_detail/quote_detail_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared/domain/entities/captured_shot.dart';
import 'package:shared/domain/entities/page_quad.dart';
import 'package:shared/domain/entities/quote.dart';
import 'package:shared/presentation/extensions/context_extensions.dart';
import 'package:shared/presentation/navigation/marking_arguments.dart';
import 'package:shared/presentation/navigation/navigation_extensions.dart';
import 'package:shared/presentation/widgets/confirm_dialog.dart';
import 'package:shared/presentation/widgets/sheet_action_tile.dart';
import 'package:shared/presentation/widgets/sheet_content.dart';

enum _QuoteMenuAction { edit, delete }

Future<void> showQuoteMenu(BuildContext context, Quote quote) async {
  final action = await showModalBottomSheet<_QuoteMenuAction>(
    context: context,
    isScrollControlled: true,
    useRootNavigator: true,
    builder: (_) => _QuoteMenu(canEdit: quote.pages.isNotEmpty),
  );
  if (action == null || !context.mounted) return;
  switch (action) {
    case _QuoteMenuAction.edit:
      await _editQuote(context, quote);
    case _QuoteMenuAction.delete:
      await _deleteQuote(context);
  }
}

Future<void> _editQuote(BuildContext context, Quote quote) async {
  final bloc = context.read<QuoteDetailBloc>();
  await context.pushMarking(
    MarkingArguments(
      shots: [
        for (final page in quote.pages)
          CapturedShot(imagePath: page.photoPath, pageQuad: fullFramePageQuad),
      ],
      bookId: quote.bookId,
      quote: quote,
    ),
  );
  bloc.add(const QuoteDetailStarted());
}

Future<void> _deleteQuote(BuildContext context) async {
  final bloc = context.read<QuoteDetailBloc>();
  final confirmed = await showConfirmDialog(
    context,
    title: context.s.quoteDeleteTitle,
    message: context.s.quoteDeleteMessage,
    confirmLabel: context.s.commonDelete,
    destructive: true,
  );
  if (confirmed) bloc.add(const QuoteDetailDeleteRequested());
}

class const _QuoteMenu({
  required final bool _canEdit,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SheetContent(
      children: [
        if (_canEdit)
          SheetActionTile(
            icon: Icons.edit_outlined,
            label: context.s.quoteEditAction,
            onTap: () => Navigator.of(context).pop(_QuoteMenuAction.edit),
          ),
        SheetActionTile(
          icon: Icons.delete_outline,
          label: context.s.quoteDeleteAction,
          destructive: true,
          onTap: () => Navigator.of(context).pop(_QuoteMenuAction.delete),
        ),
      ],
    );
  }
}
