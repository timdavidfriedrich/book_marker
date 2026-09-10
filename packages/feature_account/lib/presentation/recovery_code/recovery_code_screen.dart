import 'dart:async';

import 'package:core/theme/spacing.dart';
import 'package:core/theme/theme_extensions.dart';
import 'package:feature_account/presentation/recovery_code/recovery_code_bloc.dart';
import 'package:feature_account/presentation/recovery_code/recovery_code_event.dart';
import 'package:feature_account/presentation/recovery_code/recovery_code_state.dart';
import 'package:feature_account/presentation/widgets/ink_action_button.dart';
import 'package:feature_account/presentation/widgets/recovery_code_grid.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared/presentation/account/account_bloc.dart';
import 'package:shared/presentation/account/account_event.dart';
import 'package:shared/presentation/extensions/context_extensions.dart';
import 'package:shared/presentation/extensions/screen_layout_extensions.dart';
import 'package:shared/presentation/navigation/navigation_extensions.dart';
import 'package:shared/presentation/widgets/loading_indicator.dart';

const _shareButtonWidth = 96.0;
const _markerSize = 5.0;
const _markerTopOffset = 7.0;
const _checkboxSize = 22.0;
const _checkboxBorderWidth = 1.8;

class const RecoveryCodeScreen({
  super.key,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // * no back affordance anywhere: leaving is only possible through the
    // * dialog, which is the whole point of this screen
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, _) {
        if (!didPop) unawaited(_confirmLeaving(context));
      },
      child: Scaffold(
        body: SafeArea(
          child: BlocConsumer<RecoveryCodeBloc, RecoveryCodeState>(
            // * the key now exists, but AccountBloc resolved its state before
            // * that, so it has to be asked to look again
            listenWhen: (previous, current) => current is RecoveryCodeReady && current.isStarting,
            listener: (context, state) {
              context.read<AccountBloc>().add(const AccountUnlocked());
              context.closeScreen();
            },
            builder: (context, state) => switch (state) {
              RecoveryCodeGenerating() => const LoadingIndicator(),
              RecoveryCodeReady() => _Content(state: state),
            },
          ),
        ),
      ),
    );
  }
}

Future<void> _confirmLeaving(BuildContext context) async {
  final abort = await showDialog<bool>(
    context: context,
    builder: (dialogContext) => AlertDialog(
      title: Text(dialogContext.s.recoveryCodeLeaveTitle),
      content: Text(dialogContext.s.recoveryCodeLeaveMessage),
      actions: [
        FilledButton(
          onPressed: () => Navigator.of(dialogContext).pop(false),
          child: Text(dialogContext.s.recoveryCodeLeaveBack),
        ),
        TextButton(
          onPressed: () => Navigator.of(dialogContext).pop(true),
          child: Text(
            dialogContext.s.recoveryCodeLeaveAbort,
            style: TextStyle(color: dialogContext.c.error),
          ),
        ),
      ],
    ),
  );
  if ((abort ?? false) && context.mounted) Navigator.of(context).pop();
}

class const _Content({
  required final RecoveryCodeReady _state,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bloc = context.read<RecoveryCodeBloc>();
    return ListView(
      padding: EdgeInsets.all(context.layout.pageMargin),
      children: [
        Text(context.s.recoveryCodeTitle, style: context.t.displaySmall),
        const SizedBox(height: Spacing.s),
        Text(
          context.s.recoveryCodeLead,
          style: context.typography.readingQuoteItalic.copyWith(
            color: context.c.onSurfaceVariant,
          ),
        ),
        const SizedBox(height: Spacing.l),
        RecoveryCodeGrid(groups: _state.groups),
        const SizedBox(height: Spacing.xs),
        Row(
          children: [
            Expanded(
              child: InkActionButton(
                glyph: _state.isCopied ? Icons.check : Icons.copy_outlined,
                label: _state.isCopied ? context.s.recoveryCodeCopied : context.s.recoveryCodeCopy,
                isOutlined: _state.isCopied,
                onPressed: () => bloc.add(const RecoveryCodeCopied()),
              ),
            ),
            const SizedBox(width: Spacing.xxs),
            SizedBox(
              width: _shareButtonWidth,
              child: InkActionButton(
                label: context.s.recoveryCodeShare,
                isOutlined: true,
                onPressed: null,
              ),
            ),
          ],
        ),
        const SizedBox(height: Spacing.m),
        _ConsequenceBlock(isCopied: _state.isCopied),
        const SizedBox(height: Spacing.m),
        _ConfirmationRow(
          isConfirmed: _state.isConfirmed,
          onToggle: () => bloc.add(const RecoveryCodeConfirmationToggled()),
        ),
        const SizedBox(height: Spacing.m),
        InkActionButton(
          label: _state.isConfirmed ? context.s.recoveryCodeStart : context.s.recoveryCodeContinue,
          onPressed: _state.isConfirmed && !_state.isStarting
              ? () => bloc.add(const RecoveryCodeAccepted())
              : null,
        ),
      ],
    );
  }
}

class const _ConsequenceBlock({
  required final bool _isCopied,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final amber = context.palette.resolve(AccentColor.amber);
    return Container(
      padding: const EdgeInsets.all(Spacing.m),
      decoration: BoxDecoration(
        color: amber.fill,
        borderRadius: const BorderRadius.all(Radius.circular(Spacing.radiusL)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            context.s.recoveryCodeConsequenceTitle,
            style: context.t.titleSmall?.copyWith(color: amber.onFill),
          ),
          const SizedBox(height: Spacing.s),
          if (_isCopied)
            _Marked(text: context.s.recoveryCodeConsequenceClipboard, swatch: amber)
          else ...[
            _Marked(text: context.s.recoveryCodeConsequenceReset, swatch: amber),
            const SizedBox(height: Spacing.xxs),
            _Marked(text: context.s.recoveryCodeConsequenceDevice, swatch: amber),
          ],
        ],
      ),
    );
  }
}

class const _Marked({
  required final String _text,
  required final AccentSwatch _swatch,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: const EdgeInsets.only(top: _markerTopOffset, right: Spacing.s),
          width: _markerSize,
          height: _markerSize,
          decoration: BoxDecoration(
            color: _swatch.onFillVariant,
            shape: BoxShape.circle,
          ),
        ),
        Expanded(
          child: Text(
            _text,
            style: context.t.bodyMedium?.copyWith(color: _swatch.onFill),
          ),
        ),
      ],
    );
  }
}

class const _ConfirmationRow({
  required final bool _isConfirmed,
  required final VoidCallback _onToggle,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Material(
      color: context.c.surfaceContainer,
      borderRadius: const BorderRadius.all(Radius.circular(Spacing.radiusXl)),
      child: InkWell(
        onTap: _onToggle,
        borderRadius: const BorderRadius.all(Radius.circular(Spacing.radiusXl)),
        child: Padding(
          padding: const EdgeInsets.all(Spacing.m),
          child: Row(
            children: [
              Container(
                width: _checkboxSize,
                height: _checkboxSize,
                decoration: BoxDecoration(
                  color: _isConfirmed ? context.c.onSurface : Colors.transparent,
                  border: Border.all(color: context.c.onSurface, width: _checkboxBorderWidth),
                  borderRadius: const BorderRadius.all(Radius.circular(Spacing.radiusXs)),
                ),
                child: _isConfirmed
                    ? Icon(Icons.check, size: Spacing.iconS, color: context.c.surface)
                    : null,
              ),
              const SizedBox(width: Spacing.m),
              Expanded(
                child: Text(context.s.recoveryCodeConfirm, style: context.t.titleSmall),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
