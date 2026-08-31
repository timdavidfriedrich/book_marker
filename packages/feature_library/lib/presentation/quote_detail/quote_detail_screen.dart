import 'package:audioplayers/audioplayers.dart';
import 'package:core/theme/spacing.dart';
import 'package:feature_library/presentation/quote_detail/quote_detail_bloc.dart';
import 'package:feature_library/presentation/quote_detail/quote_detail_event.dart';
import 'package:feature_library/presentation/quote_detail/quote_detail_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shared/domain/entities/book.dart';
import 'package:shared/domain/entities/quote.dart';
import 'package:shared/presentation/extensions/app_error_extensions.dart';
import 'package:shared/presentation/extensions/context_extensions.dart';
import 'package:shared/presentation/navigation/navigation_extensions.dart';
import 'package:shared/presentation/widgets/circle_icon_button.dart';
import 'package:shared/presentation/widgets/confirm_dialog.dart';
import 'package:shared/presentation/widgets/highlight_image.dart';
import 'package:shared/presentation/widgets/ink_tap_box.dart';
import 'package:shared/presentation/widgets/paper_card.dart';
import 'package:shared/presentation/widgets/sheet_action_tile.dart';

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
            QuoteDetailLoading() => const Center(child: CircularProgressIndicator()),
            QuoteDetailFailure(:final error) => Center(
              child: Padding(
                padding: const EdgeInsets.all(Spacing.l),
                child: Text(error.toMessage(context), textAlign: TextAlign.center),
              ),
            ),
            QuoteDetailLoaded(:final quote, :final book) => _Content(
              quote: quote,
              book: book,
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
          _Header(quote: _quote, book: _book),
          const SizedBox(height: Spacing.m),
          _ModeToggle(index: mode.value, onChanged: (value) => mode.value = value),
          const SizedBox(height: Spacing.m),
          Expanded(
            child: mode.value == 1
                ? _PhotoView(quote: _quote)
                : _TextView(quote: _quote),
          ),
          const SizedBox(height: Spacing.m),
          if (_quote.voiceNotePath case final String path) ...[
            _VoiceNotePlayer(path: path, durationMs: _quote.voiceNoteDurationMs ?? 0),
            const SizedBox(height: Spacing.m),
          ],
          _NoteCard(quote: _quote),
          const SizedBox(height: Spacing.m),
          _Actions(quote: _quote, book: _book),
          const SizedBox(height: Spacing.s),
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
    final page = _quote.pageNumber;
    final meta = page == null
        ? context.s.quoteDetailShotMeta(date)
        : context.s.quoteDetailPhotoMeta(page, date);
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
  required final Quote _quote,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return PaperCard(
      padding: const EdgeInsets.all(Spacing.m),
      child: Center(
        child: SingleChildScrollView(
          child: HighlightImage(
            imagePath: _quote.photoPath,
            aspectRatio: _quote.imageAspectRatio,
            highlights: _quote.highlights,
          ),
        ),
      ),
    );
  }
}

class const _TextView({
  required final Quote _quote,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return PaperCard(
      padding: const EdgeInsets.all(Spacing.l),
      child: SingleChildScrollView(
        child: Text.rich(
          TextSpan(
            text: _quote.quote,
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
  required final Quote _quote,
}) extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final controller = useTextEditingController(text: _quote.note ?? "");
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
            '“${_quote.quote}”',
            style: context.typography.readingQuoteItalic.copyWith(color: context.c.onSurface),
          ),
          const SizedBox(height: Spacing.xs),
          TextField(
            controller: controller,
            minLines: 1,
            maxLines: 4,
            textCapitalization: TextCapitalization.sentences,
            style: context.t.bodyMedium?.copyWith(color: context.c.onSurface),
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
          onTap: () =>
              context.read<QuoteDetailBloc>().add(const QuoteDetailFavoriteToggled()),
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
          onTap: () => _showQuoteMenu(context),
        ),
      ],
    );
  }
}

Future<void> _shareQuote(BuildContext context, Quote quote, Book? book) async {
  final page = quote.pageNumber;
  final source = book == null
      ? context.s.libraryUnknownBook
      : (page == null ? book.title : context.s.quoteSourceLabel(book.title, page));
  await Share.share(context.s.quoteShareBody(quote.quote, source));
}

Future<void> _showQuoteMenu(BuildContext context) async {
  final bloc = context.read<QuoteDetailBloc>();
  final deleteRequested = await showModalBottomSheet<bool>(
    context: context,
    useRootNavigator: true,
    builder: (_) => const _QuoteMenu(),
  );
  if (deleteRequested != true || !context.mounted) return;
  final confirmed = await showConfirmDialog(
    context,
    title: context.s.quoteDeleteTitle,
    message: context.s.quoteDeleteMessage,
    confirmLabel: context.s.commonDelete,
    destructive: true,
  );
  if (confirmed) bloc.add(const QuoteDetailDeleteRequested());
}

class const _QuoteMenu() extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(Spacing.l),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SheetActionTile(
              icon: Icons.delete_outline,
              label: context.s.quoteDeleteAction,
              destructive: true,
              onTap: () => Navigator.of(context).pop(true),
            ),
          ],
        ),
      ),
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

class const _VoiceNotePlayer({
  required final String _path,
  required final int _durationMs,
}) extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final player = useMemoized(AudioPlayer.new);
    useEffect(() => player.dispose, [player]);
    final playing = useState(false);
    useEffect(() {
      final subscription = player.onPlayerComplete.listen((_) => playing.value = false);
      return subscription.cancel;
    }, [player]);

    final coral = context.palette.coral;
    final duration = Duration(milliseconds: _durationMs);
    final label = "${duration.inMinutes}:${(duration.inSeconds % 60).toString().padLeft(2, "0")}";
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: Spacing.m, vertical: Spacing.xs),
      decoration: BoxDecoration(color: coral.solid, borderRadius: BorderRadius.circular(Spacing.radiusFull)),
      child: Row(
        children: [
          IconButton(
            onPressed: () async {
              if (playing.value) {
                await player.pause();
                playing.value = false;
              } else {
                await player.play(DeviceFileSource(_path));
                playing.value = true;
              }
            },
            icon: Icon(playing.value ? Icons.pause : Icons.play_arrow),
            color: coral.onSolid,
            iconSize: Spacing.iconM,
          ),
          const SizedBox(width: Spacing.xs),
          Expanded(
            child: Text(
              context.s.quoteVoiceNoteLabel(label),
              style: context.t.bodyLarge?.copyWith(color: coral.onSolid),
            ),
          ),
          Icon(Icons.graphic_eq, color: coral.onSolid, size: Spacing.iconM),
        ],
      ),
    );
  }
}
