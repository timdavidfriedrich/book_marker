import 'package:core/theme/corner_radii.dart';
import 'package:core/theme/spacing.dart';
import 'package:feature_themes/presentation/theme_detail/theme_detail_bloc.dart';
import 'package:feature_themes/presentation/theme_detail/theme_detail_event.dart';
import 'package:feature_themes/presentation/theme_detail/theme_detail_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared/presentation/extensions/app_error_extensions.dart';
import 'package:shared/presentation/extensions/context_extensions.dart';
import 'package:shared/presentation/extensions/screen_layout_extensions.dart';
import 'package:shared/presentation/extensions/stat_label_extensions.dart';
import 'package:shared/presentation/navigation/navigation_extensions.dart';
import 'package:shared/presentation/widgets/book_cover.dart';
import 'package:shared/presentation/widgets/circle_icon_button.dart';
import 'package:shared/presentation/widgets/collapsing_header.dart';
import 'package:shared/presentation/widgets/collection_mark.dart';
import 'package:shared/presentation/widgets/collection_mark_picker.dart';
import 'package:shared/presentation/widgets/columned_sliver_list.dart';
import 'package:shared/presentation/widgets/confirm_dialog.dart';
import 'package:shared/presentation/widgets/drag_dismiss_sheet.dart';
import 'package:shared/presentation/widgets/ink_tap_box.dart';
import 'package:shared/presentation/widgets/loading_screen.dart';
import 'package:shared/presentation/widgets/name_input_dialog.dart';
import 'package:shared/presentation/widgets/pinned_header.dart';
import 'package:shared/presentation/widgets/quote_card.dart';
import 'package:shared/presentation/widgets/selectable_chip.dart';
import 'package:shared/presentation/widgets/sheet_action_tile.dart';
import 'package:shared/presentation/widgets/sheet_content.dart';
import 'package:shared/presentation/widgets/sheet_drag_handle.dart';

enum _ThemeMenuAction { rename, mark, delete }

const _sheetCollapsedSize = 0.6;
const _sheetExpandedSize = 0.95;
const _markSize = 88.0;
const _paneMarkSize = 104.0;
const _headerHeight = 196.0;
const _chipHeight = 32.0;
const _chipsHeight = Spacing.m + _chipHeight + Spacing.m;
const _addRowRadius = Spacing.radiusL;
const _addRowPadding = Spacing.s;

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
          ThemeDetailLoading() => const LoadingScreen(),
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
    final theme = _state.theme;
    if (context.layout.isLandscape) {
      return Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _SidePanel(state: _state),
          Expanded(
            child: SafeArea(
              left: false,
              child: CustomScrollView(slivers: [_QuoteSlivers(state: _state)]),
            ),
          ),
        ],
      );
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Expanded(
          child: CustomScrollView(
            slivers: [
              CollapsingHeader(
                expandedHeight: _headerHeight,
                backgroundColor: context.palette.resolve(theme.accent).fill,
                expanded: _Header(state: _state),
                collapsed: _CollapsedHeader(state: _state),
              ),
              _QuoteSlivers(state: _state),
            ],
          ),
        ),
        SafeArea(
          top: false,
          child: Padding(
            padding: EdgeInsets.fromLTRB(
              context.layout.pageMargin,
              0,
              context.layout.pageMargin,
              Spacing.s,
            ),
            child: _AddQuotesButton(state: _state),
          ),
        ),
      ],
    );
  }
}

class const _QuoteSlivers({
  required final ThemeDetailLoaded _state,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final margin = context.layout.pageMargin;
    return SliverMainAxisGroup(
      slivers: [
        PinnedHeader(
          height: _chipsHeight,
          child: ColoredBox(
            color: context.c.surface,
            child: Padding(
              padding: EdgeInsets.fromLTRB(margin, Spacing.m, margin, Spacing.m),
              child: Row(
                children: [
                  SelectableChip(
                    label: context.s.bookDetailAllFilter(_state.totalCount),
                    selected: _state.filter == ThemeDetailFilter.all,
                    selectedColor: context.c.inverseSurface,
                    selectedTextColor: context.c.onInverseSurface,
                    onTap: () => context.read<ThemeDetailBloc>().add(
                      const ThemeDetailFilterChanged(ThemeDetailFilter.all),
                    ),
                  ),
                  const SizedBox(width: Spacing.xs),
                  SelectableChip(
                    label: context.s.bookDetailFavoritesFilter,
                    selected: _state.filter == ThemeDetailFilter.favorites,
                    selectedColor: context.c.inverseSurface,
                    selectedTextColor: context.c.onInverseSurface,
                    onTap: () => context.read<ThemeDetailBloc>().add(
                      const ThemeDetailFilterChanged(ThemeDetailFilter.favorites),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        if (_state.quotes.isEmpty)
          SliverFillRemaining(
            hasScrollBody: false,
            child: Padding(
              padding: const EdgeInsets.all(Spacing.l),
              child: Text(
                _state.totalCount == 0
                    ? context.s.themeDetailEmpty
                    : context.s.filterNoResultsMessage,
                textAlign: TextAlign.center,
                style: context.typography.readingBody.copyWith(color: context.c.onSurfaceVariant),
              ),
            ),
          )
        else
          SliverPadding(
            padding: EdgeInsets.fromLTRB(margin, 0, margin, Spacing.l),
            sliver: ColumnedSliverList(
              itemCount: _state.quotes.length,
              columns: context.layout.cardColumns,
              itemBuilder: (context, index) {
                final item = _state.quotes[index];
                final voiceNoteMs = item.quote.voiceNoteDurationMs;
                return QuoteCard(
                  quote: "“${item.quote.quote}”",
                  bookTitle: item.book.title,
                  coverImage: item.book.coverImage,
                  pages: item.quote.pageNumbers,
                  note: item.quote.note,
                  sourceLabel: item.book.title,
                  isFavorite: item.quote.isFavorite,
                  hasVoiceNote: item.quote.voiceNotePath != null,
                  voiceNoteDuration: voiceNoteMs == null
                      ? null
                      : Duration(milliseconds: voiceNoteMs),
                  voiceNotePath: item.quote.voiceNotePath,
                  onTap: () => context.pushQuoteDetail(item.quote.id),
                );
              },
            ),
          ),
      ],
    );
  }
}

class const _AddQuotesButton({
  required final ThemeDetailLoaded _state,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return InkTapBox(
      color: context.c.surfaceContainerHigh,
      radius: Spacing.radiusFull,
      padding: const EdgeInsets.symmetric(vertical: Spacing.m),
      onTap: () => _showAddQuotes(context, _state),
      child: Center(
        child: Text(
          context.s.themeDetailAddQuotes,
          textAlign: TextAlign.center,
          style: context.t.labelLarge?.copyWith(color: context.c.onSurfaceVariant),
        ),
      ),
    );
  }
}

class const _SidePanel({
  required final ThemeDetailLoaded _state,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = _state.theme;
    final swatch = context.palette.resolve(theme.accent);
    return Container(
      width: Spacing.detailPaneWidth,
      color: swatch.fill,
      child: SafeArea(
        right: false,
        child: Padding(
          padding: const EdgeInsets.all(Spacing.l),
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
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(vertical: Spacing.l),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CollectionMark(
                        kind: CollectionKind.theme,
                        accent: theme.accent,
                        symbol: theme.symbol,
                        size: _paneMarkSize,
                      ),
                      const SizedBox(height: Spacing.m),
                      Text(
                        theme.name,
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                        style: context.t.headlineMedium?.copyWith(color: swatch.onFill),
                      ),
                      const SizedBox(height: Spacing.xs),
                      _Stats(state: _state, color: swatch.onFillVariant),
                    ],
                  ),
                ),
              ),
              _AddQuotesButton(state: _state),
            ],
          ),
        ),
      ),
    );
  }
}

class const _Stats({
  required final ThemeDetailLoaded _state,
  required final Color _color,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Text(
      [
        context.s.themeDetailQuotesInBooks(_state.totalCount, _state.bookCount),
        _state.favoriteCount.toFavoritesStat(context),
      ].joinStats(),
      style: context.typography.label.copyWith(color: _color),
    );
  }
}

class const _Header({
  required final ThemeDetailLoaded _state,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = _state.theme;
    final swatch = context.palette.resolve(theme.accent);
    return SafeArea(
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
                CollectionMark(
                  kind: CollectionKind.theme,
                  accent: theme.accent,
                  symbol: theme.symbol,
                  size: _markSize,
                ),
                const SizedBox(width: Spacing.l),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        theme.name,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: context.t.headlineMedium?.copyWith(color: swatch.onFill),
                      ),
                      const SizedBox(height: Spacing.xs),
                      _Stats(state: _state, color: swatch.onFillVariant),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class const _CollapsedHeader({
  required final ThemeDetailLoaded _state,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final swatch = context.palette.resolve(_state.theme.accent);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: Spacing.l, vertical: Spacing.xs),
      child: Row(
        children: [
          CircleIconButton(
            icon: Icons.arrow_back,
            tooltip: context.s.back,
            backgroundColor: context.c.surfaceContainerLowest,
            onPressed: context.closeScreen,
          ),
          const SizedBox(width: Spacing.s),
          Expanded(
            child: Text(
              _state.theme.name,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: context.t.titleLarge?.copyWith(color: swatch.onFill),
            ),
          ),
          const SizedBox(width: Spacing.s),
          CircleIconButton(
            icon: Icons.more_horiz,
            backgroundColor: context.c.surfaceContainerLowest,
            onPressed: () => _showThemeMenu(context, _state),
          ),
        ],
      ),
    );
  }
}

Future<void> _showThemeMenu(BuildContext context, ThemeDetailLoaded state) async {
  final bloc = context.read<ThemeDetailBloc>();
  final action = await showModalBottomSheet<_ThemeMenuAction>(
    context: context,
    isScrollControlled: true,
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
    case _ThemeMenuAction.mark:
      await _showMarkSheet(context, bloc);
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

Future<void> _showMarkSheet(BuildContext context, ThemeDetailBloc bloc) async {
  await showModalBottomSheet<void>(
    context: context,
    isScrollControlled: true,
    useRootNavigator: true,
    builder: (_) => BlocProvider.value(value: bloc, child: const _MarkSheet()),
  );
}

class const _MarkSheet() extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeDetailBloc, ThemeDetailState>(
      builder: (context, state) {
        if (state is! ThemeDetailLoaded) return const SizedBox.shrink();
        return SheetContent(
          children: [
            Text(context.s.markPickerTitle, style: context.t.titleMedium),
            const SizedBox(height: Spacing.m),
            Flexible(
              child: CollectionMarkPicker(
                kind: CollectionKind.theme,
                accent: state.theme.accent,
                symbol: state.theme.symbol,
                onSymbolSelected: (symbol) =>
                    context.read<ThemeDetailBloc>().add(ThemeDetailSymbolChanged(symbol)),
                onAccentSelected: (accent) =>
                    context.read<ThemeDetailBloc>().add(ThemeDetailAccentChanged(accent)),
              ),
            ),
          ],
        );
      },
    );
  }
}

class const _ThemeMenu() extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SheetContent(
      children: [
        SheetActionTile(
          icon: Icons.drive_file_rename_outline,
          label: context.s.commonRename,
          onTap: () => Navigator.of(context).pop(_ThemeMenuAction.rename),
        ),
        SheetActionTile(
          icon: Icons.palette_outlined,
          label: context.s.commonChangeMark,
          onTap: () => Navigator.of(context).pop(_ThemeMenuAction.mark),
        ),
        SheetActionTile(
          icon: Icons.delete_outline,
          label: context.s.commonDelete,
          destructive: true,
          onTap: () => Navigator.of(context).pop(_ThemeMenuAction.delete),
        ),
      ],
    );
  }
}

Future<void> _showAddQuotes(BuildContext context, ThemeDetailLoaded state) async {
  final bloc = context.read<ThemeDetailBloc>();
  await showModalBottomSheet<void>(
    context: context,
    isScrollControlled: true,
    useRootNavigator: true,
    backgroundColor: Colors.transparent,
    showDragHandle: false,
    builder: (_) => BlocProvider.value(value: bloc, child: const _AddQuotesSheet()),
  );
}

class const _AddQuotesSheet() extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DragDismissSheet(
      restingSize: context.layout.sheetSize(_sheetCollapsedSize),
      expandedSize: _sheetExpandedSize,
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
              padding: const EdgeInsets.fromLTRB(Spacing.l, Spacing.s, Spacing.l, Spacing.l),
              children: [
                const SheetDragHandle(),
                const SizedBox(height: Spacing.m),
                Text(context.s.themeAddQuotesTitle, style: context.t.headlineSmall),
                const SizedBox(height: Spacing.m),
                for (final item in state.allQuotes)
                  Padding(
                    padding: const EdgeInsets.only(bottom: Spacing.s),
                    child: _AddQuoteRow(
                      item: item,
                      selected: state.memberIds.contains(item.quote.id),
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

class const _AddQuoteRow({
  required final ThemeQuoteItem _item,
  required final bool _selected,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return InkTapBox(
      color: _selected ? context.c.secondaryContainer : context.c.surfaceContainerHigh,
      radius: _addRowRadius,
      padding: const EdgeInsets.all(_addRowPadding),
      onTap: () => context.read<ThemeDetailBloc>().add(ThemeDetailQuoteToggled(_item.quote.id)),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          BookCover(
            title: _item.book.title,
            image: _item.book.coverImage,
            width: 40,
            height: 52,
            radius: CornerRadii.nested(_addRowRadius, _addRowPadding),
          ),
          const SizedBox(width: Spacing.s),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "“${_item.quote.quote}”",
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: context.typography.readingQuote,
                ),
                const SizedBox(height: Spacing.xxs),
                Text(
                  _item.book.title,
                  style: context.typography.label.copyWith(color: context.c.onSurfaceVariant),
                ),
              ],
            ),
          ),
          const SizedBox(width: Spacing.s),
          Icon(
            _selected ? Icons.check_circle : Icons.circle_outlined,
            color: _selected ? context.c.secondary : context.c.outline,
            size: Spacing.iconM,
          ),
        ],
      ),
    );
  }
}
