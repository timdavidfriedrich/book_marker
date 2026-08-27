import 'package:core/theme/spacing.dart';
import 'package:core/theme/theme_extensions.dart';
import 'package:feature_library/presentation/book_detail/book_detail_bloc.dart';
import 'package:feature_library/presentation/book_detail/book_detail_event.dart';
import 'package:feature_library/presentation/book_detail/book_detail_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared/domain/entities/book.dart';
import 'package:shared/presentation/extensions/accent_extensions.dart';
import 'package:shared/presentation/extensions/app_error_extensions.dart';
import 'package:shared/presentation/extensions/context_extensions.dart';
import 'package:shared/presentation/navigation/navigation_extensions.dart';
import 'package:shared/presentation/widgets/book_cover.dart';
import 'package:shared/presentation/widgets/circle_icon_button.dart';
import 'package:shared/presentation/widgets/mark_card.dart';
import 'package:shared/presentation/widgets/selectable_chip.dart';

class const BookDetailScreen({
  super.key,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<BookDetailBloc, BookDetailState>(
        builder: (context, state) => switch (state) {
          BookDetailLoading() => const Center(child: CircularProgressIndicator()),
          BookDetailFailure(:final error) => Center(
            child: Padding(
              padding: const EdgeInsets.all(Spacing.l),
              child: Text(error.toMessage(context), textAlign: TextAlign.center),
            ),
          ),
          BookDetailLoaded() => _Content(state: state),
        },
      ),
    );
  }
}

class const _Content({
  required final BookDetailLoaded _state,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final book = _state.book;
    final accent = book.id.accent;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _Header(book: book, accent: accent, state: _state),
        const SizedBox(height: Spacing.m),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: Spacing.l),
          child: Row(
            children: [
              SelectableChip(
                label: context.s.bookDetailAllFilter(_state.totalCount),
                selected: _state.filter == BookDetailFilter.all,
                selectedColor: context.c.inverseSurface,
                selectedTextColor: context.c.onInverseSurface,
                onTap: () => context
                    .read<BookDetailBloc>()
                    .add(const BookDetailFilterChanged(BookDetailFilter.all)),
              ),
              const SizedBox(width: Spacing.xs),
              SelectableChip(
                label: context.s.bookDetailStarredFilter,
                selected: _state.filter == BookDetailFilter.starred,
                selectedColor: context.c.inverseSurface,
                selectedTextColor: context.c.onInverseSurface,
                onTap: () => context
                    .read<BookDetailBloc>()
                    .add(const BookDetailFilterChanged(BookDetailFilter.starred)),
              ),
              const SizedBox(width: Spacing.xs),
              SelectableChip(
                label: context.s.bookDetailVoiceFilter,
                selected: _state.filter == BookDetailFilter.withVoice,
                selectedColor: context.c.inverseSurface,
                selectedTextColor: context.c.onInverseSurface,
                onTap: () => context
                    .read<BookDetailBloc>()
                    .add(const BookDetailFilterChanged(BookDetailFilter.withVoice)),
              ),
            ],
          ),
        ),
        const SizedBox(height: Spacing.m),
        Expanded(
          child: _state.marks.isEmpty
              ? Center(
                  child: Padding(
                    padding: const EdgeInsets.all(Spacing.l),
                    child: Text(
                      context.s.bookDetailEmptyMessage,
                      textAlign: TextAlign.center,
                      style: context.typography.readingBody
                          .copyWith(color: context.c.onSurfaceVariant),
                    ),
                  ),
                )
              : ListView.separated(
                  padding: const EdgeInsets.fromLTRB(Spacing.l, 0, Spacing.l, Spacing.xxl),
                  itemCount: _state.marks.length,
                  separatorBuilder: (context, index) => const SizedBox(height: Spacing.m),
                  itemBuilder: (context, index) {
                    final mark = _state.marks[index];
                    return MarkCard(
                      accent: accent,
                      quote: "“${mark.quote}”",
                      thumbnailUrl: book.thumbnailUrl,
                      page: mark.pageNumber,
                      isStarred: mark.isFavorite,
                      onTap: () => context.pushBookmarkDetail(mark.id),
                    );
                  },
                ),
        ),
      ],
    );
  }
}

class const _Header({
  required final Book _book,
  required final AccentColor _accent,
  required final BookDetailLoaded _state,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final swatch = context.palette.resolve(_accent);
    final authors = _book.authors.isEmpty ? context.s.bookAuthorsUnknown : _book.authors.join(", ");
    return Container(
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
                    onPressed: () => context.showToast(context.s.comingSoonMessage),
                  ),
                ],
              ),
              const SizedBox(height: Spacing.m),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  BookCover(accent: _accent, url: _book.thumbnailUrl, width: 96, height: 128, radius: Spacing.radiusL),
                  const SizedBox(width: Spacing.l),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(_book.title, style: context.t.headlineMedium?.copyWith(color: swatch.onFill)),
                        const SizedBox(height: Spacing.xs),
                        Text(authors, style: context.typography.monoLabel.copyWith(color: swatch.onFillVariant)),
                        const SizedBox(height: Spacing.m),
                        Wrap(
                          spacing: Spacing.xs,
                          runSpacing: Spacing.xs,
                          children: [
                            _StatChip(label: context.s.bookDetailMarksStat(_state.totalCount)),
                            _StatChip(label: context.s.bookDetailStarredStat(_state.starredCount)),
                          ],
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
    );
  }
}

class const _StatChip({
  required final String _label,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: Spacing.s, vertical: Spacing.xxs),
      decoration: BoxDecoration(
        color: context.c.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(Spacing.radiusFull),
      ),
      child: Text(_label, style: context.typography.monoLabel.copyWith(color: context.c.onSurface)),
    );
  }
}
