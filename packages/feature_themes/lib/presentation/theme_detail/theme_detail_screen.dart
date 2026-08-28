import 'package:core/theme/spacing.dart';
import 'package:core/theme/theme_extensions.dart';
import 'package:feature_themes/presentation/theme_detail/theme_detail_bloc.dart';
import 'package:feature_themes/presentation/theme_detail/theme_detail_event.dart';
import 'package:feature_themes/presentation/theme_detail/theme_detail_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared/presentation/extensions/accent_extensions.dart';
import 'package:shared/presentation/extensions/app_error_extensions.dart';
import 'package:shared/presentation/extensions/context_extensions.dart';
import 'package:shared/presentation/navigation/navigation_extensions.dart';
import 'package:shared/presentation/widgets/accent_picker.dart';
import 'package:shared/presentation/widgets/book_cover.dart';
import 'package:shared/presentation/widgets/circle_icon_button.dart';
import 'package:shared/presentation/widgets/confirm_dialog.dart';
import 'package:shared/presentation/widgets/ink_tap_box.dart';
import 'package:shared/presentation/widgets/mark_card.dart';
import 'package:shared/presentation/widgets/name_input_dialog.dart';
import 'package:shared/presentation/widgets/selectable_chip.dart';
import 'package:shared/presentation/widgets/sheet_action_tile.dart';

enum _ThemeMenuAction { rename, color, delete }

const _accentDotSize = 88.0;

class const ThemeDetailScreen({
  super.key,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<ThemeDetailBloc, ThemeDetailState>(
        listenWhen: (previous, current) => current is ThemeDetailDeleted,
        listener: (context, state) => context.closeScreen(),
        builder: (context, state) => switch (state) {
          ThemeDetailLoading() => const Center(child: CircularProgressIndicator()),
          ThemeDetailFailure(:final error) => Center(
            child: Padding(
              padding: const EdgeInsets.all(Spacing.l),
              child: Text(error.toMessage(context), textAlign: TextAlign.center),
            ),
          ),
          ThemeDetailLoaded() => _Content(state: state),
          ThemeDetailDeleted() => const SizedBox.shrink(),
        },
      ),
    );
  }
}

class const _Content({
  required final ThemeDetailLoaded _state,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final accent = _state.theme.accent ?? _state.theme.id.accent;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _Header(state: _state, accent: accent),
        const SizedBox(height: Spacing.m),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: Spacing.l),
          child: Row(
            children: [
              SelectableChip(
                label: context.s.bookDetailAllFilter(_state.totalCount),
                selected: _state.filter == ThemeDetailFilter.all,
                selectedColor: context.c.inverseSurface,
                selectedTextColor: context.c.onInverseSurface,
                onTap: () => context
                    .read<ThemeDetailBloc>()
                    .add(const ThemeDetailFilterChanged(ThemeDetailFilter.all)),
              ),
              const SizedBox(width: Spacing.xs),
              SelectableChip(
                label: context.s.bookDetailStarredFilter,
                selected: _state.filter == ThemeDetailFilter.starred,
                selectedColor: context.c.inverseSurface,
                selectedTextColor: context.c.onInverseSurface,
                onTap: () => context
                    .read<ThemeDetailBloc>()
                    .add(const ThemeDetailFilterChanged(ThemeDetailFilter.starred)),
              ),
            ],
          ),
        ),
        const SizedBox(height: Spacing.m),
        Expanded(
          child: _state.marks.isEmpty
              ? Center(
                  child: Padding(
                    padding: const EdgeInsets.all(Spacing.l),
                    child: Text(
                      context.s.themeDetailEmpty,
                      textAlign: TextAlign.center,
                      style: context.typography.readingBody.copyWith(color: context.c.onSurfaceVariant),
                    ),
                  ),
                )
              : ListView.separated(
                  padding: const EdgeInsets.fromLTRB(Spacing.l, 0, Spacing.l, Spacing.l),
                  itemCount: _state.marks.length,
                  separatorBuilder: (context, index) => const SizedBox(height: Spacing.m),
                  itemBuilder: (context, index) {
                    final item = _state.marks[index];
                    final voiceMs = item.mark.voiceDurationMs;
                    return MarkCard(
                      accent: item.book.id.accent,
                      quote: "“${item.mark.quote}”",
                      thumbnailUrl: item.book.thumbnailUrl,
                      page: item.mark.pageNumber,
                      note: item.mark.note,
                      sourceLabel: item.book.title,
                      isStarred: item.mark.isFavorite,
                      hasVoice: item.mark.voicePath != null,
                      voiceDuration: voiceMs == null ? null : Duration(milliseconds: voiceMs),
                      voicePath: item.mark.voicePath,
                      onTap: () => context.pushBookmarkDetail(item.mark.id),
                    );
                  },
                ),
        ),
        _BottomBar(state: _state),
      ],
    );
  }
}

class const _Header({
  required final ThemeDetailLoaded _state,
  required final AccentColor _accent,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final swatch = context.palette.resolve(_accent);
    return Container(
      decoration: BoxDecoration(
        color: swatch.fill,
        borderRadius: const BorderRadius.vertical(bottom: Radius.circular(Spacing.radiusXxl)),
      ),
      child: SafeArea(
        bottom: false,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(Spacing.l, Spacing.s, Spacing.l, Spacing.l),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CircleIconButton(
                    icon: Icons.arrow_back,
                    tooltip: context.s.back,
                    backgroundColor: context.c.surfaceContainerLowest,
                    onPressed: context.closeScreen,
                  ),
                  CircleIconButton(
                    icon: Icons.more_horiz,
                    backgroundColor: context.c.surfaceContainerLowest,
                    onPressed: () => _showThemeMenu(context, _state),
                  ),
                ],
              ),
              const SizedBox(height: Spacing.m),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    width: _accentDotSize,
                    height: _accentDotSize,
                    decoration: BoxDecoration(color: swatch.solid, shape: BoxShape.circle),
                  ),
                  const SizedBox(width: Spacing.l),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          _state.theme.name,
                          style: context.t.headlineMedium?.copyWith(color: swatch.onFill),
                        ),
                        const SizedBox(height: Spacing.xs),
                        Text(
                          context.s.themeDetailStats(
                            _state.totalCount,
                            _state.bookCount,
                            _state.starredCount,
                          ),
                          style: context.typography.monoLabel.copyWith(color: swatch.onFillVariant),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class const _BottomBar({
  required final ThemeDetailLoaded _state,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(Spacing.l, 0, Spacing.l, Spacing.s),
        child: Row(
          children: [
            Expanded(
              child: InkTapBox(
                color: context.c.surfaceContainerHigh,
                radius: Spacing.radiusFull,
                padding: const EdgeInsets.symmetric(vertical: Spacing.m),
                onTap: () => _showAddMarks(context, _state),
                child: Center(
                  child: Text(
                    context.s.themeDetailAddMarks,
                    style: context.t.labelLarge?.copyWith(color: context.c.onSurfaceVariant),
                  ),
                ),
              ),
            ),
            const SizedBox(width: Spacing.s),
            CircleIconButton(
              icon: Icons.north_east,
              size: 56,
              backgroundColor: context.c.inverseSurface,
              foregroundColor: context.c.onInverseSurface,
              onPressed: () => _showAddMarks(context, _state),
            ),
          ],
        ),
      ),
    );
  }
}

Future<void> _showThemeMenu(BuildContext context, ThemeDetailLoaded state) async {
  final bloc = context.read<ThemeDetailBloc>();
  final action = await showModalBottomSheet<_ThemeMenuAction>(
    context: context,
    useRootNavigator: true,
    builder: (_) => const _ThemeMenu(),
  );
  if (action == null || !context.mounted) return;
  switch (action) {
    case _ThemeMenuAction.rename:
      final name = await showNameInputDialog(
        context,
        title: context.s.themeRenameTitle,
        hint: context.s.themesNewThemeHint,
        initialValue: state.theme.name,
      );
      if (name != null && name.trim().isNotEmpty) bloc.add(ThemeDetailRenameRequested(name));
    case _ThemeMenuAction.color:
      await _showAccentSheet(context, bloc, state.theme.accent);
    case _ThemeMenuAction.delete:
      final confirmed = await showConfirmDialog(
        context,
        title: context.s.themeDeleteTitle,
        message: context.s.themeDeleteMessage,
        confirmLabel: context.s.commonDelete,
        destructive: true,
      );
      if (confirmed) bloc.add(const ThemeDetailDeleteRequested());
  }
}

Future<void> _showAccentSheet(BuildContext context, ThemeDetailBloc bloc, AccentColor? current) async {
  await showModalBottomSheet<void>(
    context: context,
    useRootNavigator: true,
    builder: (sheetContext) => SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(Spacing.l),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(sheetContext.s.accentPickerTitle, style: sheetContext.t.titleMedium),
            const SizedBox(height: Spacing.m),
            AccentPicker(
              selected: current,
              onSelected: (accent) {
                bloc.add(ThemeDetailAccentChanged(accent));
                Navigator.of(sheetContext).pop();
              },
            ),
          ],
        ),
      ),
    ),
  );
}

class const _ThemeMenu() extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(Spacing.l),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SheetActionTile(
              icon: Icons.drive_file_rename_outline,
              label: context.s.commonRename,
              onTap: () => Navigator.of(context).pop(_ThemeMenuAction.rename),
            ),
            SheetActionTile(
              icon: Icons.palette_outlined,
              label: context.s.commonChangeColor,
              onTap: () => Navigator.of(context).pop(_ThemeMenuAction.color),
            ),
            SheetActionTile(
              icon: Icons.delete_outline,
              label: context.s.commonDelete,
              destructive: true,
              onTap: () => Navigator.of(context).pop(_ThemeMenuAction.delete),
            ),
          ],
        ),
      ),
    );
  }
}

Future<void> _showAddMarks(BuildContext context, ThemeDetailLoaded state) async {
  final bloc = context.read<ThemeDetailBloc>();
  await showModalBottomSheet<void>(
    context: context,
    isScrollControlled: true,
    useRootNavigator: true,
    backgroundColor: Colors.transparent,
    builder: (_) => BlocProvider.value(value: bloc, child: const _AddMarksSheet()),
  );
}

class const _AddMarksSheet() extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.6,
      minChildSize: 0.6,
      maxChildSize: 0.95,
      builder: (context, scrollController) => DecoratedBox(
        decoration: BoxDecoration(
          color: context.c.surfaceContainerLowest,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(Spacing.radiusXxl)),
        ),
        child: BlocBuilder<ThemeDetailBloc, ThemeDetailState>(
          builder: (context, state) {
            if (state is! ThemeDetailLoaded) return const SizedBox.shrink();
            return ListView(
              controller: scrollController,
              padding: const EdgeInsets.fromLTRB(Spacing.l, Spacing.m, Spacing.l, Spacing.xxl),
              children: [
                Center(
                  child: Container(
                    width: 44,
                    height: 5,
                    decoration: BoxDecoration(
                      color: context.c.outline,
                      borderRadius: BorderRadius.circular(Spacing.radiusFull),
                    ),
                  ),
                ),
                const SizedBox(height: Spacing.m),
                Text(context.s.themeAddMarksTitle, style: context.t.headlineSmall),
                const SizedBox(height: Spacing.m),
                for (final item in state.allMarks)
                  Padding(
                    padding: const EdgeInsets.only(bottom: Spacing.s),
                    child: _AddMarkRow(
                      item: item,
                      selected: state.memberIds.contains(item.mark.id),
                    ),
                  ),
              ],
            );
          },
        ),
      ),
    );
  }
}

class const _AddMarkRow({
  required final ThemeMarkItem _item,
  required final bool _selected,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return InkTapBox(
      color: _selected ? context.palette.resolve(_item.book.id.accent).fill : context.c.surfaceContainerHigh,
      radius: Spacing.radiusL,
      padding: const EdgeInsets.all(Spacing.s),
      onTap: () => context.read<ThemeDetailBloc>().add(ThemeDetailMarkToggled(_item.mark.id)),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          BookCover(accent: _item.book.id.accent, url: _item.book.thumbnailUrl, width: 40, height: 52, radius: Spacing.radiusS),
          const SizedBox(width: Spacing.s),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "“${_item.mark.quote}”",
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: context.typography.readingQuote,
                ),
                const SizedBox(height: Spacing.xxs),
                Text(
                  _item.book.title,
                  style: context.typography.monoLabel.copyWith(color: context.c.onSurfaceVariant),
                ),
              ],
            ),
          ),
          const SizedBox(width: Spacing.s),
          Icon(
            _selected ? Icons.check_circle : Icons.circle_outlined,
            color: _selected ? context.palette.teal.solid : context.c.outline,
            size: Spacing.iconM,
          ),
        ],
      ),
    );
  }
}
