import 'package:core/sync/sync_service.dart';
import 'package:core/theme/spacing.dart';
import 'package:core/theme/theme_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared/presentation/extensions/context_extensions.dart';
import 'package:shared/presentation/sync/sync_cubit.dart';

const _dotSize = 8.0;
const _spinnerSize = 15.0;
const _spinnerStroke = 2.0;
const _chipRadius = 14.0;
const _chipPadding = EdgeInsets.symmetric(horizontal: Spacing.xs, vertical: Spacing.xxxs);

// * one row shape everywhere: marker left, state centre, action right. Paused
// * is missing on purpose, because nothing can pause sync by hand yet; there is
// * no state a "Fortsetzen" button could return from
class const SyncStatusRow({
  super.key,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SyncCubit, SyncConnectionStatus>(
      builder: (context, status) => Row(
        children: [
          _Marker(status: status),
          const SizedBox(width: Spacing.s),
          Expanded(child: Text(status.label(context), style: context.typography.label)),
          if (status == SyncConnectionStatus.failed)
            TextButton(
              onPressed: () => context.read<SyncCubit>().retry(),
              child: Text(
                context.s.syncStatusRetry,
                style: TextStyle(color: context.c.error),
              ),
            ),
        ],
      ),
    );
  }
}

// * the same states shrunk to a chip beside the library title, and gone
// * entirely once everything is synced: a permanent green tick is noise
class const SyncStatusChip({
  super.key,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SyncCubit, SyncConnectionStatus>(
      builder: (context, status) {
        if (status == SyncConnectionStatus.synced || status == SyncConnectionStatus.disconnected) {
          return const SizedBox.shrink();
        }
        return Container(
          padding: _chipPadding,
          decoration: BoxDecoration(
            color: status == SyncConnectionStatus.failed
                ? context.c.errorContainer
                : context.c.surfaceContainer,
            borderRadius: const BorderRadius.all(Radius.circular(_chipRadius)),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              _Marker(status: status),
              const SizedBox(width: Spacing.xxs),
              Text(status.shortLabel(context), style: context.typography.label),
            ],
          ),
        );
      },
    );
  }
}

class const _Marker({
  required final SyncConnectionStatus _status,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final teal = context.palette.resolve(AccentColor.teal);
    return switch (_status) {
      SyncConnectionStatus.connecting || SyncConnectionStatus.syncing => SizedBox.square(
        dimension: _spinnerSize,
        child: CircularProgressIndicator(strokeWidth: _spinnerStroke, color: teal.solid),
      ),
      SyncConnectionStatus.synced => Container(
        width: _dotSize,
        height: _dotSize,
        decoration: BoxDecoration(color: teal.solid, shape: BoxShape.circle),
      ),
      SyncConnectionStatus.disconnected => Icon(
        Icons.wifi_off,
        size: Spacing.iconS,
        color: context.c.onSurfaceVariant,
      ),
      SyncConnectionStatus.failed => Icon(
        Icons.error_outline,
        size: Spacing.iconS,
        color: context.c.error,
      ),
    };
  }
}

extension on SyncConnectionStatus {
  // * the chip sits beside a screen title, where the full sentence would push
  // * the title into an ellipsis
  String shortLabel(BuildContext context) => switch (this) {
    SyncConnectionStatus.connecting || SyncConnectionStatus.syncing => context.s.syncStatusSyncing,
    SyncConnectionStatus.synced => context.s.syncStatusSynced,
    SyncConnectionStatus.disconnected => context.s.syncStatusOfflineShort,
    SyncConnectionStatus.failed => context.s.syncStatusFailedShort,
  };

  String label(BuildContext context) => switch (this) {
    SyncConnectionStatus.connecting || SyncConnectionStatus.syncing => context.s.syncStatusSyncing,
    SyncConnectionStatus.synced => context.s.syncStatusSynced,
    SyncConnectionStatus.disconnected => context.s.syncStatusOffline,
    SyncConnectionStatus.failed => context.s.syncStatusFailed,
  };
}
