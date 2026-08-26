import 'package:core/theme/spacing.dart';
import 'package:feature_library/presentation/bookmark_detail/bookmark_detail_bloc.dart';
import 'package:feature_library/presentation/bookmark_detail/bookmark_detail_event.dart';
import 'package:feature_library/presentation/bookmark_detail/bookmark_detail_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared/domain/entities/book.dart';
import 'package:shared/domain/entities/bookmark.dart';
import 'package:shared/presentation/extensions/app_error_extensions.dart';
import 'package:shared/presentation/extensions/context_extensions.dart';
import 'package:shared/presentation/widgets/highlight_image.dart';

class const BookmarkDetailScreen({
  super.key,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BookmarkDetailBloc, BookmarkDetailState>(
      builder: (context, state) => Scaffold(
        appBar: AppBar(
          title: Text(context.s.bookmarkDetailTitle),
          actions: [
            if (state is BookmarkDetailLoaded) _FavoriteButton(isFavorite: state.bookmark.isFavorite),
          ],
        ),
        body: switch (state) {
          BookmarkDetailLoading() => const Center(child: CircularProgressIndicator()),
          BookmarkDetailFailure(:final error) => Center(
            child: Padding(
              padding: const EdgeInsets.all(Spacing.l),
              child: Text(error.toMessage(context), textAlign: TextAlign.center),
            ),
          ),
          BookmarkDetailLoaded(:final bookmark, :final book) => _Content(
            bookmark: bookmark,
            book: book,
          ),
        },
      ),
    );
  }
}

class const _FavoriteButton({
  required final bool _isFavorite,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return IconButton(
      tooltip: _isFavorite
          ? context.s.bookmarkDetailFavoriteRemove
          : context.s.bookmarkDetailFavoriteAdd,
      icon: Icon(_isFavorite ? Icons.favorite : Icons.favorite_border),
      onPressed: () =>
          context.read<BookmarkDetailBloc>().add(const BookmarkDetailFavoriteToggled()),
    );
  }
}

class const _Content({
  required final Bookmark _bookmark,
  required final Book? _book,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(Spacing.m),
      children: [
        HighlightImage(
          imagePath: _bookmark.photoPath,
          aspectRatio: _bookmark.imageAspectRatio,
          highlights: _bookmark.highlights,
        ),
        const SizedBox(height: Spacing.l),
        Text(_book?.title ?? context.s.libraryUnknownBook, style: context.t.titleLarge),
        const SizedBox(height: Spacing.xxs),
        Text(
          _authors(context),
          style: context.t.bodyMedium?.copyWith(color: context.c.onSurfaceVariant),
        ),
        const SizedBox(height: Spacing.xxs),
        Text(_pageLabel(context), style: context.t.labelLarge),
        const SizedBox(height: Spacing.l),
        Text(context.s.bookmarkDetailQuoteLabel, style: context.t.labelLarge),
        const SizedBox(height: Spacing.xxs),
        SelectableText(_bookmark.quote, style: context.t.bodyLarge),
      ],
    );
  }

  String _authors(BuildContext context) {
    final authors = _book?.authors ?? const [];
    return authors.isEmpty ? context.s.bookAuthorsUnknown : authors.join(", ");
  }

  String _pageLabel(BuildContext context) {
    final pageNumber = _bookmark.pageNumber;
    return pageNumber == null
        ? context.s.bookmarkDetailNoPage
        : context.s.bookmarkDetailPageLabel(pageNumber);
  }
}
