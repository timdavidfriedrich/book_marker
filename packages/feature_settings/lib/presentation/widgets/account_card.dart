import 'package:core/theme/corner_radii.dart';
import 'package:core/theme/spacing.dart';
import 'package:core/theme/theme_extensions.dart';
import 'package:feature_settings/presentation/widgets/sign_out_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared/domain/entities/account.dart';
import 'package:shared/presentation/account/account_bloc.dart';
import 'package:shared/presentation/account/account_event.dart';
import 'package:shared/presentation/account/account_state.dart';
import 'package:shared/presentation/extensions/context_extensions.dart';
import 'package:shared/presentation/navigation/navigation_extensions.dart';
import 'package:shared/presentation/navigation/routes.dart';
import 'package:shared/presentation/widgets/ink_tap_box.dart';

const _groupRadius = Spacing.radiusXl;
const _groupGap = Spacing.xxxs;
const _avatarSize = 56.0;
const _dotSize = 8.0;
const _tilePadding = EdgeInsets.symmetric(horizontal: Spacing.l, vertical: Spacing.m);

// * one card, not a profile card plus an account section: the identity is the
// * same thing whether it came from a local name or from a signed in account
class const AccountCard({
  required final Widget _nameField,
  required final String _stats,
  super.key,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AccountBloc, AccountState>(
      builder: (context, state) {
        final account = state.account;
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _IdentityTile(
              account: account,
              nameField: _nameField,
              stats: _stats,
              isAlone: state is AccountRestoring,
            ),
            ...switch (state) {
              AccountRestoring() => const <Widget>[],
              AccountSignedOut() => const [SizedBox(height: _groupGap), _SignInTile()],
              AccountReady() => const [SizedBox(height: _groupGap), _SyncedTile()],
              AccountLocked() => const [
                SizedBox(height: _groupGap),
                _NoticeTile(isBlocked: false),
              ],
              AccountBlocked(:final reason) => [
                const SizedBox(height: _groupGap),
                _NoticeTile(isBlocked: true, reason: reason),
              ],
            },
            // * always reachable while signed in, and especially while locked or
            // * blocked: those are the states a user can otherwise be stuck in
            if (account != null) ...[
              const SizedBox(height: _groupGap),
              const _SignOutTile(),
            ],
          ],
        );
      },
    );
  }
}

extension on AccountState {
  Account? get account => switch (this) {
    AccountLocked(:final account) ||
    AccountBlocked(:final account) ||
    AccountReady(:final account) => account,
    _ => null,
  };
}

class const _IdentityTile({
  required final Account? _account,
  required final Widget _nameField,
  required final String _stats,
  required final bool _isAlone,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final account = _account;
    return _Tile(
      isFirst: true,
      isLast: _isAlone,
      child: Row(
        children: [
          Container(
            width: _avatarSize,
            height: _avatarSize,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: context.c.surfaceContainerHigh,
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.person_outline,
              size: Spacing.iconL,
              color: context.c.onSurfaceVariant,
            ),
          ),
          const SizedBox(width: Spacing.m),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // * a signed in account owns the name; the editable local one is
                // * only meaningful while there is no account behind it
                if (account?.displayName case final name?)
                  Text(name, style: context.t.titleLarge, overflow: TextOverflow.ellipsis)
                else
                  _nameField,
                const SizedBox(height: Spacing.xxs),
                Text(
                  account?.email ?? _stats,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: context.typography.label.copyWith(color: context.c.onSurfaceVariant),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class const _SignInTile() extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return _Tile(
      isFirst: false,
      isLast: true,
      color: context.c.inverseSurface,
      onTap: () => context.appRouter.push(const SignIn()),
      child: Row(
        children: [
          Expanded(
            child: Text(
              context.s.sicherungSignInCta,
              style: context.t.titleSmall?.copyWith(color: context.c.onInverseSurface),
            ),
          ),
          Icon(Icons.chevron_right, color: context.c.onInverseSurface, size: Spacing.iconM),
        ],
      ),
    );
  }
}

class const _SyncedTile() extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final teal = context.palette.resolve(AccentColor.teal);
    return _Tile(
      isFirst: false,
      isLast: false,
      child: Row(
        children: [
          Container(
            width: _dotSize,
            height: _dotSize,
            decoration: BoxDecoration(color: teal.solid, shape: BoxShape.circle),
          ),
          const SizedBox(width: Spacing.s),
          Expanded(child: Text(context.s.sicherungSecured, style: context.typography.label)),
        ],
      ),
    );
  }
}

class const _SignOutTile() extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return _Tile(
      isFirst: false,
      isLast: true,
      onTap: () async {
        final removesLocalData = await showSignOutDialog(context);
        if (removesLocalData == null || !context.mounted) return;
        context.read<AccountBloc>().add(
          AccountSignOutRequested(removesLocalData: removesLocalData),
        );
      },
      child: Row(
        children: [
          Expanded(
            child: Text(
              context.s.sicherungSignOut,
              style: context.t.titleMedium?.copyWith(color: context.c.error),
            ),
          ),
          Icon(Icons.logout, size: Spacing.iconM, color: context.c.error),
        ],
      ),
    );
  }
}

// * locked and blocked must never share a treatment: one is self serve and says
// * the data is intact, the other points at support and says local use continues
class const _NoticeTile({
  required final bool _isBlocked,
  final String? _reason,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final amber = context.palette.resolve(AccentColor.amber);
    final background = _isBlocked ? context.c.errorContainer : amber.fill;
    final foreground = _isBlocked ? context.c.onErrorContainer : amber.onFill;
    return _Tile(
      isFirst: false,
      isLast: false,
      color: background,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                _isBlocked ? Icons.block : Icons.lock_outline,
                size: Spacing.iconS,
                color: foreground,
              ),
              const SizedBox(width: Spacing.s),
              Expanded(
                child: Text(
                  _isBlocked ? context.s.sicherungBlockedTitle : context.s.sicherungLockedTitle,
                  style: context.t.titleSmall?.copyWith(color: foreground),
                ),
              ),
            ],
          ),
          const SizedBox(height: Spacing.xs),
          Text(
            _reason ??
                (_isBlocked ? context.s.sicherungBlockedBody : context.s.sicherungLockedBody),
            style: context.t.bodySmall?.copyWith(color: foreground),
          ),
        ],
      ),
    );
  }
}

class const _Tile({
  required final Widget _child,
  required final bool _isFirst,
  required final bool _isLast,
  final Color? _color,
  final VoidCallback? _onTap,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return InkTapBox(
      onTap: _onTap,
      color: _color ?? context.c.surfaceContainer,
      shape: RoundedRectangleBorder(
        borderRadius: CornerRadii.grouped(
          outer: _groupRadius,
          isFirst: _isFirst,
          isLast: _isLast,
        ),
      ),
      padding: _tilePadding,
      child: _child,
    );
  }
}
