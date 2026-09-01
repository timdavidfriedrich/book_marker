import 'package:core/error/app_error.dart';
import 'package:core/theme/spacing.dart';
import 'package:feature_library/presentation/extensions/book_status_extensions.dart';
import 'package:feature_library/presentation/library/library_bloc.dart';
import 'package:feature_library/presentation/library/library_event.dart';
import 'package:feature_library/presentation/library/library_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:shared/presentation/extensions/app_error_extensions.dart';
import 'package:shared/presentation/extensions/context_extensions.dart';
import 'package:shared/presentation/extensions/page_number_extensions.dart';
import 'package:shared/presentation/extensions/screen_layout_extensions.dart';
import 'package:shared/presentation/navigation/navigation_extensions.dart';
import 'package:shared/presentation/widgets/book_card.dart';
import 'package:shared/presentation/widgets/book_cover.dart';
import 'package:shared/presentation/widgets/collection_mark.dart';
import 'package:shared/presentation/widgets/columned_sliver_list.dart';
import 'package:shared/presentation/widgets/floating_header.dart';
import 'package:shared/presentation/widgets/ink_tap_box.dart';
import 'package:shared/presentation/widgets/name_input_dialog.dart';
import 'package:shared/presentation/widgets/pinned_header.dart';
import 'package:shared/presentation/widgets/quote_card.dart';
import 'package:shared/presentation/widgets/section_label.dart';
import 'package:shared/presentation/widgets/segmented_toggle.dart';
import 'package:shared/presentation/widgets/selectable_chip.dart';
import 'package:shared/presentation/widgets/tab_header.dart';

const _searchFieldHeight = 56.0;
const _chipHeight = 32.0;
const _wideTitleBarHeight = _searchFieldHeight + Spacing.m + Spacing.s;
const _headerHeight = _searchFieldHeight + Spacing.m + segmentedToggleHeight + Spacing.xs;
const _wideHeaderHeight = segmentedToggleHeight + Spacing.xs;
const _chipsHeight = Spacing.xs + _chipHeight + Spacing.m;
const _toggleMaxWidth = 480.0;
const _shelfPreviewOffset = 22.0;
const _shelfPreviewWidth = 84.0;
const _shelfPreviewHeight = 64.0;
const _shelfMarkSize = 56.0;
const _newShelfIconSize = 44.0;

class const LibraryScreen({
  super.key,
}) extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final controller = useTextEditingController();
    return Scaffold(
      // * resizing would squeeze the short landscape viewport to nothing while typing
      resizeToAvoidBottomInset: !context.layout.isLandscape,
      body: SafeArea(
        bottom: false,
        child: BlocBuilder<LibraryBloc, LibraryState>(
          builder: (context, state) => switch (state) {
            LibraryLoading() => const Center(child: CircularProgressIndicator()),
            LibraryFailure(:final error) => _Failure(error: error),
            LibraryLoaded() => _Loaded(state: state, controller: controller),
          },
        ),
      ),
    );
  }
}

class const _Loaded({
  required final LibraryLoaded _state,
  required final TextEditingController _controller,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final layout = context.layout;
    return CustomScrollView(
      slivers: [
        if (layout.isWide)
          PinnedHeader(
            height: _wideTitleBarHeight,
            child: TabHeader(
              title: context.s.libraryTitle,
              contentHeight: _searchFieldHeight,
              center: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: Spacing.searchFieldMaxWidth),
                child: SizedBox(
                  height: _searchFieldHeight,
                  child: _SearchField(controller: _controller, state: _state),
                ),
              ),
            ),
          )
        else if (!_state.isSearching)
          PinnedHeader(
            height: tabHeaderHeight,
            child: TabHeader(title: context.s.libraryTitle),
          ),
        FloatingHeader(
          height: layout.isWide ? _wideHeaderHeight : _headerHeight,
          child: _Header(state: _state, controller: _controller),
        ),
        switch (_state.view) {
          LibraryView.books => _BooksView(state: _state),
          LibraryView.shelves => _ShelvesView(state: _state),
          LibraryView.quotes => _QuotesView(state: _state),
        },
      ],
    );
  }
}

class const _Header({
  required final LibraryLoaded _state,
  required final TextEditingController _controller,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final layout = context.layout;
    final toggle = ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: _toggleMaxWidth),
      child: SegmentedToggle(
        labels: [
          context.s.libraryTabBooks,
          context.s.libraryTabShelves,
          context.s.libraryTabQuotes,
        ],
        selectedIndex: _state.view.index,
        onChanged: (index) =>
            context.read<LibraryBloc>().add(LibraryViewChanged(LibraryView.values[index])),
      ),
    );
    return ColoredBox(
      color: context.c.surface,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: layout.pageMargin),
        child: layout.isWide
            ? Align(alignment: Alignment.centerLeft, child: toggle)
            : Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SizedBox(
                    height: _searchFieldHeight,
                    child: _SearchField(controller: _controller, state: _state),
                  ),
                  const SizedBox(height: Spacing.m),
                  toggle,
                ],
              ),
      ),
    );
  }
}

class const _SearchField({
  required final TextEditingController _controller,
  required final LibraryLoaded _state,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: _controller,
      textInputAction: TextInputAction.search,
      style: context.t.bodyLarge,
      onChanged: (value) => context.read<LibraryBloc>().add(LibraryQueryChanged(value)),
      decoration: InputDecoration(
        hintText: _searchHint(context, _state.view),
        prefixIcon: Icon(Icons.search, color: context.c.onSurfaceVariant),
        suffixIcon: _state.isSearching
            ? IconButton(
                icon: Icon(Icons.close, color: context.c.onSurfaceVariant),
                onPressed: () {
                  _controller.clear();
                  context.read<LibraryBloc>().add(const LibraryQueryChanged(""));
                },
              )
            : null,
      ),
    );
  }
}

class const _BooksView({
  required final LibraryLoaded _state,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SliverMainAxisGroup(
      slivers: [
        _FilterChips(
          chips: [
            for (final filter in LibraryFilter.values)
              _FilterChip(
                label: _filterLabel(context, filter, _state),
                selected: _state.filter == filter,
                onTap: () => context.read<LibraryBloc>().add(LibraryFilterChanged(filter)),
              ),
          ],
        ),
        if (_state.books.isEmpty)
          _EmptyMessage(
            text: _state.totalBooks == 0
                ? context.s.libraryBooksEmptyMessage
                : context.s.filterNoResultsMessage,
          )
        else ...[
          if (_state.isSearching)
            _ResultCount(text: context.s.libraryBooksCount(_state.books.length)),
          _BookCards(summaries: _state.books),
          const _BottomSpacer(),
        ],
      ],
    );
  }
}

class const _ShelvesView({
  required final LibraryLoaded _state,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    if (_state.shelves.isEmpty && _state.isSearching) {
      return _EmptyMessage(text: context.s.filterNoResultsMessage);
    }
    return SliverMainAxisGroup(
      slivers: [
        const _NoChipsSpacer(),
        if (_state.isSearching)
          _ResultCount(text: context.s.libraryShelvesCount(_state.shelves.length)),
        _ShelfCards(summaries: _state.shelves, withNewTile: !_state.isSearching),
        const _BottomSpacer(),
      ],
    );
  }
}

class const _QuotesView({
  required final LibraryLoaded _state,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SliverMainAxisGroup(
      slivers: [
        _FilterChips(
          chips: [
            for (final filter in LibraryQuoteFilter.values)
              _FilterChip(
                label: _quoteFilterLabel(context, filter, _state),
                selected: _state.quoteFilter == filter,
                onTap: () => context.read<LibraryBloc>().add(LibraryQuoteFilterChanged(filter)),
              ),
          ],
        ),
        if (_state.quotes.isEmpty)
          _EmptyMessage(
            text: _state.totalQuotes == 0
                ? context.s.libraryEmptyMessage
                : context.s.filterNoResultsMessage,
          )
        else ...[
          if (_state.isSearching)
            _ResultCount(text: context.s.libraryQuotesCount(_state.quotes.length)),
          _QuoteCards(results: _state.quotes),
          const _BottomSpacer(),
        ],
      ],
    );
  }
}

class const _FilterChips({
  required final List<Widget> _chips,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return PinnedHeader(
      height: _chipsHeight,
      child: ColoredBox(
        color: context.c.surface,
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          padding: EdgeInsets.fromLTRB(
            context.layout.pageMargin,
            Spacing.xs,
            context.layout.pageMargin,
            Spacing.m,
          ),
          child: Row(
            children: [
              for (final (index, chip) in _chips.indexed) ...[
                if (index > 0) const SizedBox(width: Spacing.xs),
                chip,
              ],
            ],
          ),
        ),
      ),
    );
  }
}

class const _FilterChip({
  required final String _label,
  required final bool _selected,
  required final VoidCallback _onTap,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SelectableChip(
      label: _label,
      selected: _selected,
      selectedColor: context.c.inverseSurface,
      selectedTextColor: context.c.onInverseSurface,
      onTap: _onTap,
    );
  }
}

class const _BookCards({
  required final List<LibraryBookSummary> _summaries,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: EdgeInsets.symmetric(horizontal: context.layout.pageMargin),
      sliver: ColumnedSliverList(
        itemCount: _summaries.length,
        columns: context.layout.cardColumns,
        itemBuilder: (context, index) {
          final summary = _summaries[index];
          final book = summary.book;
          final featured = summary.featuredQuote;
          return BookCard(
            title: book.title,
            meta: _bookMeta(context, summary, book.status.toSummaryLabel(context)),
            count: summary.quoteCount,
            coverImage: book.coverImage,
            featuredQuote: featured == null ? null : "“${featured.quote}”",
            featuredPages: featured?.pageNumbers ?? const [],
            onTap: () => context.pushBookDetail(book.id),
          );
        },
      ),
    );
  }
}

class const _QuoteCards({
  required final List<LibraryQuoteResult> _results,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: EdgeInsets.symmetric(horizontal: context.layout.pageMargin),
      sliver: ColumnedSliverList(
        itemCount: _results.length,
        columns: context.layout.cardColumns,
        itemBuilder: (context, index) {
          final result = _results[index];
          final book = result.book;
          final quote = result.quote;
          final pages = quote.pageNumbers;
          final voiceNoteMs = quote.voiceNoteDurationMs;
          return QuoteCard(
            quote: "“${quote.quote}”",
            bookTitle: book.title,
            coverImage: book.coverImage,
            pages: pages,
            sourceLabel: pages.isEmpty
                ? book.title
                : context.s.quoteSourceLabel(book.title, pages.toPageLabel()),
            isFavorite: quote.isFavorite,
            hasVoiceNote: quote.voiceNotePath != null,
            voiceNoteDuration: voiceNoteMs == null ? null : Duration(milliseconds: voiceNoteMs),
            voiceNotePath: quote.voiceNotePath,
            onTap: () => context.pushQuoteDetail(quote.id),
          );
        },
      ),
    );
  }
}

class const _ShelfCards({
  required final List<LibraryShelfSummary> _summaries,
  final bool _withNewTile = false,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: EdgeInsets.symmetric(horizontal: context.layout.pageMargin),
      sliver: ColumnedSliverList(
        itemCount: _summaries.length + (_withNewTile ? 1 : 0),
        columns: context.layout.cardColumns,
        itemBuilder: (context, index) {
          if (index == _summaries.length) {
            return _NewShelfTile(onTap: () => _promptNewShelf(context));
          }
          return _ShelfCard(summary: _summaries[index]);
        },
      ),
    );
  }
}

class const _ResultCount({
  required final String _text,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: EdgeInsets.fromLTRB(
          context.layout.pageMargin,
          Spacing.xs,
          context.layout.pageMargin,
          Spacing.s,
        ),
        child: SectionLabel(text: _text, dotColor: context.c.outline),
      ),
    );
  }
}

class const _NoChipsSpacer() extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const SliverToBoxAdapter(child: SizedBox(height: Spacing.m));
  }
}

class const _BottomSpacer() extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const SliverToBoxAdapter(child: SizedBox(height: Spacing.xxl));
  }
}

class const _EmptyMessage({
  required final String _text,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SliverFillRemaining(
      hasScrollBody: false,
      child: Padding(
        padding: const EdgeInsets.all(Spacing.l),
        child: Text(
          _text,
          textAlign: TextAlign.center,
          style: context.typography.readingBody.copyWith(color: context.c.onSurfaceVariant),
        ),
      ),
    );
  }
}

class const _ShelfCard({
  required final LibraryShelfSummary _summary,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final shelf = _summary.shelf;
    final swatch = context.palette.resolve(shelf.accent);
    return InkTapBox(
      color: swatch.fill,
      radius: Spacing.radiusXl,
      padding: const EdgeInsets.all(Spacing.m),
      onTap: () => context.pushShelfDetail(shelf.id),
      child: Row(
        children: [
          CollectionMark(
            kind: CollectionKind.shelf,
            accent: shelf.accent,
            symbol: shelf.symbol,
            size: _shelfMarkSize,
          ),
          const SizedBox(width: Spacing.m),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  shelf.name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: context.t.headlineSmall?.copyWith(color: swatch.onFill),
                ),
                const SizedBox(height: Spacing.xxs),
                Text(
                  context.s.libraryShelfMeta(_summary.bookCount, _summary.quoteCount),
                  style: context.typography.label.copyWith(color: swatch.onFillVariant),
                ),
              ],
            ),
          ),
          if (_summary.previewBooks.isNotEmpty) ...[
            const SizedBox(width: Spacing.s),
            SizedBox(
              width: _shelfPreviewWidth,
              height: _shelfPreviewHeight,
              child: Stack(
                children: [
                  for (final (index, book) in _summary.previewBooks.indexed)
                    Positioned(
                      left: index * _shelfPreviewOffset,
                      child: BookCover(
                        title: book.title,
                        image: book.coverImage,
                        width: 40,
                        height: 56,
                        radius: Spacing.radiusS,
                      ),
                    ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class const _NewShelfTile({
  required final VoidCallback _onTap,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return InkTapBox(
      color: context.c.surfaceContainerHigh,
      radius: Spacing.radiusXl,
      padding: const EdgeInsets.all(Spacing.m),
      onTap: _onTap,
      child: Row(
        children: [
          Container(
            width: _newShelfIconSize,
            height: _newShelfIconSize,
            alignment: Alignment.center,
            decoration: ShapeDecoration(
              color: context.c.surfaceContainerLowest,
              shape: CollectionKind.shelf.toShape(_newShelfIconSize),
            ),
            child: Icon(Icons.add, color: context.c.onSurfaceVariant, size: Spacing.iconM),
          ),
          const SizedBox(width: Spacing.m),
          Text(context.s.libraryNewShelfLabel, style: context.t.headlineSmall),
        ],
      ),
    );
  }
}

Future<void> _promptNewShelf(BuildContext context) async {
  final bloc = context.read<LibraryBloc>();
  final name = await showNameInputDialog(
    context,
    title: context.s.libraryNewShelfTitle,
    hint: context.s.libraryNewShelfHint,
  );
  if (name != null && name.trim().isNotEmpty) bloc.add(LibraryShelfCreateRequested(name));
}

class const _Failure({
  required final AppError _error,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(Spacing.l),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(_error.toMessage(context), textAlign: TextAlign.center),
            const SizedBox(height: Spacing.m),
            FilledButton(
              onPressed: () => context.read<LibraryBloc>().add(const LibraryStarted()),
              child: Text(context.s.tryAgain),
            ),
          ],
        ),
      ),
    );
  }
}

String _searchHint(BuildContext context, LibraryView view) {
  return switch (view) {
    LibraryView.books => context.s.librarySearchBooksHint,
    LibraryView.shelves => context.s.librarySearchShelvesHint,
    LibraryView.quotes => context.s.librarySearchQuotesHint,
  };
}

String _bookMeta(BuildContext context, LibraryBookSummary summary, String? statusLabel) {
  if (summary.favoriteCount == 0) {
    return statusLabel == null
        ? context.s.libraryQuotesCount(summary.quoteCount)
        : context.s.libraryBookMetaStatus(summary.quoteCount, statusLabel);
  }
  return statusLabel == null
      ? context.s.libraryBookMeta(summary.quoteCount, summary.favoriteCount)
      : context.s.libraryBookMetaWithStatus(
          summary.quoteCount,
          summary.favoriteCount,
          statusLabel,
        );
}

String _quoteFilterLabel(
  BuildContext context,
  LibraryQuoteFilter filter,
  LibraryLoaded state,
) {
  return switch (filter) {
    LibraryQuoteFilter.all => context.s.libraryFilterAll(state.totalQuotes),
    LibraryQuoteFilter.favorites => context.s.libraryFilterFavorites(state.totalFavorites),
  };
}

String _filterLabel(BuildContext context, LibraryFilter filter, LibraryLoaded state) {
  return switch (filter) {
    LibraryFilter.all => context.s.libraryFilterAll(state.totalBooks),
    LibraryFilter.reading => context.s.libraryFilterReading(state.readingCount),
    LibraryFilter.paused => context.s.libraryFilterPaused(state.pausedCount),
    LibraryFilter.finished => context.s.libraryFilterFinished(state.finishedCount),
  };
}
