import 'package:core/error/app_error.dart';
import 'package:core/theme/spacing.dart';
import 'package:feature_library/presentation/extensions/book_status_extensions.dart';
import 'package:feature_library/presentation/library/library_bloc.dart';
import 'package:feature_library/presentation/library/library_event.dart';
import 'package:feature_library/presentation/library/library_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:shared/presentation/extensions/accent_extensions.dart';
import 'package:shared/presentation/extensions/app_error_extensions.dart';
import 'package:shared/presentation/extensions/context_extensions.dart';
import 'package:shared/presentation/navigation/navigation_extensions.dart';
import 'package:shared/presentation/widgets/book_card.dart';
import 'package:shared/presentation/widgets/book_cover.dart';
import 'package:shared/presentation/widgets/circle_icon_button.dart';
import 'package:shared/presentation/widgets/count_badge.dart';
import 'package:shared/presentation/widgets/ink_tap_box.dart';
import 'package:shared/presentation/widgets/name_input_dialog.dart';
import 'package:shared/presentation/widgets/profile_avatar.dart';
import 'package:shared/presentation/widgets/quote_card.dart';
import 'package:shared/presentation/widgets/segmented_toggle.dart';
import 'package:shared/presentation/widgets/selectable_chip.dart';

class const LibraryScreen({
  super.key,
}) extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final controller = useTextEditingController();
    return Scaffold(
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
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: Spacing.l),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(height: Spacing.m),
          if (!_state.isSearching) ...[
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Text(context.s.libraryTitle, style: context.t.displaySmall),
                ),
                ProfileAvatar(onTap: () => context.pushSettings()),
              ],
            ),
            const SizedBox(height: Spacing.m),
          ],
          _SearchField(controller: _controller, showClear: _state.isSearching),
          const SizedBox(height: Spacing.m),
          if (_state.isSearching)
            Expanded(child: _SearchResults(state: _state))
          else
            Expanded(child: _BooksArea(state: _state)),
        ],
      ),
    );
  }
}

class const _SearchField({
  required final TextEditingController _controller,
  required final bool _showClear,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: _controller,
      textInputAction: TextInputAction.search,
      style: context.t.bodyLarge,
      onChanged: (value) => context.read<LibraryBloc>().add(LibraryQueryChanged(value)),
      decoration: InputDecoration(
        hintText: context.s.librarySearchHint,
        prefixIcon: Icon(Icons.search, color: context.c.onSurfaceVariant),
        suffixIcon: _showClear
            ? IconButton(
                icon: Icon(Icons.close, color: context.c.onSurfaceVariant),
                onPressed: () {
                  _controller.clear();
                  context.read<LibraryBloc>()
                    ..add(const LibraryQueryChanged(""))
                    ..add(const LibrarySearchScopeChanged(LibrarySearchScope.allBooks));
                },
              )
            : null,
      ),
    );
  }
}

class const _BooksArea({
  required final LibraryLoaded _state,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final isBooks = _state.view == LibraryView.books;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          children: [
            SegmentedToggle(
              labels: [context.s.libraryTabBooks, context.s.libraryTabShelves],
              selectedIndex: isBooks ? 0 : 1,
              onChanged: (index) => context.read<LibraryBloc>().add(
                LibraryViewChanged(index == 0 ? LibraryView.books : LibraryView.shelves),
              ),
            ),
            const Spacer(),
            if (isBooks)
              _FavoriteButton(
                onTap: () => context.read<LibraryBloc>().add(
                  const LibrarySearchScopeChanged(LibrarySearchScope.favorites),
                ),
              )
            else
              SelectableChip(
                label: context.s.libraryAddShelfLabel,
                selected: false,
                onTap: () => _promptNewShelf(context),
              ),
          ],
        ),
        const SizedBox(height: Spacing.m),
        if (isBooks)
          Expanded(child: _BookList(state: _state))
        else
          Expanded(child: _ShelvesList(state: _state)),
      ],
    );
  }
}

class const _BookList({
  required final LibraryLoaded _state,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              for (final (index, filter) in LibraryFilter.values.indexed) ...[
                if (index > 0) const SizedBox(width: Spacing.xs),
                SelectableChip(
                  label: _filterLabel(context, filter, _state),
                  selected: _state.filter == filter,
                  onTap: () =>
                      context.read<LibraryBloc>().add(LibraryFilterChanged(filter)),
                ),
              ],
            ],
          ),
        ),
        const SizedBox(height: Spacing.m),
        Expanded(
          child: _state.books.isEmpty
              ? Center(
                  child: Padding(
                    padding: const EdgeInsets.all(Spacing.l),
                    child: Text(
                      context.s.libraryEmptyMessage,
                      textAlign: TextAlign.center,
                      style: context.typography.readingBody.copyWith(
                        color: context.c.onSurfaceVariant,
                      ),
                    ),
                  ),
                )
              : ListView.separated(
                  padding: const EdgeInsets.only(bottom: Spacing.xxl),
                  itemCount: _state.books.length,
                  separatorBuilder: (context, index) => const SizedBox(height: Spacing.m),
                  itemBuilder: (context, index) {
                    final summary = _state.books[index];
                    final book = summary.book;
                    final featured = summary.featuredQuote;
                    final statusLabel = book.status.toSummaryLabel(context);
                    return BookCard(
                      accent: book.id.accent,
                      title: book.title,
                      meta: statusLabel == null
                          ? context.s.libraryBookMeta(summary.quoteCount, summary.favoriteCount)
                          : context.s.libraryBookMetaWithStatus(
                              summary.quoteCount,
                              summary.favoriteCount,
                              statusLabel,
                            ),
                      count: summary.quoteCount,
                      thumbnailUrl: book.thumbnailUrl,
                      featuredQuote: featured == null ? null : "“${featured.quote}”",
                      featuredPage: featured?.pageNumber,
                      onTap: () => context.pushBookDetail(book.id),
                    );
                  },
                ),
        ),
      ],
    );
  }
}

class const _ShelvesList({
  required final LibraryLoaded _state,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    if (_state.shelves.isEmpty) {
      return Align(
        alignment: Alignment.topCenter,
        child: _NewShelfTile(onTap: () => _promptNewShelf(context)),
      );
    }
    return ListView.separated(
      padding: const EdgeInsets.only(bottom: Spacing.xxl),
      itemCount: _state.shelves.length + 1,
      separatorBuilder: (context, index) => const SizedBox(height: Spacing.m),
      itemBuilder: (context, index) {
        if (index == _state.shelves.length) {
          return _NewShelfTile(onTap: () => _promptNewShelf(context));
        }
        return _ShelfCard(summary: _state.shelves[index]);
      },
    );
  }
}

class const _ShelfCard({
  required final LibraryShelfSummary _summary,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final accent = _summary.shelf.accent ?? _summary.shelf.id.accent;
    final swatch = context.palette.resolve(accent);
    return InkTapBox(
      color: swatch.fill,
      radius: Spacing.radiusXl,
      padding: const EdgeInsets.all(Spacing.m),
      onTap: () => context.pushShelfDetail(_summary.shelf.id),
      child: Row(
        children: [
          SizedBox(
            width: 84,
            height: 64,
            child: Stack(
              children: [
                for (final entry in _summary.previewBooks.take(3).toList().asMap().entries)
                  Positioned(
                    left: entry.key * 22.0,
                    child: BookCover(
                      accent: entry.value.id.accent,
                      url: entry.value.thumbnailUrl,
                      width: 40,
                      height: 56,
                      radius: Spacing.radiusS,
                    ),
                  ),
              ],
            ),
          ),
          const SizedBox(width: Spacing.m),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  _summary.shelf.name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: context.t.headlineSmall?.copyWith(color: swatch.onFill),
                ),
                const SizedBox(height: Spacing.xxs),
                Text(
                  context.s.libraryShelfMeta(_summary.bookCount, _summary.quoteCount),
                  style: context.typography.monoLabel.copyWith(color: swatch.onFillVariant),
                ),
              ],
            ),
          ),
          const SizedBox(width: Spacing.s),
          CountBadge(count: _summary.bookCount, accent: accent),
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
            width: 44,
            height: 44,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: context.c.surfaceContainerLowest,
              shape: BoxShape.circle,
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

class const _SearchResults({
  required final LibraryLoaded _state,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bookCount = _state.results.map((result) => result.book.id).toSet().length;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          children: [
            SelectableChip(
              label: context.s.librarySearchScopeAll,
              selected: _state.searchScope == LibrarySearchScope.allBooks,
              selectedColor: context.c.inverseSurface,
              selectedTextColor: context.c.onInverseSurface,
              onTap: () => context.read<LibraryBloc>().add(
                const LibrarySearchScopeChanged(LibrarySearchScope.allBooks),
              ),
            ),
            const SizedBox(width: Spacing.xs),
            SelectableChip(
              label: context.s.librarySearchScopeFavorites,
              selected: _state.searchScope == LibrarySearchScope.favorites,
              selectedColor: context.c.inverseSurface,
              selectedTextColor: context.c.onInverseSurface,
              onTap: () => context.read<LibraryBloc>().add(
                const LibrarySearchScopeChanged(LibrarySearchScope.favorites),
              ),
            ),
            const SizedBox(width: Spacing.xs),
            SelectableChip(
              label: context.s.librarySearchScopeNotes,
              selected: _state.searchScope == LibrarySearchScope.myNotes,
              selectedColor: context.c.inverseSurface,
              selectedTextColor: context.c.onInverseSurface,
              onTap: () => context.read<LibraryBloc>().add(
                const LibrarySearchScopeChanged(LibrarySearchScope.myNotes),
              ),
            ),
          ],
        ),
        const SizedBox(height: Spacing.m),
        Text(
          context.s.librarySearchCount(_state.results.length, bookCount),
          style: context.typography.monoLabel.copyWith(color: context.c.onSurfaceVariant),
        ),
        const SizedBox(height: Spacing.m),
        Expanded(
          child: ListView.separated(
            padding: const EdgeInsets.only(bottom: Spacing.xxl),
            itemCount: _state.results.length,
            separatorBuilder: (context, index) => const SizedBox(height: Spacing.m),
            itemBuilder: (context, index) {
              final result = _state.results[index];
              final book = result.book;
              final accent = book.id.accent;
              final page = result.quote.pageNumber;
              final source = page == null
                  ? book.title
                  : context.s.quoteSourceLabel(book.title, page);
              return QuoteCard(
                accent: accent,
                quote: "“${result.quote.quote}”",
                thumbnailUrl: book.thumbnailUrl,
                sourceLabel: source,
                backgroundColor: context.palette.resolve(accent).fill,
                onTap: () => context.pushQuoteDetail(result.quote.id),
              );
            },
          ),
        ),
      ],
    );
  }
}

class const _FavoriteButton({
  required final VoidCallback _onTap,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CircleIconButton(
      icon: Icons.star_rounded,
      tooltip: context.s.librarySearchScopeFavorites,
      backgroundColor: context.palette.amber.fill,
      foregroundColor: context.palette.amber.solid,
      onPressed: _onTap,
    );
  }
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

String _filterLabel(BuildContext context, LibraryFilter filter, LibraryLoaded state) {
  return switch (filter) {
    LibraryFilter.all => context.s.libraryFilterAll(state.totalBooks),
    LibraryFilter.reading => context.s.libraryFilterReading(state.readingCount),
    LibraryFilter.paused => context.s.libraryFilterPaused(state.pausedCount),
    LibraryFilter.finished => context.s.libraryFilterFinished(state.finishedCount),
  };
}
