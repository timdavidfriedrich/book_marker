import 'dart:async';

import 'package:core/config/build_config.dart';
import 'package:core/error/app_error.dart';
import 'package:core/theme/spacing.dart';
import 'package:feature_account/presentation/widgets/ink_action_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared/presentation/account/account_bloc.dart';
import 'package:shared/presentation/account/account_event.dart';
import 'package:shared/presentation/account/account_state.dart';
import 'package:shared/presentation/extensions/app_error_extensions.dart';
import 'package:shared/presentation/extensions/context_extensions.dart';
import 'package:shared/presentation/extensions/screen_layout_extensions.dart';
import 'package:shared/presentation/navigation/navigation_extensions.dart';
import 'package:shared/presentation/navigation/routes.dart';
import 'package:shared/presentation/widgets/circle_icon_button.dart';

const _leadSpacing = Spacing.l;
const _actionGap = Spacing.xs;
const _disabledOpacity = 0.45;

class const SignInScreen({
  super.key,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocConsumer<AccountBloc, AccountState>(
          // * signing in leaves this state entirely, so anything that is not
          // * signedOut means we are done and should return to settings
          listenWhen: (previous, current) => current is! AccountSignedOut,
          listener: (context, state) {
            context.closeScreen();
            // * locked straight after signing in means there is no key on this
            // * device yet, so the code has to be generated before anything can
            // * be secured
            if (state is AccountLocked) {
              unawaited(context.appRouter.push(const RecoveryCodeSetup()));
            }
          },
          builder: (context, state) => _Content(
            pendingProvider: state is AccountSignedOut ? state.pendingProvider : null,
            error: state is AccountSignedOut ? state.error : null,
          ),
        ),
      ),
    );
  }
}

class const _Content({
  required final SignInProvider? _pendingProvider,
  required final Object? _error,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final error = _error;
    final isSigningIn = _pendingProvider != null;
    return ListView(
      padding: EdgeInsets.all(context.layout.pageMargin),
      children: [
        Align(
          alignment: AlignmentDirectional.centerStart,
          child: CircleIconButton(
            icon: Icons.arrow_back,
            onPressed: isSigningIn ? null : context.closeScreen,
          ),
        ),
        const SizedBox(height: Spacing.m),
        Text(context.s.signInTitle, style: context.t.displaySmall),
        const SizedBox(height: Spacing.s),
        Text(
          context.s.signInLead,
          style: context.typography.readingQuoteItalic.copyWith(
            color: context.c.onSurfaceVariant,
          ),
        ),
        const SizedBox(height: _leadSpacing),
        if (error is AppError) ...[
          _ErrorNotice(message: error.toMessage(context)),
          const SizedBox(height: Spacing.m),
        ],
        Opacity(
          opacity: isSigningIn ? _disabledOpacity : 1,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              InkActionButton(
                glyph: Icons.account_circle_outlined,
                isBusy: _pendingProvider == SignInProvider.google,
                label: switch ((_pendingProvider, error)) {
                  (SignInProvider.google, _) => context.s.signInInProgress,
                  (_, null) => context.s.signInWithGoogle,
                  _ => context.s.signInRetry,
                },
                onPressed: isSigningIn
                    ? null
                    : () => context.read<AccountBloc>().add(
                        const AccountGoogleSignInRequested(),
                      ),
              ),
              // * only offered once Apple credentials exist; a button that
              // * always fails is worse than no button
              if (hasAppleSignIn) ...[
                const SizedBox(height: _actionGap),
                InkActionButton(
                  glyph: Icons.apple,
                  isBusy: _pendingProvider == SignInProvider.apple,
                  label: _pendingProvider == SignInProvider.apple
                      ? context.s.signInInProgress
                      : context.s.signInWithApple,
                  isOutlined: true,
                  onPressed: isSigningIn
                      ? null
                      : () => context.read<AccountBloc>().add(
                          const AccountAppleSignInRequested(),
                        ),
                ),
              ],
            ],
          ),
        ),
      ],
    );
  }
}

class const _ErrorNotice({
  required final String _message,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(Spacing.m),
      decoration: BoxDecoration(
        color: context.c.errorContainer,
        borderRadius: const BorderRadius.all(Radius.circular(Spacing.radiusL)),
      ),
      child: Text(
        _message,
        style: context.t.bodyMedium?.copyWith(color: context.c.onErrorContainer),
      ),
    );
  }
}
