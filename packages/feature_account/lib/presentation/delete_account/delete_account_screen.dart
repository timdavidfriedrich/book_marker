import 'package:core/theme/corner_radii.dart';
import 'package:core/theme/spacing.dart';
import 'package:core/theme/theme_extensions.dart';
import 'package:feature_account/presentation/delete_account/delete_account_bloc.dart';
import 'package:feature_account/presentation/delete_account/delete_account_dialog.dart';
import 'package:feature_account/presentation/delete_account/delete_account_event.dart';
import 'package:feature_account/presentation/delete_account/delete_account_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared/presentation/account/account_bloc.dart';
import 'package:shared/presentation/account/account_event.dart';
import 'package:shared/presentation/extensions/context_extensions.dart';
import 'package:shared/presentation/extensions/screen_layout_extensions.dart';
import 'package:shared/presentation/navigation/navigation_extensions.dart';
import 'package:shared/presentation/widgets/circle_icon_button.dart';

const _groupRadius = Spacing.radiusXl;
const _groupGap = Spacing.xxxs;
const _markerSize = 5.0;
const _markerTopOffset = 7.0;
const _tilePadding = EdgeInsets.all(Spacing.m);
const _destructiveBorderWidth = 1.5;

class const DeleteAccountScreen({
  super.key,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocConsumer<DeleteAccountBloc, DeleteAccountState>(
          listenWhen: (previous, current) => current is DeleteAccountDone,
          // * the same sign out the dialog offers, keeping local data: the rows
          // * here are still readable and the master key that reads them stays
          listener: (context, state) {
            context.read<AccountBloc>().add(
              const AccountSignOutRequested(removesLocalData: false),
            );
            context.closeScreen();
          },
          builder: (context, state) => _Content(state: state),
        ),
      ),
    );
  }
}

class const _Content({
  required final DeleteAccountState _state,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final isRunning = _state is DeleteAccountRunning;
    return ListView(
      padding: EdgeInsets.all(context.layout.pageMargin),
      children: [
        Align(
          alignment: AlignmentDirectional.centerStart,
          child: CircleIconButton(
            icon: Icons.arrow_back,
            onPressed: isRunning ? null : context.closeScreen,
          ),
        ),
        const SizedBox(height: Spacing.m),
        Text(context.s.deleteAccountTitle, style: context.t.displaySmall),
        const SizedBox(height: Spacing.s),
        Text(
          context.s.deleteAccountLead,
          style: context.typography.readingQuoteItalic.copyWith(
            color: context.c.onSurfaceVariant,
          ),
        ),
        const SizedBox(height: Spacing.l),
        _Group(
          title: context.s.deleteAccountRemovedTitle,
          lines: [
            context.s.deleteAccountRemovedIdentity,
            context.s.deleteAccountRemovedLibrary,
            context.s.deleteAccountRemovedUsage,
          ],
          markerColor: context.c.error,
          isFirst: true,
          isLast: false,
        ),
        const SizedBox(height: _groupGap),
        _Group(
          title: context.s.deleteAccountKeptTitle,
          lines: [context.s.deleteAccountKeptLibrary],
          markerColor: context.palette.resolve(AccentColor.teal).solid,
          isFirst: false,
          isLast: true,
        ),
        if (_state case DeleteAccountIdle(hasFailed: true)) ...[
          const SizedBox(height: Spacing.m),
          const _FailureTile(),
        ],
        const SizedBox(height: Spacing.l),
        _DestructiveButton(isRunning: isRunning),
      ],
    );
  }
}

class const _DestructiveButton({
  required final bool _isRunning,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Material(
      color: context.c.errorContainer,
      shape: RoundedRectangleBorder(
        side: BorderSide(color: context.c.error, width: _destructiveBorderWidth),
        borderRadius: const BorderRadius.all(Radius.circular(Spacing.radiusXl)),
      ),
      child: InkWell(
        borderRadius: const BorderRadius.all(Radius.circular(Spacing.radiusXl)),
        onTap: _isRunning
            ? null
            : () async {
                if (!await showDeleteAccountDialog(context) || !context.mounted) return;
                context.read<DeleteAccountBloc>().add(const DeleteAccountConfirmed());
              },
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: Spacing.m),
          child: Center(
            child: Text(
              context.s.deleteAccountAction,
              style: context.t.titleSmall?.copyWith(color: context.c.onErrorContainer),
            ),
          ),
        ),
      ),
    );
  }
}

class const _FailureTile() extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: _tilePadding,
      decoration: BoxDecoration(
        color: context.c.errorContainer,
        borderRadius: const BorderRadius.all(Radius.circular(Spacing.radiusL)),
      ),
      child: Text(
        context.s.deleteAccountFailed,
        style: context.t.bodyMedium?.copyWith(color: context.c.onErrorContainer),
      ),
    );
  }
}

class const _Group({
  required final String _title,
  required final List<String> _lines,
  required final Color _markerColor,
  required final bool _isFirst,
  required final bool _isLast,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: _tilePadding,
      decoration: BoxDecoration(
        color: context.c.surfaceContainer,
        borderRadius: CornerRadii.grouped(
          outer: _groupRadius,
          isFirst: _isFirst,
          isLast: _isLast,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(_title, style: context.t.titleSmall),
          const SizedBox(height: Spacing.s),
          for (final line in _lines) ...[
            _Marked(text: line, color: _markerColor),
            if (line != _lines.last) const SizedBox(height: Spacing.xxs),
          ],
        ],
      ),
    );
  }
}

class const _Marked({
  required final String _text,
  required final Color _color,
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
          decoration: BoxDecoration(color: _color, shape: BoxShape.circle),
        ),
        Expanded(
          child: Text(
            _text,
            style: context.t.bodyMedium?.copyWith(color: context.c.onSurfaceVariant),
          ),
        ),
      ],
    );
  }
}
