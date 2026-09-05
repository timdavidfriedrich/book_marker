import 'package:core/theme/corner_radii.dart';
import 'package:core/theme/spacing.dart';
import 'package:feature_library/presentation/quote_detail/quote_detail_bloc.dart';
import 'package:feature_library/presentation/quote_detail/quote_detail_event.dart';
import 'package:feature_library/presentation/quote_detail/quote_detail_state.dart';
import 'package:feature_library/presentation/widgets/quote_menu.dart';
import 'package:feature_library/presentation/widgets/quote_theme_chips.dart';
import 'package:feature_library/presentation/widgets/source_thumbnails.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shared/domain/entities/book.dart';
import 'package:shared/domain/entities/quote.dart';
import 'package:shared/domain/entities/quote_theme.dart';
import 'package:shared/presentation/extensions/app_error_extensions.dart';
import 'package:shared/presentation/extensions/context_extensions.dart';
import 'package:shared/presentation/extensions/page_number_extensions.dart';
import 'package:shared/presentation/extensions/screen_layout_extensions.dart';
import 'package:shared/presentation/navigation/navigation_extensions.dart';
import 'package:shared/presentation/widgets/circle_icon_button.dart';
import 'package:shared/presentation/widgets/ink_tap_box.dart';
import 'package:shared/presentation/widgets/loading_screen.dart';
import 'package:shared/presentation/widgets/page_number_field.dart';
import 'package:shared/presentation/widgets/quote_paper_card.dart';
import 'package:shared/presentation/widgets/voice_note_recorder.dart';

const _quoteMaxLines = 8;
const _noteMaxLines = 6;
const _pageFieldMinWidth = 128.0;
const _readingColumnFlex = 3;
const _metadataColumnFlex = 2;
const _annotationRadius = Spacing.radiusXl;

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
            QuoteDetailLoading() => const LoadingScreen(),
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
    final citation = _CitationCard(quote: _quote);
    final source = _SourceRow(quote: _quote);
    final voiceNote = VoiceNoteRecorder(
      borderRadius: CornerRadii.grouped(
        outer: _annotationRadius,
        isFirst: true,
        isLast: false,
      ),
      path: _quote.voiceNotePath,
      durationMs: _quote.voiceNoteDurationMs,
      onRecorded: (path, durationMs) => context.read<QuoteDetailBloc>().add(
        QuoteDetailVoiceNoteRecorded(path, durationMs),
      ),
      onCleared: () => context.read<QuoteDetailBloc>().add(const QuoteDetailVoiceNoteCleared()),
    );
    final note = _NoteField(quote: _quote);
    final themes = QuoteThemeChips(themes: _themes, selected: _selectedThemeIds);
    return Padding(
      padding: EdgeInsets.fromLTRB(margin, Spacing.s, margin, Spacing.m),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _Header(quote: _quote, book: _book),
          const SizedBox(height: Spacing.xs),
          Expanded(
            child: layout.isWide
                ? Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        flex: _readingColumnFlex,
                        child: _Column(
                          children: [
                            citation,
                            const SizedBox(height: Spacing.m),
                            voiceNote,
                            const SizedBox(height: Spacing.xxxs),
                            note,
                          ],
                        ),
                      ),
                      const SizedBox(width: Spacing.xl),
                      Expanded(
                        flex: _metadataColumnFlex,
                        child: _Column(
                          children: [
                            source,
                            const SizedBox(height: Spacing.m),
                            themes,
                          ],
                        ),
                      ),
                    ],
                  )
                : _Column(
                    children: [
                      citation,
                      const SizedBox(height: Spacing.m),
                      source,
                      const SizedBox(height: Spacing.m),
                      voiceNote,
                      const SizedBox(height: Spacing.xxxs),
                      note,
                      const SizedBox(height: Spacing.m),
                      themes,
                    ],
                  ),
          ),
          const SizedBox(height: Spacing.m),
          _ShareButton(quote: _quote, book: _book),
        ],
      ),
    );
  }
}

class const _Column({
  required final List<Widget> _children,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: _children),
    );
  }
}

class const _Header({
  required final Quote _quote,
  required final Book? _book,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
                MaterialLocalizations.of(context).formatMediumDate(_quote.createdAt.toLocal()),
                style: context.typography.label.copyWith(color: context.c.onSurfaceVariant),
              ),
            ],
          ),
        ),
        const SizedBox(width: Spacing.s),
        CircleIconButton(
          icon: _quote.isFavorite ? Icons.star_rounded : Icons.star_outline_rounded,
          tooltip: context.s.quoteDetailFavoriteLabel,
          foregroundColor: _quote.isFavorite ? context.c.primary : context.c.onSurfaceVariant,
          onPressed: () => context.read<QuoteDetailBloc>().add(const QuoteDetailFavoriteToggled()),
        ),
        const SizedBox(width: Spacing.xs),
        CircleIconButton(
          icon: Icons.more_vert,
          tooltip: context.s.quoteDetailMoreLabel,
          foregroundColor: context.c.onSurfaceVariant,
          onPressed: () => showQuoteMenu(context, _quote),
        ),
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
    useEffect(() {
      if (controller.text.trim() != _quote.quote) controller.text = _quote.quote;
      return null;
    }, [_quote.quote]);
    return QuotePaperCard(
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

class const _SourceRow({
  required final Quote _quote,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final pages = _quote.pages;
    final field = PageNumberField(
      pages: _quote.pageNumbers,
      onChanged: (pageNumbers) => context.read<QuoteDetailBloc>().add(
        QuoteDetailPageNumbersChanged(pageNumbers),
      ),
    );
    if (pages.isEmpty) return field;
    // * the strip keeps its natural width so the page field can take whatever is left over
    return LayoutBuilder(
      builder: (context, constraints) => IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(child: field),
            const SizedBox(width: Spacing.s),
            ConstrainedBox(
              constraints: BoxConstraints(
                maxWidth: (constraints.maxWidth - _pageFieldMinWidth - Spacing.s).clamp(
                  0.0,
                  double.infinity,
                ),
              ),
              child: SourceThumbnails(pages: pages),
            ),
          ],
        ),
      ),
    );
  }
}

class const _NoteField({
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
      padding: const EdgeInsets.symmetric(horizontal: Spacing.m, vertical: Spacing.s),
      decoration: BoxDecoration(
        color: context.c.surfaceContainerHigh,
        borderRadius: CornerRadii.grouped(
          outer: _annotationRadius,
          isFirst: false,
          isLast: true,
        ),
      ),
      child: TextField(
        controller: controller,
        minLines: 1,
        maxLines: _noteMaxLines,
        textCapitalization: TextCapitalization.sentences,
        style: context.t.bodyLarge?.copyWith(color: context.c.onSurface),
        onChanged: (value) => context.read<QuoteDetailBloc>().add(QuoteDetailNoteChanged(value)),
        decoration: InputDecoration(
          isDense: true,
          filled: false,
          border: InputBorder.none,
          enabledBorder: InputBorder.none,
          focusedBorder: InputBorder.none,
          contentPadding: EdgeInsets.zero,
          hintText: context.s.quoteDetailNoteHint,
          hintStyle: context.t.bodyLarge?.copyWith(color: context.c.onSurfaceVariant),
        ),
      ),
    );
  }
}

class const _ShareButton({
  required final Quote _quote,
  required final Book? _book,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return InkTapBox(
      onTap: () => _shareQuote(context, _quote, _book),
      color: context.c.surfaceContainerHigh,
      radius: Spacing.radiusL,
      padding: const EdgeInsets.symmetric(vertical: Spacing.m),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.north_east, size: Spacing.iconS, color: context.c.onSurface),
          const SizedBox(width: Spacing.xs),
          Text(context.s.quoteDetailShareButton, style: context.t.labelLarge),
        ],
      ),
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
