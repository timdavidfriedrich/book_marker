import 'package:core/theme/spacing.dart';
import 'package:core/theme/theme_extensions.dart';
import 'package:feature_library/presentation/book_detail/book_detail_bloc.dart';
import 'package:feature_library/presentation/book_detail/book_detail_event.dart';
import 'package:feature_library/presentation/book_detail/book_detail_state.dart';
import 'package:feature_library/presentation/extensions/book_status_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared/domain/entities/book.dart';
import 'package:shared/presentation/extensions/accent_extensions.dart';
import 'package:shared/presentation/extensions/app_error_extensions.dart';
import 'package:shared/presentation/extensions/context_extensions.dart';
import 'package:shared/presentation/navigation/navigation_extensions.dart';
import 'package:shared/presentation/widgets/book_cover.dart';
import 'package:shared/presentation/widgets/circle_icon_button.dart';
import 'package:shared/presentation/widgets/confirm_dialog.dart';
import 'package:shared/presentation/widgets/quote_card.dart';
import 'package:shared/presentation/widgets/selectable_chip.dart';
import 'package:shared/presentation/widgets/sheet_action_tile.dart';

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
                label: context.s.bookDetailFavoritesFilter,
                selected: _state.filter == BookDetailFilter.favorites,
                selectedColor: context.c.inverseSurface,
                selectedTextColor: context.c.onInverseSurface,
                onTap: () => context
                    .read<BookDetailBloc>()
                    .add(const BookDetailFilterChanged(BookDetailFilter.favorites)),
              ),
              const SizedBox(width: Spacing.xs),
              SelectableChip(
                label: context.s.bookDetailVoiceNoteFilter,
                selected: _state.filter == BookDetailFilter.withVoiceNote,
                selectedColor: context.c.inverseSurface,
                selectedTextColor: context.c.onInverseSurface,
                onTap: () => context
                    .read<BookDetailBloc>()
                    .add(const BookDetailFilterChanged(BookDetailFilter.withVoiceNote)),
              ),
            ],
          ),
        ),
        const SizedBox(height: Spacing.m),
        Expanded(
          child: _state.quotes.isEmpty
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
                  itemCount: _state.quotes.length,
                  separatorBuilder: (context, index) => const SizedBox(height: Spacing.m),
                  itemBuilder: (context, index) {
                    final quote = _state.quotes[index];
                    final voiceNoteMs = quote.voiceNoteDurationMs;
                    return QuoteCard(
                      accent: accent,
                      quote: "“${quote.quote}”",
                      thumbnailUrl: book.thumbnailUrl,
                      page: quote.pageNumber,
                      note: quote.note,
                      isFavorite: quote.isFavorite,
                      hasVoiceNote: quote.voiceNotePath != null,
                      voiceNoteDuration: voiceNoteMs == null ? null : Duration(milliseconds: voiceNoteMs),
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
                    onPressed: () => _showBookMenu(context, _book.status),
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
                            _StatChip(label: context.s.bookDetailQuotesStat(_state.totalCount)),
                            _StatChip(label: context.s.bookDetailFavoritesStat(_state.favoriteCount)),
                            _StatChip(label: _book.status.toLabel(context)),
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

Future<void> _showBookMenu(BuildContext context, BookStatus status) async {
  final bloc = context.read<BookDetailBloc>();
  final deleteRequested = await showModalBottomSheet<bool>(
    context: context,
    useRootNavigator: true,
    builder: (_) => BlocProvider.value(value: bloc, child: _BookMenu(status: status)),
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
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(Spacing.l),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
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
        ),
      ),
    );
  }
}
