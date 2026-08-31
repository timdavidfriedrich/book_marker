import 'package:core/theme/accent_color.dart';
import 'package:core/theme/spacing.dart';
import 'package:feature_library/presentation/shelf_detail/shelf_detail_bloc.dart';
import 'package:feature_library/presentation/shelf_detail/shelf_detail_event.dart';
import 'package:feature_library/presentation/shelf_detail/shelf_detail_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared/presentation/extensions/accent_extensions.dart';
import 'package:shared/presentation/extensions/app_error_extensions.dart';
import 'package:shared/presentation/extensions/context_extensions.dart';
import 'package:shared/presentation/navigation/navigation_extensions.dart';
import 'package:shared/presentation/widgets/accent_picker.dart';
import 'package:shared/presentation/widgets/book_card.dart';
import 'package:shared/presentation/widgets/book_cover.dart';
import 'package:shared/presentation/widgets/circle_icon_button.dart';
import 'package:shared/presentation/widgets/confirm_dialog.dart';
import 'package:shared/presentation/widgets/ink_tap_box.dart';
import 'package:shared/presentation/widgets/name_input_dialog.dart';
import 'package:shared/presentation/widgets/sheet_action_tile.dart';

const _accentDotSize = 88.0;

enum _ShelfMenuAction { rename, color, delete }

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
    final accent = _state.shelf.accent ?? _state.shelf.id.accent;
    final swatch = context.palette.resolve(accent);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
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
                        onPressed: () => _showShelfMenu(context, _state),
                      ),
                    ],
                  ),
                  const SizedBox(height: Spacing.m),
                  Row(
                    children: [
                      Container(
                        width: _accentDotSize,
                        height: _accentDotSize,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(color: swatch.solid, shape: BoxShape.circle),
                        child: Icon(Icons.collections_bookmark, color: swatch.onSolid, size: Spacing.iconL),
                      ),
                      const SizedBox(width: Spacing.l),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              _state.shelf.name,
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
          ),
        ),
        const SizedBox(height: Spacing.m),
        Expanded(
          child: _state.books.isEmpty
              ? Center(
                  child: Padding(
                    padding: const EdgeInsets.all(Spacing.l),
                    child: Text(
                      context.s.shelfDetailEmpty,
                      textAlign: TextAlign.center,
                      style: context.typography.readingBody.copyWith(color: context.c.onSurfaceVariant),
                    ),
                  ),
                )
              : ListView.separated(
                  padding: const EdgeInsets.fromLTRB(Spacing.l, 0, Spacing.l, Spacing.l),
                  itemCount: _state.books.length,
                  separatorBuilder: (context, index) => const SizedBox(height: Spacing.m),
                  itemBuilder: (context, index) {
                    final item = _state.books[index];
                    return BookCard(
                      accent: item.book.id.accent,
                      title: item.book.title,
                      meta: context.s.libraryQuotesCount(item.quoteCount),
                      count: item.quoteCount,
                      thumbnailUrl: item.book.thumbnailUrl,
                      onTap: () => context.pushBookDetail(item.book.id),
                    );
                  },
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
    case _ShelfMenuAction.color:
      await _showAccentSheet(context, bloc, state.shelf.accent);
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

Future<void> _showAccentSheet(BuildContext context, ShelfDetailBloc bloc, AccentColor? current) async {
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
                bloc.add(ShelfDetailAccentChanged(accent));
                Navigator.of(sheetContext).pop();
              },
            ),
          ],
        ),
      ),
    ),
  );
}

class const _ShelfMenu() extends StatelessWidget {
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
              onTap: () => Navigator.of(context).pop(_ShelfMenuAction.rename),
            ),
            SheetActionTile(
              icon: Icons.palette_outlined,
              label: context.s.commonChangeColor,
              onTap: () => Navigator.of(context).pop(_ShelfMenuAction.color),
            ),
            SheetActionTile(
              icon: Icons.delete_outline,
              label: context.s.commonDelete,
              destructive: true,
              onTap: () => Navigator.of(context).pop(_ShelfMenuAction.delete),
            ),
          ],
        ),
      ),
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
    final accent = _item.book.id.accent;
    return InkTapBox(
      color: _selected ? context.palette.resolve(accent).fill : context.c.surfaceContainerHigh,
      radius: Spacing.radiusL,
      padding: const EdgeInsets.all(Spacing.s),
      onTap: () => context.read<ShelfDetailBloc>().add(ShelfDetailBookToggled(_item.book.id)),
      child: Row(
        children: [
          BookCover(accent: accent, url: _item.book.thumbnailUrl, width: 40, height: 52, radius: Spacing.radiusS),
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
            color: _selected ? context.palette.teal.solid : context.c.outline,
            size: Spacing.iconM,
          ),
        ],
      ),
    );
  }
}
