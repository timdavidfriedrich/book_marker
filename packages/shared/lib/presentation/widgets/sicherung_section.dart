import 'package:core/theme/corner_radii.dart';
import 'package:core/theme/spacing.dart';
import 'package:core/theme/theme_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared/presentation/account/account_bloc.dart';
import 'package:shared/presentation/account/account_state.dart';
import 'package:shared/presentation/extensions/context_extensions.dart';
import 'package:shared/presentation/navigation/navigation_extensions.dart';
import 'package:shared/presentation/navigation/routes.dart';
import 'package:shared/presentation/widgets/ink_tap_box.dart';

const _groupRadius = Spacing.radiusXl;
const _groupGap = Spacing.xxxs;
const _avatarSize = 48.0;
const _dotSize = 8.0;
const _tilePadding = EdgeInsets.symmetric(horizontal: Spacing.l, vertical: Spacing.m);

class const SicherungSection({
  super.key,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AccountBloc, AccountState>(
      builder: (context, state) => Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _IdentityTile(state: state),
          const SizedBox(height: _groupGap),
          ...switch (state) {
            AccountRestoring() || AccountSignedOut() => [const _SignInTile()],
            AccountLocked() => [const _NoticeTile(isBlocked: false), const _UnlockTile()],
            AccountBlocked(:final reason) => [
              _NoticeTile(isBlocked: true, reason: reason),
              const _SupportTile(),
            ],
            AccountReady() => [const _SyncedTile()],
          },
        ],
      ),
    );
  }
}

class const _IdentityTile({
  required final AccountState _state,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final account = switch (_state) {
      AccountLocked(:final account) ||
      AccountBlocked(:final account) ||
      AccountReady(:final account) => account,
      _ => null,
    };
    return _Tile(
      isFirst: true,
      isLast: false,
      child: Row(
        children: [
          Container(
            width: _avatarSize,
            height: _avatarSize,
            decoration: BoxDecoration(
              color: context.c.surfaceContainerHigh,
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.person_outline,
              color: context.palette.paperTextFaint,
              size: Spacing.iconM,
            ),
          ),
          const SizedBox(width: Spacing.m),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  account?.displayName ?? context.s.sicherungSignedOut,
                  style: context.t.titleSmall,
                ),
                if (account?.email case final email?) ...[
                  const SizedBox(height: Spacing.xxxs),
                  Text(
                    email,
                    style: context.typography.caption.copyWith(
                      color: context.c.onSurfaceVariant,
                    ),
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
      isLast: true,
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

class const _UnlockTile() extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final amber = context.palette.resolve(AccentColor.amber);
    return _Tile(
      isFirst: false,
      isLast: true,
      color: amber.solid,
      onTap: null,
      child: Row(
        children: [
          Expanded(
            child: Text(
              context.s.sicherungLockedCta,
              style: context.t.titleSmall?.copyWith(color: amber.onSolid),
            ),
          ),
          Icon(Icons.chevron_right, color: amber.onSolid, size: Spacing.iconM),
        ],
      ),
    );
  }
}

class const _SupportTile() extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return _Tile(
      isFirst: false,
      isLast: true,
      child: Row(
        children: [
          Expanded(child: Text(context.s.sicherungBlockedCta, style: context.t.titleSmall)),
          Icon(Icons.open_in_new, size: Spacing.iconS, color: context.c.onSurfaceVariant),
        ],
      ),
    );
  }
}

// * locked and blocked must never share a treatment: one is self-serve and says
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
    return Container(
      margin: const EdgeInsets.only(bottom: _groupGap),
      padding: _tilePadding,
      decoration: BoxDecoration(
        color: background,
        borderRadius: const BorderRadius.all(Radius.circular(Spacing.radiusS)),
      ),
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
