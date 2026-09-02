import 'package:core/theme/spacing.dart';
import 'package:feature_library/presentation/book_detail/book_detail_bloc.dart';
import 'package:feature_library/presentation/book_detail/book_detail_event.dart';
import 'package:feature_library/presentation/book_detail/book_detail_state.dart';
import 'package:feature_library/presentation/extensions/book_status_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared/domain/entities/book.dart';
import 'package:shared/presentation/extensions/app_error_extensions.dart';
import 'package:shared/presentation/extensions/context_extensions.dart';
import 'package:shared/presentation/extensions/screen_layout_extensions.dart';
import 'package:shared/presentation/extensions/stat_label_extensions.dart';
import 'package:shared/presentation/navigation/navigation_extensions.dart';
import 'package:shared/presentation/widgets/book_cover.dart';
import 'package:shared/presentation/widgets/circle_icon_button.dart';
import 'package:shared/presentation/widgets/collapsing_header.dart';
import 'package:shared/presentation/widgets/columned_sliver_list.dart';
import 'package:shared/presentation/widgets/confirm_dialog.dart';
import 'package:shared/presentation/widgets/loading_screen.dart';
import 'package:shared/presentation/widgets/pinned_header.dart';
import 'package:shared/presentation/widgets/quote_card.dart';
import 'package:shared/presentation/widgets/selectable_chip.dart';
import 'package:shared/presentation/widgets/sheet_action_tile.dart';
import 'package:shared/presentation/widgets/sheet_content.dart';

const _headerHeight = 224.0;
const _chipHeight = 32.0;
const _chipsHeight = Spacing.m + _chipHeight + Spacing.m;
const _coverWidth = 96.0;
const _coverHeight = 128.0;
const _paneCoverWidth = 88.0;
const _paneCoverHeight = 118.0;
const _headerStatsMaxLines = 1;
const _paneStatsMaxLines = 2;

class const BookDetailScreen({
  super.key,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<BookDetailBloc, BookDetailState>(
        listenWhen: (previous, current) => current is BookDetailDeleted,
        listener: (context, state) => context.closeScreen(),
        builder: (context, state) => switch (state) {
          BookDetailLoading() => const LoadingScreen(),
          BookDetailFailure(:final error) => Center(
            child: Padding(
              padding: const EdgeInsets.all(Spacing.l),
              child: Text(error.toMessage(context), textAlign: TextAlign.center),
            ),
          ),
          BookDetailLoaded() => _Content(state: state),
          BookDetailDeleted() => const SizedBox.shrink(),
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
    if (context.layout.isLandscape) {
      return Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _SidePanel(book: book, state: _state),
          Expanded(
            child: SafeArea(
              left: false,
              child: CustomScrollView(slivers: [_QuoteSlivers(state: _state)]),
            ),
          ),
        ],
      );
    }
    return CustomScrollView(
      slivers: [
        CollapsingHeader(
          expandedHeight: _headerHeight,
          backgroundColor: context.c.surfaceContainerLow,
          expanded: _Header(book: book, state: _state),
          collapsed: _CollapsedHeader(book: book),
        ),
        _QuoteSlivers(state: _state),
      ],
    );
  }
}

class const _QuoteSlivers({
  required final BookDetailLoaded _state,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final margin = context.layout.pageMargin;
    return SliverMainAxisGroup(
      slivers: [
        PinnedHeader(
          height: _chipsHeight,
          child: ColoredBox(
            color: context.c.surface,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              padding: EdgeInsets.fromLTRB(margin, Spacing.m, margin, Spacing.m),
              child: Row(
                children: [
                  for (final (index, filter) in BookDetailFilter.values.indexed) ...[
                    if (index > 0) const SizedBox(width: Spacing.xs),
                    SelectableChip(
                      label: _filterLabel(context, filter, _state),
                      selected: _state.filter == filter,
                      selectedColor: context.c.inverseSurface,
                      selectedTextColor: context.c.onInverseSurface,
                      onTap: () =>
                          context.read<BookDetailBloc>().add(BookDetailFilterChanged(filter)),
                    ),
                  ],
                ],
              ),
            ),
          ),
        ),
        if (_state.quotes.isEmpty)
          SliverFillRemaining(
            hasScrollBody: false,
            child: Padding(
              padding: const EdgeInsets.all(Spacing.l),
              child: Text(
                _state.totalCount == 0
                    ? context.s.bookDetailEmptyMessage
                    : context.s.filterNoResultsMessage,
                textAlign: TextAlign.center,
                style: context.typography.readingBody.copyWith(color: context.c.onSurfaceVariant),
              ),
            ),
          )
        else
          SliverPadding(
            padding: EdgeInsets.fromLTRB(margin, 0, margin, Spacing.xxl),
            sliver: ColumnedSliverList(
              itemCount: _state.quotes.length,
              columns: context.layout.cardColumns,
              itemBuilder: (context, index) {
                final quote = _state.quotes[index];
                final voiceNoteMs = quote.voiceNoteDurationMs;
                return QuoteCard(
                  quote: "“${quote.quote}”",
                  bookTitle: _state.book.title,
                  coverImage: _state.book.coverImage,
                  pages: quote.pageNumbers,
                  note: quote.note,
                  isFavorite: quote.isFavorite,
                  hasVoiceNote: quote.voiceNotePath != null,
                  voiceNoteDuration: voiceNoteMs == null
                      ? null
                      : Duration(milliseconds: voiceNoteMs),
                  voiceNotePath: quote.voiceNotePath,
                  onTap: () => context.pushQuoteDetail(quote.id),
                );
              },
            ),
          ),
      ],
    );
  }
}

class const _SidePanel({
  required final Book _book,
  required final BookDetailLoaded _state,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final authors = _book.authors.isEmpty ? context.s.bookAuthorsUnknown : _book.authors.join(", ");
    return Container(
      width: Spacing.detailPaneWidth,
      color: context.c.surfaceContainerLow,
      child: SafeArea(
        right: false,
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(Spacing.l, Spacing.l, Spacing.l, Spacing.xl),
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
                    onPressed: () => _showBookMenu(context, _book.status),
                  ),
                ],
              ),
              const SizedBox(height: Spacing.m),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  BookCover(
                    title: _book.title,
                    image: _book.coverImage,
                    width: _paneCoverWidth,
                    height: _paneCoverHeight,
                    radius: Spacing.radiusL,
                  ),
                  const SizedBox(width: Spacing.m),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          _book.title,
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                          style: context.t.headlineSmall,
                        ),
                        const SizedBox(height: Spacing.xs),
                        Text(
                          authors,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: context.typography.label.copyWith(
                            color: context.c.onSurfaceVariant,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: Spacing.m),
              _Stats(state: _state, maxLines: _paneStatsMaxLines),
            ],
          ),
        ),
      ),
    );
  }
}

class const _Header({
  required final Book _book,
  required final BookDetailLoaded _state,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final authors = _book.authors.isEmpty ? context.s.bookAuthorsUnknown : _book.authors.join(", ");
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
                  onPressed: () => _showBookMenu(context, _book.status),
                ),
              ],
            ),
            const SizedBox(height: Spacing.m),
            SizedBox(
              height: _coverHeight,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  BookCover(
                    title: _book.title,
                    image: _book.coverImage,
                    width: _coverWidth,
                    height: _coverHeight,
                    radius: Spacing.radiusL,
                  ),
                  const SizedBox(width: Spacing.l),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          _book.title,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: context.t.headlineMedium,
                        ),
                        const SizedBox(height: Spacing.xs),
                        Text(
                          authors,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: context.typography.label.copyWith(
                            color: context.c.onSurfaceVariant,
                          ),
                        ),
                        const Spacer(),
                        _Stats(state: _state, maxLines: _headerStatsMaxLines),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class const _CollapsedHeader({
  required final Book _book,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
              _book.title,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: context.t.titleLarge,
            ),
          ),
          const SizedBox(width: Spacing.s),
          CircleIconButton(
            icon: Icons.more_horiz,
            backgroundColor: context.c.surfaceContainerLowest,
            onPressed: () => _showBookMenu(context, _book.status),
          ),
        ],
      ),
    );
  }
}

class const _Stats({
  required final BookDetailLoaded _state,
  required final int _maxLines,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Text(
      [
        _state.totalCount.toQuotesStat(context),
        _state.favoriteCount.toFavoritesStat(context),
        _state.book.status.toLabel(context),
      ].joinStats(),
      maxLines: _maxLines,
      overflow: TextOverflow.ellipsis,
      style: context.typography.label.copyWith(color: context.c.onSurfaceVariant),
    );
  }
}

Future<void> _showBookMenu(BuildContext context, BookStatus status) async {
  final bloc = context.read<BookDetailBloc>();
  final deleteRequested = await showModalBottomSheet<bool>(
    context: context,
    isScrollControlled: true,
    useRootNavigator: true,
    builder: (_) => BlocProvider.value(
      value: bloc,
      child: _BookMenu(status: status),
    ),
  );
  if (deleteRequested != true || !context.mounted) return;
  final confirmed = await showConfirmDialog(
    context,
    title: context.s.bookDeleteTitle,
    message: context.s.bookDeleteMessage,
    confirmLabel: context.s.commonDelete,
    destructive: true,
  );
  if (confirmed) bloc.add(const BookDetailDeleteRequested());
}

class const _BookMenu({
  required final BookStatus _status,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SheetContent(
      children: [
        for (final status in BookStatus.values)
          if (status != _status)
            SheetActionTile(
              icon: status.toIcon(),
              label: status.toActionLabel(context),
              onTap: () {
                context.read<BookDetailBloc>().add(BookDetailStatusChanged(status));
                Navigator.of(context).pop();
              },
            ),
        SheetActionTile(
          icon: Icons.delete_outline,
          label: context.s.bookDeleteAction,
          destructive: true,
          onTap: () => Navigator.of(context).pop(true),
        ),
      ],
    );
  }
}

String _filterLabel(BuildContext context, BookDetailFilter filter, BookDetailLoaded state) {
  return switch (filter) {
    BookDetailFilter.all => context.s.bookDetailAllFilter(state.totalCount),
    BookDetailFilter.favorites => context.s.bookDetailFavoritesFilter,
    BookDetailFilter.withVoiceNote => context.s.bookDetailVoiceNoteFilter,
  };
}
