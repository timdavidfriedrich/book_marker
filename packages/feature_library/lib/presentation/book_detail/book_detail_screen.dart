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
import 'package:shared/presentation/navigation/navigation_extensions.dart';
import 'package:shared/presentation/widgets/book_cover.dart';
import 'package:shared/presentation/widgets/circle_icon_button.dart';
import 'package:shared/presentation/widgets/collapsing_header.dart';
import 'package:shared/presentation/widgets/confirm_dialog.dart';
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
          BookDetailLoading() => const Center(child: CircularProgressIndicator()),
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
    return CustomScrollView(
      slivers: [
        CollapsingHeader(
          expandedHeight: _headerHeight,
          backgroundColor: context.c.surfaceContainerLow,
          expanded: _Header(book: book, state: _state),
          collapsed: _CollapsedHeader(book: book),
        ),
        PinnedHeader(
          height: _chipsHeight,
          child: ColoredBox(
            color: context.c.surface,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.fromLTRB(Spacing.l, Spacing.m, Spacing.l, Spacing.m),
              child: Row(
                children: [
                  SelectableChip(
                    label: context.s.bookDetailAllFilter(_state.totalCount),
                    selected: _state.filter == BookDetailFilter.all,
                    selectedColor: context.c.inverseSurface,
                    selectedTextColor: context.c.onInverseSurface,
                    onTap: () => context.read<BookDetailBloc>().add(
                      const BookDetailFilterChanged(BookDetailFilter.all),
                    ),
                  ),
                  const SizedBox(width: Spacing.xs),
                  SelectableChip(
                    label: context.s.bookDetailFavoritesFilter,
                    selected: _state.filter == BookDetailFilter.favorites,
                    selectedColor: context.c.inverseSurface,
                    selectedTextColor: context.c.onInverseSurface,
                    onTap: () => context.read<BookDetailBloc>().add(
                      const BookDetailFilterChanged(BookDetailFilter.favorites),
                    ),
                  ),
                  const SizedBox(width: Spacing.xs),
                  SelectableChip(
                    label: context.s.bookDetailVoiceNoteFilter,
                    selected: _state.filter == BookDetailFilter.withVoiceNote,
                    selectedColor: context.c.inverseSurface,
                    selectedTextColor: context.c.onInverseSurface,
                    onTap: () => context.read<BookDetailBloc>().add(
                      const BookDetailFilterChanged(BookDetailFilter.withVoiceNote),
                    ),
                  ),
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
            padding: const EdgeInsets.fromLTRB(Spacing.l, 0, Spacing.l, Spacing.xxl),
            sliver: SliverList.separated(
              itemCount: _state.quotes.length,
              separatorBuilder: (context, index) => const SizedBox(height: Spacing.m),
              itemBuilder: (context, index) {
                final quote = _state.quotes[index];
                final voiceNoteMs = quote.voiceNoteDurationMs;
                return QuoteCard(
                  quote: "“${quote.quote}”",
                  bookTitle: book.title,
                  thumbnailUrl: book.thumbnailUrl,
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
                    url: _book.thumbnailUrl,
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
                          style: context.typography.monoLabel.copyWith(
                            color: context.c.onSurfaceVariant,
                          ),
                        ),
                        const Spacer(),
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: [
                              _StatChip(label: context.s.bookDetailQuotesStat(_state.totalCount)),
                              const SizedBox(width: Spacing.xs),
                              _StatChip(
                                label: context.s.bookDetailFavoritesStat(_state.favoriteCount),
                              ),
                              const SizedBox(width: Spacing.xs),
                              _StatChip(label: _book.status.toLabel(context)),
                            ],
                          ),
                        ),
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

Future<void> _showBookMenu(BuildContext context, BookStatus status) async {
  final bloc = context.read<BookDetailBloc>();
  final deleteRequested = await showModalBottomSheet<bool>(
    context: context,
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
