import 'package:core/theme/spacing.dart';
import 'package:feature_themes/presentation/themes/themes_bloc.dart';
import 'package:feature_themes/presentation/themes/themes_event.dart';
import 'package:feature_themes/presentation/themes/themes_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared/presentation/extensions/app_error_extensions.dart';
import 'package:shared/presentation/extensions/context_extensions.dart';
import 'package:shared/presentation/extensions/screen_layout_extensions.dart';
import 'package:shared/presentation/navigation/navigation_extensions.dart';
import 'package:shared/presentation/widgets/collection_mark.dart';
import 'package:shared/presentation/widgets/ink_tap_box.dart';
import 'package:shared/presentation/widgets/loading_indicator.dart';
import 'package:shared/presentation/widgets/name_input_dialog.dart';
import 'package:shared/presentation/widgets/tab_header.dart';

const _markSize = 68.0;

class const ThemesScreen({
  super.key,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        bottom: false,
        child: BlocBuilder<ThemesBloc, ThemesState>(
          builder: (context, state) => switch (state) {
            ThemesLoading() => const LoadingIndicator(),
            ThemesFailure(:final error) => Center(
              child: Padding(
                padding: const EdgeInsets.all(Spacing.l),
                child: Text(error.toMessage(context), textAlign: TextAlign.center),
              ),
            ),
            ThemesLoaded() => _Content(state: state),
          },
        ),
      ),
    );
  }
}

class const _Content({
  required final ThemesLoaded _state,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final layout = context.layout;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TabHeader(title: context.s.themesTitle),
        Expanded(
          child: GridView.count(
            crossAxisCount: layout.tileColumns,
            mainAxisSpacing: Spacing.m,
            crossAxisSpacing: Spacing.m,
            childAspectRatio: layout.tileAspectRatio,
            padding: EdgeInsets.fromLTRB(
              layout.pageMargin,
              0,
              layout.pageMargin,
              Spacing.xxl,
            ),
            children: [
              for (final summary in _state.themes) _ThemeTile(summary: summary),
              const _NewThemeTile(),
            ],
          ),
        ),
      ],
    );
  }
}

class const _ThemeTile({
  required final ThemeSummary _summary,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = _summary.theme;
    final swatch = context.palette.resolve(theme.accent);
    return InkTapBox(
      color: swatch.fill,
      radius: Spacing.radiusXl,
      padding: const EdgeInsets.all(Spacing.l),
      onTap: () => context.pushThemeDetail(_summary.theme.id),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CollectionMark(
            kind: CollectionKind.theme,
            accent: theme.accent,
            symbol: theme.symbol,
            size: _markSize,
          ),
          const Spacer(),
          Text(
            theme.name,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: context.t.headlineSmall?.copyWith(color: swatch.onFill),
          ),
          const SizedBox(height: Spacing.xxs),
          Text(
            context.s.themesThemeMeta(_summary.quoteCount, _summary.bookCount),
            style: context.typography.label.copyWith(color: swatch.onFillVariant),
          ),
        ],
      ),
    );
  }
}

class const _NewThemeTile() extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return InkTapBox(
      color: context.c.surfaceContainerHigh,
      radius: Spacing.radiusXl,
      padding: const EdgeInsets.all(Spacing.l),
      onTap: () => _promptNewTheme(context),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: _markSize,
            height: _markSize,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: context.c.surfaceContainerLowest,
              shape: BoxShape.circle,
            ),
            child: Icon(Icons.add, size: Spacing.iconL, color: context.c.onSurfaceVariant),
          ),
          const Spacer(),
          Text(context.s.themesNewThemeLabel, style: context.t.headlineSmall),
        ],
      ),
    );
  }
}

Future<void> _promptNewTheme(BuildContext context) async {
  final bloc = context.read<ThemesBloc>();
  final name = await showNameInputDialog(
    context,
    title: context.s.themesNewThemeTitle,
    hint: context.s.themesNewThemeHint,
    confirmLabel: context.s.themesNewThemeButton,
  );
  if (name != null && name.trim().isNotEmpty) bloc.add(ThemesCreateRequested(name));
}
