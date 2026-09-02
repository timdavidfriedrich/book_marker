import 'dart:io';

import 'package:core/theme/spacing.dart';
import 'package:feature_library/presentation/quote_detail/quote_detail_bloc.dart';
import 'package:feature_library/presentation/quote_detail/quote_detail_event.dart';
import 'package:feature_library/presentation/quote_detail/quote_detail_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shared/domain/entities/book.dart';
import 'package:shared/domain/entities/captured_shot.dart';
import 'package:shared/domain/entities/page_quad.dart';
import 'package:shared/domain/entities/quote.dart';
import 'package:shared/domain/entities/quote_page.dart';
import 'package:shared/domain/entities/quote_theme.dart';
import 'package:shared/presentation/extensions/app_error_extensions.dart';
import 'package:shared/presentation/extensions/context_extensions.dart';
import 'package:shared/presentation/extensions/page_number_extensions.dart';
import 'package:shared/presentation/extensions/screen_layout_extensions.dart';
import 'package:shared/presentation/navigation/marking_arguments.dart';
import 'package:shared/presentation/navigation/navigation_extensions.dart';
import 'package:shared/presentation/widgets/circle_icon_button.dart';
import 'package:shared/presentation/widgets/confirm_dialog.dart';
import 'package:shared/presentation/widgets/fullscreen_image_viewer.dart';
import 'package:shared/presentation/widgets/loading_indicator.dart';
import 'package:shared/presentation/widgets/name_input_dialog.dart';
import 'package:shared/presentation/widgets/page_number_field.dart';
import 'package:shared/presentation/widgets/paper_card.dart';
import 'package:shared/presentation/widgets/selectable_chip.dart';
import 'package:shared/presentation/widgets/sheet_action_tile.dart';
import 'package:shared/presentation/widgets/sheet_content.dart';
import 'package:shared/presentation/widgets/voice_note_recorder.dart';

const _quoteMaxLines = 8;
const _sourceThumbnailWidth = 44.0;
const _sourceThumbnailHeight = 60.0;
const _sourceThumbnailCacheWidth = 132;
const _readingColumnFlex = 3;
const _metadataColumnFlex = 2;

class const QuoteDetailScreen({
  super.key,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocConsumer<QuoteDetailBloc, QuoteDetailState>(
          listenWhen: (previous, current) => current is QuoteDetailDeleted,
          listener: (context, state) => context.closeScreen(),
          builder: (context, state) => switch (state) {
            QuoteDetailLoading() => const LoadingIndicator(),
            QuoteDetailFailure(:final error) => Center(
              child: Padding(
                padding: const EdgeInsets.all(Spacing.l),
                child: Text(error.toMessage(context), textAlign: TextAlign.center),
              ),
            ),
            QuoteDetailLoaded(:final quote, :final book, :final themes, :final selectedThemeIds) =>
              _Content(
                quote: quote,
                book: book,
                themes: themes,
                selectedThemeIds: selectedThemeIds,
              ),
            QuoteDetailDeleted() => const SizedBox.shrink(),
          },
        ),
      ),
    );
  }
}

class const _Content({
  required final Quote _quote,
  required final Book? _book,
  required final List<QuoteTheme> _themes,
  required final Set<String> _selectedThemeIds,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final layout = context.layout;
    final margin = layout.pageMargin;
    final reading = <Widget>[
      _CitationCard(quote: _quote),
      const SizedBox(height: Spacing.m),
      VoiceNoteRecorder(
        path: _quote.voiceNotePath,
        durationMs: _quote.voiceNoteDurationMs,
        onRecorded: (path, durationMs) => context.read<QuoteDetailBloc>().add(
          QuoteDetailVoiceNoteRecorded(path, durationMs),
        ),
        onCleared: () => context.read<QuoteDetailBloc>().add(const QuoteDetailVoiceNoteCleared()),
      ),
      const SizedBox(height: Spacing.m),
      _NoteCard(quote: _quote),
    ];
    final metadata = <Widget>[
      Align(
        alignment: Alignment.centerLeft,
        child: PageNumberField(
          pages: _quote.pageNumbers,
          onChanged: (pages) => context.read<QuoteDetailBloc>().add(
            QuoteDetailPageNumbersChanged(pages),
          ),
        ),
      ),
      const SizedBox(height: Spacing.m),
      _ThemeChips(themes: _themes, selected: _selectedThemeIds),
      const SizedBox(height: Spacing.m),
      _SourceCard(quote: _quote),
      const SizedBox(height: Spacing.m),
      _Actions(quote: _quote, book: _book),
    ];
    if (layout.isWide) {
      return Padding(
        padding: EdgeInsets.fromLTRB(margin, Spacing.s, margin, Spacing.l),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _Header(quote: _quote, book: _book),
            const SizedBox(height: Spacing.m),
            Expanded(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: _readingColumnFlex,
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: reading,
                      ),
                    ),
                  ),
                  const SizedBox(width: Spacing.xl),
                  Expanded(
                    flex: _metadataColumnFlex,
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: metadata,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    }
    return ListView(
      padding: EdgeInsets.fromLTRB(margin, Spacing.s, margin, Spacing.l),
      children: [
        _Header(quote: _quote, book: _book),
        const SizedBox(height: Spacing.m),
        ...reading,
        const SizedBox(height: Spacing.m),
        ...metadata,
      ],
    );
  }
}

class const _CitationCard({
  required final Quote _quote,
}) extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final controller = useTextEditingController(text: _quote.quote);
    // * comparing trimmed keeps the space the user just typed while re-marking still lands here
    useEffect(() {
      if (controller.text.trim() != _quote.quote) controller.text = _quote.quote;
      return null;
    }, [_quote.quote]);
    return PaperCard(
      padding: const EdgeInsets.all(Spacing.l),
      child: TextField(
        controller: controller,
        minLines: 1,
        maxLines: _quoteMaxLines,
        textCapitalization: TextCapitalization.sentences,
        style: context.typography.readingQuoteItalic.copyWith(color: context.palette.paperText),
        onChanged: (value) => context.read<QuoteDetailBloc>().add(QuoteDetailQuoteChanged(value)),
        decoration: InputDecoration(
          isDense: true,
          filled: false,
          border: InputBorder.none,
          enabledBorder: InputBorder.none,
          focusedBorder: InputBorder.none,
          contentPadding: EdgeInsets.zero,
          hintText: context.s.quoteDetailQuoteHint,
          hintStyle: context.typography.readingQuoteItalic.copyWith(
            color: context.palette.paperTextFaint,
          ),
        ),
      ),
    );
  }
}

class const _SourceCard({
  required final Quote _quote,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final pages = _quote.pages;
    return Container(
      padding: const EdgeInsets.all(Spacing.m),
      decoration: BoxDecoration(
        color: context.c.surfaceContainerHigh,
        borderRadius: BorderRadius.circular(Spacing.radiusL),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                context.s.quoteDetailSourceLabel,
                style: context.typography.label.copyWith(color: context.c.onSurfaceVariant),
              ),
              if (pages.isNotEmpty) ...[
                const SizedBox(width: Spacing.m),
                Expanded(child: _SourceThumbnails(pages: pages)),
              ],
            ],
          ),
          if (pages.isEmpty) ...[
            const SizedBox(height: Spacing.s),
            Text(
              context.s.quoteDetailNoPhotoMessage,
              style: context.t.bodyMedium?.copyWith(color: context.c.onSurfaceVariant),
            ),
          ],
        ],
      ),
    );
  }
}

class const _SourceThumbnails({
  required final List<QuotePage> _pages,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: _sourceThumbnailHeight,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        reverse: true,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            for (final (index, page) in _pages.indexed) ...[
              if (index > 0) const SizedBox(width: Spacing.xs),
              _SourceThumbnail(
                page: page,
                onTap: () => showFullscreenImageViewer(
                  context,
                  pages: _pages,
                  initialIndex: index,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class const _SourceThumbnail({
  required final QuotePage _page,
  required final VoidCallback _onTap,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(Spacing.radiusM),
      child: Stack(
        children: [
          Image.file(
            File(_page.photoPath),
            width: _sourceThumbnailWidth,
            height: _sourceThumbnailHeight,
            cacheWidth: _sourceThumbnailCacheWidth,
            fit: BoxFit.cover,
          ),
          Positioned.fill(
            child: Material(
              color: Colors.transparent,
              child: InkWell(onTap: _onTap),
            ),
          ),
        ],
      ),
    );
  }
}

class const _Header({
  required final Quote _quote,
  required final Book? _book,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final date = MaterialLocalizations.of(context).formatMediumDate(_quote.createdAt.toLocal());
    final pages = _quote.pageNumbers;
    final meta = pages.isEmpty
        ? context.s.quoteDetailShotMeta(date)
        : context.s.quoteDetailPhotoMeta(pages.toPageLabel(), date);
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
              Text(
                meta,
                style: context.typography.label.copyWith(color: context.c.onSurfaceVariant),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class const _NoteCard({
  required final Quote _quote,
}) extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final controller = useTextEditingController(text: _quote.note ?? "");
    useEffect(() {
      final note = _quote.note ?? "";
      if (controller.text.trim() != note) controller.text = note;
      return null;
    }, [_quote.note]);
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
            context.s.quoteDetailNotesLabel,
            style: context.typography.label.copyWith(color: context.c.onSurfaceVariant),
          ),
          const SizedBox(height: Spacing.xs),
          TextField(
            controller: controller,
            minLines: 1,
            maxLines: 6,
            textCapitalization: TextCapitalization.sentences,
            style: context.t.bodyLarge?.copyWith(color: context.c.onSurface),
            onChanged: (value) =>
                context.read<QuoteDetailBloc>().add(QuoteDetailNoteChanged(value)),
            decoration: InputDecoration(
              isDense: true,
              filled: false,
              border: InputBorder.none,
              enabledBorder: InputBorder.none,
              focusedBorder: InputBorder.none,
              contentPadding: EdgeInsets.zero,
              hintText: context.s.quoteDetailNoteHint,
            ),
          ),
        ],
      ),
    );
  }
}

class const _Actions({
  required final Quote _quote,
  required final Book? _book,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _ActionButton(
          icon: _quote.isFavorite ? Icons.star_rounded : Icons.star_outline_rounded,
          label: context.s.quoteDetailFavoriteLabel,
          highlighted: _quote.isFavorite,
          onTap: () => context.read<QuoteDetailBloc>().add(const QuoteDetailFavoriteToggled()),
        ),
        const SizedBox(width: Spacing.xl),
        _ActionButton(
          icon: Icons.north_east,
          label: context.s.quoteDetailShareLabel,
          highlighted: false,
          onTap: () => _shareQuote(context, _quote, _book),
        ),
        const SizedBox(width: Spacing.xl),
        _ActionButton(
          icon: Icons.more_horiz,
          label: context.s.quoteDetailMoreLabel,
          highlighted: false,
          onTap: () => _showQuoteMenu(context, _quote),
        ),
      ],
    );
  }
}

Future<void> _shareQuote(BuildContext context, Quote quote, Book? book) async {
  final pages = quote.pageNumbers;
  final source = book == null
      ? context.s.libraryUnknownBook
      : (pages.isEmpty ? book.title : context.s.quoteSourceLabel(book.title, pages.toPageLabel()));
  await Share.share(context.s.quoteShareBody(quote.quote, source));
}

Future<void> _showQuoteMenu(BuildContext context, Quote quote) async {
  final action = await showModalBottomSheet<_QuoteMenuAction>(
    context: context,
    isScrollControlled: true,
    useRootNavigator: true,
    builder: (_) => _QuoteMenu(canEdit: quote.pages.isNotEmpty),
  );
  if (action == null || !context.mounted) return;
  switch (action) {
    case _QuoteMenuAction.edit:
      await _editQuote(context, quote);
    case _QuoteMenuAction.delete:
      await _deleteQuote(context);
  }
}

// * re-marking runs the capture flow again on the pages the quote already carries
Future<void> _editQuote(BuildContext context, Quote quote) async {
  final bloc = context.read<QuoteDetailBloc>();
  await context.pushMarking(
    MarkingArguments(
      shots: [
        for (final page in quote.pages)
          CapturedShot(imagePath: page.photoPath, pageQuad: fullFramePageQuad),
      ],
      bookId: quote.bookId,
      quote: quote,
    ),
  );
  bloc.add(const QuoteDetailStarted());
}

Future<void> _deleteQuote(BuildContext context) async {
  final bloc = context.read<QuoteDetailBloc>();
  final confirmed = await showConfirmDialog(
    context,
    title: context.s.quoteDeleteTitle,
    message: context.s.quoteDeleteMessage,
    confirmLabel: context.s.commonDelete,
    destructive: true,
  );
  if (confirmed) bloc.add(const QuoteDetailDeleteRequested());
}

enum _QuoteMenuAction { edit, delete }

class const _QuoteMenu({
  required final bool _canEdit,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SheetContent(
      children: [
        if (_canEdit)
          SheetActionTile(
            icon: Icons.edit_outlined,
            label: context.s.quoteEditAction,
            onTap: () => Navigator.of(context).pop(_QuoteMenuAction.edit),
          ),
        SheetActionTile(
          icon: Icons.delete_outline,
          label: context.s.quoteDeleteAction,
          destructive: true,
          onTap: () => Navigator.of(context).pop(_QuoteMenuAction.delete),
        ),
      ],
    );
  }
}

class const _ThemeChips({
  required final List<QuoteTheme> _themes,
  required final Set<String> _selected,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Wrap(
        spacing: Spacing.xs,
        runSpacing: Spacing.xs,
        children: [
          for (final theme in _themes)
            if (_selected.contains(theme.id))
              SelectableChip(
                label: theme.name,
                selected: true,
                selectedColor: context.c.secondary,
                selectedTextColor: context.c.onSecondary,
                onTap: () => context.read<QuoteDetailBloc>().add(QuoteDetailThemeToggled(theme.id)),
              ),
          SelectableChip(
            label: context.s.quoteDetailAddThemeChip,
            selected: false,
            onTap: () => _showThemePicker(context),
          ),
        ],
      ),
    );
  }
}

Future<void> _showThemePicker(BuildContext context) async {
  final bloc = context.read<QuoteDetailBloc>();
  await showModalBottomSheet<void>(
    context: context,
    isScrollControlled: true,
    useRootNavigator: true,
    builder: (_) => BlocProvider.value(value: bloc, child: const _ThemePickerSheet()),
  );
}

class const _ThemePickerSheet() extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<QuoteDetailBloc, QuoteDetailState>(
      builder: (context, state) {
        if (state is! QuoteDetailLoaded) return const SizedBox.shrink();
        return SheetContent(
          children: [
            Text(context.s.quoteDetailThemePickerTitle, style: context.t.titleMedium),
            const SizedBox(height: Spacing.m),
            Flexible(
              child: SingleChildScrollView(
                child: Wrap(
                  spacing: Spacing.xs,
                  runSpacing: Spacing.xs,
                  children: [
                    for (final theme in state.themes)
                      SelectableChip(
                        label: theme.name,
                        selected: state.selectedThemeIds.contains(theme.id),
                        selectedColor: context.c.secondary,
                        selectedTextColor: context.c.onSecondary,
                        onTap: () => context.read<QuoteDetailBloc>().add(
                          QuoteDetailThemeToggled(theme.id),
                        ),
                      ),
                    SelectableChip(
                      label: context.s.markingNewThemeChip,
                      selected: false,
                      onTap: () => _promptNewTheme(context),
                    ),
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}

Future<void> _promptNewTheme(BuildContext context) async {
  final bloc = context.read<QuoteDetailBloc>();
  final name = await showNameInputDialog(
    context,
    title: context.s.themesNewThemeTitle,
    hint: context.s.themesNewThemeHint,
  );
  if (name != null && name.trim().isNotEmpty) {
    bloc.add(QuoteDetailThemeCreateRequested(name));
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
          foregroundColor: _highlighted ? context.c.primary : context.c.onSurface,
          onPressed: _onTap,
        ),
        const SizedBox(height: Spacing.xxs),
        Text(
          _label,
          style: context.typography.caption.copyWith(color: context.c.onSurfaceVariant),
        ),
      ],
    );
  }
}
