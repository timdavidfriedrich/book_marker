import 'package:core/theme/spacing.dart';
import 'package:feature_capture/presentation/add_book/add_book_bloc.dart';
import 'package:feature_capture/presentation/add_book/add_book_event.dart';
import 'package:feature_capture/presentation/add_book/add_book_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:shared/domain/entities/book.dart';
import 'package:shared/presentation/extensions/app_error_extensions.dart';
import 'package:shared/presentation/extensions/context_extensions.dart';
import 'package:shared/presentation/extensions/screen_layout_extensions.dart';
import 'package:shared/presentation/navigation/navigation_extensions.dart';
import 'package:shared/presentation/widgets/book_cover.dart';
import 'package:shared/presentation/widgets/circle_icon_button.dart';
import 'package:shared/presentation/widgets/drag_dismiss_sheet.dart';
import 'package:shared/presentation/widgets/ink_tap_box.dart';
import 'package:shared/presentation/widgets/loading_indicator.dart';
import 'package:shared/presentation/widgets/section_label.dart';
import 'package:shared/presentation/widgets/sheet_drag_handle.dart';

const _sheetInitialSize = 0.5;
const _sheetExpandedSize = 0.95;

class const AddBookScreen({
  super.key,
}) extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final controller = useTextEditingController();
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: BlocListener<AddBookBloc, AddBookState>(
        listenWhen: (previous, current) => current is AddBookSaved,
        listener: (context, state) {
          if (state is AddBookSaved) context.closeScreenWithResult(state.bookId);
        },
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: Spacing.contentMaxWidth),
            child: DragDismissSheet(
              restingSize: context.layout.sheetSize(_sheetInitialSize),
              expandedSize: _sheetExpandedSize,
              builder: (context, scrollController) =>
                  _Sheet(controller: controller, scrollController: scrollController),
            ),
          ),
        ),
      ),
    );
  }
}

class const _Sheet({
  required final TextEditingController _controller,
  required final ScrollController _scrollController,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: context.c.surfaceContainerLowest,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(Spacing.radiusXxl)),
      ),
      child: BlocBuilder<AddBookBloc, AddBookState>(
        builder: (context, state) {
          if (state is! AddBookLoaded) {
            return const LoadingIndicator();
          }
          final showTitle = state.query.trim().isEmpty;
          return Column(
            children: [
              const SizedBox(height: Spacing.s),
              const SheetDragHandle(),
              Expanded(
                child: ListView(
                  controller: _scrollController,
                  padding: const EdgeInsets.fromLTRB(Spacing.l, Spacing.l, Spacing.l, Spacing.xxl),
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: showTitle
                              ? Text(context.s.addBookQuestionTitle, style: context.t.headlineSmall)
                              : const SizedBox.shrink(),
                        ),
                        const SizedBox(width: Spacing.s),
                        CircleIconButton(
                          icon: Icons.close,
                          tooltip: context.s.close,
                          onPressed: context.closeScreen,
                        ),
                      ],
                    ),
                    const SizedBox(height: Spacing.m),
                    Row(
                      children: [
                        Expanded(
                          child: _SearchField(controller: _controller, query: state.query),
                        ),
                        const SizedBox(width: Spacing.s),
                        _BarcodeButton(controller: _controller),
                      ],
                    ),
                    const SizedBox(height: Spacing.l),
                    if (state.libraryMatches.isNotEmpty) ...[
                      SectionLabel(
                        text: context.s.addBookInLibraryLabel,
                        dotColor: context.c.secondary,
                      ),
                      const SizedBox(height: Spacing.s),
                      for (final book in state.libraryMatches) ...[
                        _OwnedTile(book: book),
                        const SizedBox(height: Spacing.s),
                      ],
                    ],
                    if (state.query.trim().isNotEmpty) ...[
                      const SizedBox(height: Spacing.s),
                      SectionLabel(
                        text: context.s.addBookNotInLibraryLabel,
                        dotColor: context.c.outline,
                      ),
                      const SizedBox(height: Spacing.s),
                      _CatalogueSection(state: state),
                    ],
                    const SizedBox(height: Spacing.l),
                    Text(
                      context.s.addBookCatalogueFooter,
                      style: context.typography.label.copyWith(
                        color: context.c.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class const _SearchField({
  required final TextEditingController _controller,
  required final String _query,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: _controller,
      textInputAction: TextInputAction.search,
      style: context.t.bodyLarge,
      onChanged: (value) => context.read<AddBookBloc>().add(AddBookQueryChanged(value)),
      decoration: InputDecoration(
        hintText: context.s.addBookSearchHint,
        prefixIcon: Icon(Icons.search, color: context.c.onSurfaceVariant),
        suffixIcon: _query.isEmpty
            ? null
            : IconButton(
                icon: Icon(Icons.close, color: context.c.onSurfaceVariant),
                onPressed: () {
                  _controller.clear();
                  context.read<AddBookBloc>().add(const AddBookQueryChanged(""));
                },
              ),
      ),
    );
  }
}

class const _BarcodeButton({
  required final TextEditingController _controller,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () => _scanBarcode(context, _controller),
      tooltip: context.s.addBookScanButton,
      icon: const Icon(Icons.qr_code_scanner),
      iconSize: Spacing.iconM,
      style: IconButton.styleFrom(
        backgroundColor: context.c.inverseSurface,
        foregroundColor: context.c.primary,
        fixedSize: const Size.square(56),
        minimumSize: const Size.square(56),
        padding: EdgeInsets.zero,
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(Spacing.radiusL)),
      ),
    );
  }
}

class const _OwnedTile({
  required final Book _book,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(Spacing.s),
      decoration: BoxDecoration(
        color: context.c.secondaryContainer,
        borderRadius: BorderRadius.circular(Spacing.radiusL),
      ),
      child: Row(
        children: [
          BookCover(
            title: _book.title,
            image: _book.coverImage,
            width: 44,
            height: 56,
            radius: Spacing.radiusS,
          ),
          const SizedBox(width: Spacing.s),
          Expanded(
            child: _TileText(
              book: _book,
              titleColor: context.c.onSecondaryContainer,
              subtitleColor: context.c.onSurfaceVariant,
            ),
          ),
          const SizedBox(width: Spacing.s),
          _PillButton(
            label: context.s.addBookSelectButton,
            background: context.c.secondary,
            foreground: context.c.onSecondary,
            onTap: () => context.closeScreenWithResult(_book.id),
          ),
        ],
      ),
    );
  }
}

class const _CatalogueSection({
  required final AddBookLoaded _state,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    if (_state.isCatalogueLoading) {
      return const Padding(
        padding: EdgeInsets.all(Spacing.l),
        child: LoadingIndicator(),
      );
    }
    if (_state.catalogueError case final error?) {
      return Padding(
        padding: const EdgeInsets.all(Spacing.m),
        child: Text(
          error.toMessage(context),
          style: context.t.bodyMedium?.copyWith(color: context.c.onSurfaceVariant),
        ),
      );
    }
    if (_state.catalogueResults.isEmpty) {
      return Padding(
        padding: const EdgeInsets.all(Spacing.m),
        child: Text(
          context.s.addBookNoCatalogueResults,
          style: context.t.bodyMedium?.copyWith(color: context.c.onSurfaceVariant),
        ),
      );
    }
    return Column(
      children: [
        for (final book in _state.catalogueResults) ...[
          _CatalogueTile(book: book),
          const SizedBox(height: Spacing.s),
        ],
      ],
    );
  }
}

class const _CatalogueTile({
  required final Book _book,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(Spacing.s),
      decoration: BoxDecoration(
        color: context.c.surfaceContainerHigh,
        borderRadius: BorderRadius.circular(Spacing.radiusL),
      ),
      child: Row(
        children: [
          BookCover(
            title: _book.title,
            image: _book.coverImage,
            width: 44,
            height: 56,
            radius: Spacing.radiusS,
          ),
          const SizedBox(width: Spacing.s),
          Expanded(
            child: _TileText(
              book: _book,
              titleColor: context.c.onSurface,
              subtitleColor: context.c.onSurfaceVariant,
            ),
          ),
          const SizedBox(width: Spacing.s),
          _PillButton(
            label: context.s.addBookAddButton,
            background: context.c.inverseSurface,
            foreground: context.c.onInverseSurface,
            onTap: () => context.read<AddBookBloc>().add(AddBookCatalogueSelected(_book)),
          ),
        ],
      ),
    );
  }
}

class const _TileText({
  required final Book _book,
  required final Color _titleColor,
  required final Color _subtitleColor,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final authors = _book.authors.isEmpty ? context.s.bookAuthorsUnknown : _book.authors.join(", ");
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          _book.title,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: context.t.titleMedium?.copyWith(color: _titleColor),
        ),
        const SizedBox(height: Spacing.xxxs),
        Text(
          authors,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: context.typography.label.copyWith(color: _subtitleColor),
        ),
      ],
    );
  }
}

class const _PillButton({
  required final String _label,
  required final Color _background,
  required final Color _foreground,
  required final VoidCallback _onTap,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return InkTapBox(
      onTap: _onTap,
      color: _background,
      radius: Spacing.radiusFull,
      padding: const EdgeInsets.symmetric(horizontal: Spacing.m, vertical: Spacing.xs),
      child: Text(
        _label,
        style: context.t.labelMedium?.copyWith(color: _foreground, fontSize: 14),
      ),
    );
  }
}

Future<void> _scanBarcode(BuildContext context, TextEditingController controller) async {
  final addBookBloc = context.read<AddBookBloc>();
  final code = await context.pushBarcodeScanner();
  if (code == null) return;
  controller.text = code;
  addBookBloc.add(AddBookQueryChanged(code));
}
