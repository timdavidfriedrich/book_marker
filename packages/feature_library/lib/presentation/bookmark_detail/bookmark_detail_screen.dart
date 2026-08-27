import 'package:core/theme/spacing.dart';
import 'package:feature_library/presentation/bookmark_detail/bookmark_detail_bloc.dart';
import 'package:feature_library/presentation/bookmark_detail/bookmark_detail_event.dart';
import 'package:feature_library/presentation/bookmark_detail/bookmark_detail_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:shared/domain/entities/book.dart';
import 'package:shared/domain/entities/bookmark.dart';
import 'package:shared/presentation/extensions/app_error_extensions.dart';
import 'package:shared/presentation/extensions/context_extensions.dart';
import 'package:shared/presentation/navigation/navigation_extensions.dart';
import 'package:shared/presentation/widgets/circle_icon_button.dart';
import 'package:shared/presentation/widgets/highlight_image.dart';
import 'package:shared/presentation/widgets/ink_tap_box.dart';
import 'package:shared/presentation/widgets/paper_card.dart';

class const BookmarkDetailScreen({
  super.key,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocBuilder<BookmarkDetailBloc, BookmarkDetailState>(
          builder: (context, state) => switch (state) {
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
      ),
    );
  }
}

class const _Content({
  required final Bookmark _bookmark,
  required final Book? _book,
}) extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final mode = useState(1);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: Spacing.l),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(height: Spacing.s),
          _Header(bookmark: _bookmark, book: _book),
          const SizedBox(height: Spacing.m),
          _ModeToggle(index: mode.value, onChanged: (value) => mode.value = value),
          const SizedBox(height: Spacing.m),
          Expanded(
            child: mode.value == 1
                ? _PhotoView(bookmark: _bookmark)
                : _TextView(bookmark: _bookmark),
          ),
          const SizedBox(height: Spacing.m),
          _NoteCard(bookmark: _bookmark),
          const SizedBox(height: Spacing.m),
          _Actions(isStarred: _bookmark.isFavorite),
          const SizedBox(height: Spacing.s),
        ],
      ),
    );
  }
}

class const _Header({
  required final Bookmark _bookmark,
  required final Book? _book,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final date = MaterialLocalizations.of(context).formatMediumDate(_bookmark.createdAt.toLocal());
    final page = _bookmark.pageNumber;
    final meta = page == null
        ? context.s.bookmarkDetailShotMeta(date)
        : context.s.bookmarkDetailPhotoMeta(page, date);
    return Row(
      children: [
        CircleIconButton(
          icon: Icons.arrow_back,
          tooltip: context.s.back,
          onPressed: context.closeScreen,
        ),
        const SizedBox(width: Spacing.s),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                _book?.title ?? context.s.libraryUnknownBook,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: context.t.titleLarge,
              ),
              Text(meta, style: context.typography.monoLabel.copyWith(color: context.c.onSurfaceVariant)),
            ],
          ),
        ),
      ],
    );
  }
}

class const _ModeToggle({
  required final int _index,
  required final ValueChanged<int> _onChanged,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        padding: const EdgeInsets.all(Spacing.xxxs),
        decoration: BoxDecoration(
          color: context.c.surfaceContainerHigh,
          borderRadius: BorderRadius.circular(Spacing.radiusFull),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            for (final entry in [context.s.markingModeText, context.s.markingModePhoto].indexed)
              InkTapBox(
                onTap: () => _onChanged(entry.$1),
                radius: Spacing.radiusFull,
                color: entry.$1 == _index ? context.palette.amber.solid : Colors.transparent,
                padding: const EdgeInsets.symmetric(horizontal: Spacing.m, vertical: Spacing.xs),
                child: Text(
                  entry.$2,
                  style: context.t.labelMedium?.copyWith(
                    fontSize: 14,
                    color: entry.$1 == _index
                        ? context.palette.amber.onSolid
                        : context.c.onSurfaceVariant,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class const _PhotoView({
  required final Bookmark _bookmark,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return PaperCard(
      padding: const EdgeInsets.all(Spacing.m),
      child: Center(
        child: SingleChildScrollView(
          child: HighlightImage(
            imagePath: _bookmark.photoPath,
            aspectRatio: _bookmark.imageAspectRatio,
            highlights: _bookmark.highlights,
          ),
        ),
      ),
    );
  }
}

class const _TextView({
  required final Bookmark _bookmark,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return PaperCard(
      padding: const EdgeInsets.all(Spacing.l),
      child: SingleChildScrollView(
        child: Text.rich(
          TextSpan(
            text: _bookmark.quote,
            style: context.typography.readingBody.copyWith(
              background: Paint()..color = context.palette.amber.solid,
            ),
          ),
        ),
      ),
    );
  }
}

class const _NoteCard({
  required final Bookmark _bookmark,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(Spacing.m),
      decoration: BoxDecoration(
        color: context.c.surfaceContainerHigh,
        borderRadius: BorderRadius.circular(Spacing.radiusL),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '“${_bookmark.quote}”',
            style: context.typography.readingQuoteItalic.copyWith(color: context.c.onSurface),
          ),
          const SizedBox(height: Spacing.xs),
          Text(
            context.s.bookmarkDetailNotePlaceholder,
            style: context.t.bodyMedium?.copyWith(color: context.c.onSurfaceVariant),
          ),
        ],
      ),
    );
  }
}

class const _Actions({
  required final bool _isStarred,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _ActionButton(
          icon: _isStarred ? Icons.star_rounded : Icons.star_outline_rounded,
          label: context.s.bookmarkDetailStarredLabel,
          highlighted: _isStarred,
          onTap: () =>
              context.read<BookmarkDetailBloc>().add(const BookmarkDetailFavoriteToggled()),
        ),
        const SizedBox(width: Spacing.xl),
        _ActionButton(
          icon: Icons.north_east,
          label: context.s.bookmarkDetailShareLabel,
          highlighted: false,
          onTap: () => context.showToast(context.s.comingSoonMessage),
        ),
        const SizedBox(width: Spacing.xl),
        _ActionButton(
          icon: Icons.more_horiz,
          label: context.s.bookmarkDetailMoreLabel,
          highlighted: false,
          onTap: () => context.showToast(context.s.comingSoonMessage),
        ),
      ],
    );
  }
}

class const _ActionButton({
  required final IconData _icon,
  required final String _label,
  required final bool _highlighted,
  required final VoidCallback _onTap,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        CircleIconButton(
          icon: _icon,
          size: 56,
          tooltip: _label,
          foregroundColor: _highlighted ? context.palette.amber.solid : context.c.onSurface,
          onPressed: _onTap,
        ),
        const SizedBox(height: Spacing.xxs),
        Text(
          _label,
          style: context.typography.monoCaption.copyWith(color: context.c.onSurfaceVariant),
        ),
      ],
    );
  }
}
