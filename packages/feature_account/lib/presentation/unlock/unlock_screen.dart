import 'dart:async';

import 'package:core/security/recovery_code.dart';
import 'package:core/theme/spacing.dart';
import 'package:core/theme/theme_extensions.dart';
import 'package:feature_account/presentation/unlock/unlock_bloc.dart';
import 'package:feature_account/presentation/unlock/unlock_event.dart';
import 'package:feature_account/presentation/unlock/unlock_state.dart';
import 'package:feature_account/presentation/widgets/ink_action_button.dart';
import 'package:feature_account/presentation/widgets/recovery_code_input_grid.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:shared/presentation/account/account_bloc.dart';
import 'package:shared/presentation/account/account_event.dart';
import 'package:shared/presentation/extensions/context_extensions.dart';
import 'package:shared/presentation/extensions/screen_layout_extensions.dart';
import 'package:shared/presentation/navigation/navigation_extensions.dart';
import 'package:shared/presentation/navigation/routes.dart';
import 'package:shared/presentation/widgets/circle_icon_button.dart';
import 'package:shared/presentation/widgets/loading_indicator.dart';

class const UnlockScreen({
  super.key,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocConsumer<UnlockBloc, UnlockState>(
          listenWhen: (previous, current) => current is UnlockSucceeded,
          // * the key now exists, but AccountBloc resolved its state before
          // * that, so it has to be asked to look again
          listener: (context, state) {
            context.read<AccountBloc>().add(const AccountUnlocked());
            context.closeScreen();
          },
          builder: (context, state) => switch (state) {
            UnlockPreparing() || UnlockSucceeded() => const LoadingIndicator(),
            UnlockUnavailable(:final blocker) => _Unavailable(blocker: blocker),
            UnlockReady() => _Content(state: state),
          },
        ),
      ),
    );
  }
}

class const _Content({
  required final UnlockReady _state,
}) extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final code = useState("");
    final isComplete = code.value.length == RecoveryCode.groupCount * RecoveryCode.groupSize;
    return ListView(
      padding: EdgeInsets.all(context.layout.pageMargin),
      children: [
        Align(
          alignment: AlignmentDirectional.centerStart,
          child: CircleIconButton(
            icon: Icons.arrow_back,
            onPressed: _state.isChecking ? null : context.closeScreen,
          ),
        ),
        const SizedBox(height: Spacing.m),
        Text(context.s.unlockTitle, style: context.t.displaySmall),
        const SizedBox(height: Spacing.s),
        Text(
          context.s.unlockLead,
          style: context.typography.readingQuoteItalic.copyWith(
            color: context.c.onSurfaceVariant,
          ),
        ),
        const SizedBox(height: Spacing.l),
        RecoveryCodeInputGrid(
          isEnabled: !_state.isChecking,
          onChanged: (value) => code.value = value,
        ),
        // * neutral chips even after a rejection: naming the failing group would
        // * turn eight independent guesses into eight easy ones
        if (_state.hasFailed) ...[
          const SizedBox(height: Spacing.xs),
          const _ErrorTile(),
        ],
        const SizedBox(height: Spacing.m),
        InkActionButton(
          label: _state.hasFailed ? context.s.unlockRetry : context.s.unlockAction,
          isBusy: _state.isChecking,
          onPressed: isComplete && !_state.isChecking
              ? () => context.read<UnlockBloc>().add(UnlockSubmitted(code.value))
              : null,
        ),
      ],
    );
  }
}

class const _ErrorTile() extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(Spacing.m),
      decoration: BoxDecoration(
        color: context.c.errorContainer,
        borderRadius: const BorderRadius.all(Radius.circular(Spacing.radiusL)),
      ),
      child: Text(
        context.s.unlockWrongCode,
        style: context.t.bodyMedium?.copyWith(color: context.c.onErrorContainer),
      ),
    );
  }
}

class const _Unavailable({
  required final UnlockBlocker _blocker,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final amber = context.palette.resolve(AccentColor.amber);
    final isUnreachable = _blocker == UnlockBlocker.unreachable;
    return ListView(
      padding: EdgeInsets.all(context.layout.pageMargin),
      children: [
        Align(
          alignment: AlignmentDirectional.centerStart,
          child: CircleIconButton(icon: Icons.arrow_back, onPressed: context.closeScreen),
        ),
        const SizedBox(height: Spacing.m),
        Text(context.s.unlockTitle, style: context.t.displaySmall),
        const SizedBox(height: Spacing.l),
        Container(
          padding: const EdgeInsets.all(Spacing.m),
          decoration: BoxDecoration(
            color: amber.fill,
            borderRadius: const BorderRadius.all(Radius.circular(Spacing.radiusL)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                isUnreachable ? context.s.unlockUnreachableTitle : context.s.unlockNoBackupTitle,
                style: context.t.titleSmall?.copyWith(color: amber.onFill),
              ),
              const SizedBox(height: Spacing.s),
              Text(
                isUnreachable ? context.s.unlockUnreachableBody : context.s.unlockNoBackupBody,
                style: context.t.bodyMedium?.copyWith(color: amber.onFill),
              ),
            ],
          ),
        ),
        const SizedBox(height: Spacing.m),
        InkActionButton(
          label: isUnreachable ? context.s.unlockUnreachableAction : context.s.unlockNoBackupAction,
          onPressed: () {
            if (isUnreachable) {
              context.read<UnlockBloc>().add(const UnlockStarted());
              return;
            }
            context.closeScreen();
            unawaited(context.appRouter.push(const RecoveryCodeSetup()));
          },
        ),
      ],
    );
  }
}
