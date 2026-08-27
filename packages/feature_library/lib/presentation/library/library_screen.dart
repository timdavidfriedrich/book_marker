import 'package:core/error/app_error.dart';
import 'package:core/theme/spacing.dart';
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
import 'package:shared/presentation/widgets/circle_icon_button.dart';
import 'package:shared/presentation/widgets/mark_card.dart';
import 'package:shared/presentation/widgets/profile_avatar.dart';
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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(context.s.libraryTitle, style: context.t.displaySmall),
                      const SizedBox(height: Spacing.xxs),
                      Text(
                        context.s.libraryHeaderStats(_state.totalBooks, _state.totalMarks),
                        style: context.typography.monoLabel.copyWith(color: context.c.onSurfaceVariant),
                      ),
                    ],
                  ),
                ),
                const ProfileAvatar(),
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
              _StarButton(
                onTap: () => context
                    .read<LibraryBloc>()
                    .add(const LibrarySearchScopeChanged(LibrarySearchScope.starred)),
              )
            else
              SelectableChip(
                label: context.s.libraryAddShelfLabel,
                selected: false,
                onTap: () {},
              ),
          ],
        ),
        const SizedBox(height: Spacing.m),
        if (isBooks)
          Expanded(child: _BookList(state: _state))
        else
          const Expanded(child: _ShelvesPlaceholder()),
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
        Row(
          children: [
            SelectableChip(
              label: context.s.libraryFilterAll(_state.totalBooks),
              selected: _state.filter == LibraryFilter.all,
              onTap: () => context
                  .read<LibraryBloc>()
                  .add(const LibraryFilterChanged(LibraryFilter.all)),
            ),
            const SizedBox(width: Spacing.xs),
            SelectableChip(
              label: context.s.libraryFilterReading(_state.readingCount),
              selected: _state.filter == LibraryFilter.reading,
              onTap: () => context
                  .read<LibraryBloc>()
                  .add(const LibraryFilterChanged(LibraryFilter.reading)),
            ),
            const SizedBox(width: Spacing.xs),
            SelectableChip(
              label: context.s.libraryFilterFinished(_state.finishedCount),
              selected: _state.filter == LibraryFilter.finished,
              onTap: () => context
                  .read<LibraryBloc>()
                  .add(const LibraryFilterChanged(LibraryFilter.finished)),
            ),
          ],
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
                      style: context.typography.readingBody.copyWith(color: context.c.onSurfaceVariant),
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
                    final featured = summary.featuredMark;
                    return BookCard(
                      accent: book.id.accent,
                      title: book.title,
                      meta:
                          "${context.s.libraryMarksCount(summary.markCount)} · ${context.s.libraryStarredCount(summary.starredCount)} · ${context.s.libraryStatusReading}",
                      count: summary.markCount,
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

class const _ShelvesPlaceholder() extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(Spacing.l),
        child: Text(
          context.s.libraryShelvesPlaceholder,
          textAlign: TextAlign.center,
          style: context.typography.readingBody.copyWith(color: context.c.onSurfaceVariant),
        ),
      ),
    );
  }
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
              onTap: () => context
                  .read<LibraryBloc>()
                  .add(const LibrarySearchScopeChanged(LibrarySearchScope.allBooks)),
            ),
            const SizedBox(width: Spacing.xs),
            SelectableChip(
              label: context.s.librarySearchScopeStarred,
              selected: _state.searchScope == LibrarySearchScope.starred,
              selectedColor: context.c.inverseSurface,
              selectedTextColor: context.c.onInverseSurface,
              onTap: () => context
                  .read<LibraryBloc>()
                  .add(const LibrarySearchScopeChanged(LibrarySearchScope.starred)),
            ),
            const SizedBox(width: Spacing.xs),
            SelectableChip(
              label: context.s.librarySearchScopeNotes,
              selected: _state.searchScope == LibrarySearchScope.myNotes,
              selectedColor: context.c.inverseSurface,
              selectedTextColor: context.c.onInverseSurface,
              onTap: () => context
                  .read<LibraryBloc>()
                  .add(const LibrarySearchScopeChanged(LibrarySearchScope.myNotes)),
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
              final page = result.mark.pageNumber;
              final source = page == null
                  ? book.title
                  : "${book.title} · ${context.s.pageShortLabel(page)}";
              return MarkCard(
                accent: accent,
                quote: "“${result.mark.quote}”",
                thumbnailUrl: book.thumbnailUrl,
                sourceLabel: source,
                backgroundColor: context.palette.resolve(accent).fill,
                onTap: () => context.pushBookmarkDetail(result.mark.id),
              );
            },
          ),
        ),
      ],
    );
  }
}

class const _StarButton({
  required final VoidCallback _onTap,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CircleIconButton(
      icon: Icons.star_rounded,
      tooltip: context.s.librarySearchScopeStarred,
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
