import 'package:core/theme/spacing.dart';
import 'package:feature_themes/presentation/themes/themes_bloc.dart';
import 'package:feature_themes/presentation/themes/themes_event.dart';
import 'package:feature_themes/presentation/themes/themes_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared/presentation/extensions/accent_extensions.dart';
import 'package:shared/presentation/extensions/app_error_extensions.dart';
import 'package:shared/presentation/extensions/context_extensions.dart';
import 'package:shared/presentation/navigation/navigation_extensions.dart';
import 'package:shared/presentation/widgets/ink_tap_box.dart';
import 'package:shared/presentation/widgets/name_input_dialog.dart';
import 'package:shared/presentation/widgets/profile_avatar.dart';

const _accentDotSize = 68.0;

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
            ThemesLoading() => const Center(child: CircularProgressIndicator()),
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
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: Spacing.l),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: Spacing.m),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(context.s.themesTitle, style: context.t.displaySmall),
                    const SizedBox(height: Spacing.xxs),
                    Text(
                      context.s.themesHeaderStats(
                        _state.themes.length,
                        _state.totalMarks,
                        _state.totalBooks,
                      ),
                      style: context.typography.monoLabel.copyWith(color: context.c.onSurfaceVariant),
                    ),
                  ],
                ),
              ),
              ProfileAvatar(onTap: () => context.pushSettings()),
            ],
          ),
          const SizedBox(height: Spacing.m),
          Expanded(
            child: GridView.count(
              crossAxisCount: 2,
              mainAxisSpacing: Spacing.m,
              crossAxisSpacing: Spacing.m,
              childAspectRatio: 0.92,
              padding: const EdgeInsets.only(bottom: Spacing.xxl),
              children: [
                for (final summary in _state.themes) _ThemeTile(summary: summary),
                const _NewThemeTile(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class const _ThemeTile({
  required final ThemeSummary _summary,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final accent = _summary.theme.accent ?? _summary.theme.id.accent;
    final swatch = context.palette.resolve(accent);
    return InkTapBox(
      color: swatch.fill,
      radius: Spacing.radiusXl,
      padding: const EdgeInsets.all(Spacing.l),
      onTap: () => context.pushThemeDetail(_summary.theme.id),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: _accentDotSize,
            height: _accentDotSize,
            decoration: BoxDecoration(color: swatch.solid, shape: BoxShape.circle),
          ),
          const Spacer(),
          Text(
            _summary.theme.name,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: context.t.headlineSmall?.copyWith(color: swatch.onFill),
          ),
          const SizedBox(height: Spacing.xxs),
          Text(
            "${context.s.libraryMarksCount(_summary.markCount)} · ${context.s.themesBooksCount(_summary.bookCount)}",
            style: context.typography.monoLabel.copyWith(color: swatch.onFillVariant),
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
            width: _accentDotSize,
            height: _accentDotSize,
            alignment: Alignment.center,
            decoration: BoxDecoration(color: context.c.surfaceContainerLowest, shape: BoxShape.circle),
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
  );
  if (name != null && name.trim().isNotEmpty) bloc.add(ThemesCreateRequested(name));
}
