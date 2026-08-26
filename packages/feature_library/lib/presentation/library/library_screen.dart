import 'package:core/error/app_error.dart';
import 'package:core/theme/spacing.dart';
import 'package:feature_library/presentation/library/library_bloc.dart';
import 'package:feature_library/presentation/library/library_event.dart';
import 'package:feature_library/presentation/library/library_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared/domain/entities/book.dart';
import 'package:shared/domain/entities/bookmark.dart';
import 'package:shared/presentation/extensions/app_error_extensions.dart';
import 'package:shared/presentation/extensions/context_extensions.dart';
import 'package:shared/presentation/navigation/navigation_extensions.dart';

const _quoteMaxLines = 2;

class const LibraryScreen({
  super.key,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(context.s.libraryTitle)),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: context.pushCapture,
        icon: const Icon(Icons.photo_camera),
        label: Text(context.s.captureTitle),
      ),
      body: BlocBuilder<LibraryBloc, LibraryState>(
        builder: (context, state) => switch (state) {
          LibraryLoading() => const Center(child: CircularProgressIndicator()),
          LibraryEmpty() => const _EmptyView(),
          LibraryFailure(:final error) => _FailureView(error: error),
          LibraryLoaded(:final bookmarks, :final booksById) => _BookmarkList(
            bookmarks: bookmarks,
            booksById: booksById,
          ),
        },
      ),
    );
  }
}

class const _BookmarkList({
  required final List<Bookmark> _bookmarks,
  required final Map<String, Book> _booksById,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.all(Spacing.m),
      itemCount: _bookmarks.length,
      separatorBuilder: (context, index) => const SizedBox(height: Spacing.xs),
      itemBuilder: (context, index) {
        final bookmark = _bookmarks[index];
        final book = _booksById[bookmark.bookId];
        return Card(
          child: ListTile(
            title: Text(
              bookmark.quote,
              maxLines: _quoteMaxLines,
              overflow: TextOverflow.ellipsis,
              style: context.t.bodyLarge,
            ),
            subtitle: Text(_subtitle(context, book, bookmark)),
            trailing: bookmark.isFavorite ? const Icon(Icons.favorite) : null,
            onTap: () => context.pushBookmarkDetail(bookmark.id),
          ),
        );
      },
    );
  }

  String _subtitle(BuildContext context, Book? book, Bookmark bookmark) {
    final bookTitle = book?.title ?? context.s.libraryUnknownBook;
    final pageLabel = bookmark.pageNumber == null
        ? context.s.libraryNoPageLabel
        : context.s.libraryPageLabel(bookmark.pageNumber!);
    return "$bookTitle · $pageLabel";
  }
}

class const _EmptyView() extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(Spacing.l),
        child: Text(context.s.libraryEmptyMessage, textAlign: TextAlign.center),
      ),
    );
  }
}

class const _FailureView({
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
