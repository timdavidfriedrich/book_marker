import 'package:core/theme/spacing.dart';
import 'package:feature_library/presentation/shelf_detail/shelf_detail_bloc.dart';
import 'package:feature_library/presentation/shelf_detail/shelf_detail_event.dart';
import 'package:feature_library/presentation/shelf_detail/shelf_detail_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared/presentation/extensions/app_error_extensions.dart';
import 'package:shared/presentation/extensions/context_extensions.dart';
import 'package:shared/presentation/navigation/navigation_extensions.dart';
import 'package:shared/presentation/widgets/book_card.dart';
import 'package:shared/presentation/widgets/book_cover.dart';
import 'package:shared/presentation/widgets/circle_icon_button.dart';
import 'package:shared/presentation/widgets/collapsing_header.dart';
import 'package:shared/presentation/widgets/collection_mark.dart';
import 'package:shared/presentation/widgets/collection_mark_picker.dart';
import 'package:shared/presentation/widgets/confirm_dialog.dart';
import 'package:shared/presentation/widgets/ink_tap_box.dart';
import 'package:shared/presentation/widgets/name_input_dialog.dart';
import 'package:shared/presentation/widgets/sheet_action_tile.dart';
import 'package:shared/presentation/widgets/sheet_content.dart';

const _markSize = 88.0;
const _headerHeight = 184.0;

enum _ShelfMenuAction { rename, mark, delete }

class const ShelfDetailScreen({
  super.key,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<ShelfDetailBloc, ShelfDetailState>(
        listenWhen: (previous, current) => current is ShelfDetailDeleted,
        listener: (context, state) => context.closeScreen(),
        builder: (context, state) => switch (state) {
          ShelfDetailLoading() => const Center(child: CircularProgressIndicator()),
          ShelfDetailFailure(:final error) => Center(
            child: Padding(
              padding: const EdgeInsets.all(Spacing.l),
              child: Text(error.toMessage(context), textAlign: TextAlign.center),
            ),
          ),
          ShelfDetailLoaded() => _Content(state: state),
          ShelfDetailDeleted() => const SizedBox.shrink(),
        },
      ),
    );
  }
}

class const _Content({
  required final ShelfDetailLoaded _state,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final shelf = _state.shelf;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Expanded(
          child: CustomScrollView(
            slivers: [
              CollapsingHeader(
                expandedHeight: _headerHeight,
                backgroundColor: context.palette.resolve(shelf.accent).fill,
                expanded: _Header(state: _state),
                collapsed: _CollapsedHeader(state: _state),
              ),
              if (_state.books.isEmpty)
                SliverFillRemaining(
                  hasScrollBody: false,
                  child: Padding(
                    padding: const EdgeInsets.all(Spacing.l),
                    child: Text(
                      context.s.shelfDetailEmpty,
                      textAlign: TextAlign.center,
                      style: context.typography.readingBody.copyWith(
                        color: context.c.onSurfaceVariant,
                      ),
                    ),
                  ),
                )
              else
                SliverPadding(
                  padding: const EdgeInsets.fromLTRB(Spacing.l, Spacing.m, Spacing.l, Spacing.l),
                  sliver: SliverList.separated(
                    itemCount: _state.books.length,
                    separatorBuilder: (context, index) => const SizedBox(height: Spacing.m),
                    itemBuilder: (context, index) {
                      final item = _state.books[index];
                      return BookCard(
                        title: item.book.title,
                        meta: context.s.libraryQuotesCount(item.quoteCount),
                        count: item.quoteCount,
                        thumbnailUrl: item.book.thumbnailUrl,
                        onTap: () => context.pushBookDetail(item.book.id),
                      );
                    },
                  ),
                ),
            ],
          ),
        ),
        SafeArea(
          top: false,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(Spacing.l, 0, Spacing.l, Spacing.s),
            child: InkTapBox(
              color: context.c.surfaceContainerHigh,
              radius: Spacing.radiusFull,
              padding: const EdgeInsets.symmetric(vertical: Spacing.m),
              onTap: () => _showAddBooks(context),
              child: Center(
                child: Text(
                  context.s.shelfDetailAddBooks,
                  style: context.t.labelLarge?.copyWith(color: context.c.onSurfaceVariant),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class const _Header({
  required final ShelfDetailLoaded _state,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final shelf = _state.shelf;
    final swatch = context.palette.resolve(shelf.accent);
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
                  onPressed: () => _showShelfMenu(context, _state),
                ),
              ],
            ),
            const SizedBox(height: Spacing.m),
            Row(
              children: [
                CollectionMark(
                  kind: CollectionKind.shelf,
                  accent: shelf.accent,
                  symbol: shelf.symbol,
                  size: _markSize,
                ),
                const SizedBox(width: Spacing.l),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        shelf.name,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: context.t.headlineMedium?.copyWith(color: swatch.onFill),
                      ),
                      const SizedBox(height: Spacing.xs),
                      Text(
                        context.s.shelfDetailStats(_state.bookCount, _state.quoteCount),
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
    );
  }
}

class const _CollapsedHeader({
  required final ShelfDetailLoaded _state,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final swatch = context.palette.resolve(_state.shelf.accent);
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
              _state.shelf.name,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: context.t.titleLarge?.copyWith(color: swatch.onFill),
            ),
          ),
          const SizedBox(width: Spacing.s),
          CircleIconButton(
            icon: Icons.more_horiz,
            backgroundColor: context.c.surfaceContainerLowest,
            onPressed: () => _showShelfMenu(context, _state),
          ),
        ],
      ),
    );
  }
}

Future<void> _showShelfMenu(BuildContext context, ShelfDetailLoaded state) async {
  final bloc = context.read<ShelfDetailBloc>();
  final action = await showModalBottomSheet<_ShelfMenuAction>(
    context: context,
    useRootNavigator: true,
    builder: (_) => const _ShelfMenu(),
  );
  if (action == null || !context.mounted) return;
  switch (action) {
    case _ShelfMenuAction.rename:
      final name = await showNameInputDialog(
        context,
        title: context.s.shelfRenameTitle,
        hint: context.s.libraryNewShelfHint,
        initialValue: state.shelf.name,
      );
      if (name != null && name.trim().isNotEmpty) bloc.add(ShelfDetailRenameRequested(name));
    case _ShelfMenuAction.mark:
      await _showMarkSheet(context, bloc);
    case _ShelfMenuAction.delete:
      final confirmed = await showConfirmDialog(
        context,
        title: context.s.shelfDeleteTitle,
        message: context.s.shelfDeleteMessage,
        confirmLabel: context.s.commonDelete,
        destructive: true,
      );
      if (confirmed) bloc.add(const ShelfDetailDeleteRequested());
  }
}

Future<void> _showMarkSheet(BuildContext context, ShelfDetailBloc bloc) async {
  await showModalBottomSheet<void>(
    context: context,
    useRootNavigator: true,
    isScrollControlled: true,
    builder: (_) => BlocProvider.value(value: bloc, child: const _MarkSheet()),
  );
}

class const _MarkSheet() extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ShelfDetailBloc, ShelfDetailState>(
      builder: (context, state) {
        if (state is! ShelfDetailLoaded) return const SizedBox.shrink();
        return SheetContent(
          children: [
            Text(context.s.markPickerTitle, style: context.t.titleMedium),
            const SizedBox(height: Spacing.m),
            Flexible(
              child: CollectionMarkPicker(
                kind: CollectionKind.shelf,
                accent: state.shelf.accent,
                symbol: state.shelf.symbol,
                onSymbolSelected: (symbol) =>
                    context.read<ShelfDetailBloc>().add(ShelfDetailSymbolChanged(symbol)),
                onAccentSelected: (accent) =>
                    context.read<ShelfDetailBloc>().add(ShelfDetailAccentChanged(accent)),
              ),
            ),
          ],
        );
      },
    );
  }
}

class const _ShelfMenu() extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SheetContent(
      children: [
        SheetActionTile(
          icon: Icons.drive_file_rename_outline,
          label: context.s.commonRename,
          onTap: () => Navigator.of(context).pop(_ShelfMenuAction.rename),
        ),
        SheetActionTile(
          icon: Icons.palette_outlined,
          label: context.s.commonChangeMark,
          onTap: () => Navigator.of(context).pop(_ShelfMenuAction.mark),
        ),
        SheetActionTile(
          icon: Icons.delete_outline,
          label: context.s.commonDelete,
          destructive: true,
          onTap: () => Navigator.of(context).pop(_ShelfMenuAction.delete),
        ),
      ],
    );
  }
}

Future<void> _showAddBooks(BuildContext context) async {
  final bloc = context.read<ShelfDetailBloc>();
  await showModalBottomSheet<void>(
    context: context,
    isScrollControlled: true,
    useRootNavigator: true,
    backgroundColor: Colors.transparent,
    builder: (_) => BlocProvider.value(value: bloc, child: const _AddBooksSheet()),
  );
}

class const _AddBooksSheet() extends StatelessWidget {
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
        child: BlocBuilder<ShelfDetailBloc, ShelfDetailState>(
          builder: (context, state) {
            if (state is! ShelfDetailLoaded) return const SizedBox.shrink();
            return ListView(
              controller: scrollController,
              padding: const EdgeInsets.fromLTRB(Spacing.l, Spacing.s, Spacing.l, Spacing.l),
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
                Text(context.s.shelfAddBooksTitle, style: context.t.headlineSmall),
                const SizedBox(height: Spacing.m),
                for (final item in state.allBooks)
                  Padding(
                    padding: const EdgeInsets.only(bottom: Spacing.s),
                    child: _AddBookRow(
                      item: item,
                      selected: state.memberIds.contains(item.book.id),
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

class const _AddBookRow({
  required final ShelfBookItem _item,
  required final bool _selected,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return InkTapBox(
      color: _selected ? context.c.secondaryContainer : context.c.surfaceContainerHigh,
      radius: Spacing.radiusL,
      padding: const EdgeInsets.all(Spacing.s),
      onTap: () => context.read<ShelfDetailBloc>().add(ShelfDetailBookToggled(_item.book.id)),
      child: Row(
        children: [
          BookCover(
            title: _item.book.title,
            url: _item.book.thumbnailUrl,
            width: 40,
            height: 52,
            radius: Spacing.radiusS,
          ),
          const SizedBox(width: Spacing.s),
          Expanded(
            child: Text(
              _item.book.title,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: context.t.titleMedium,
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
