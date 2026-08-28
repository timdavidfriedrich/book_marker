import 'package:audioplayers/audioplayers.dart';
import 'package:core/theme/spacing.dart';
import 'package:feature_library/presentation/bookmark_detail/bookmark_detail_bloc.dart';
import 'package:feature_library/presentation/bookmark_detail/bookmark_detail_event.dart';
import 'package:feature_library/presentation/bookmark_detail/bookmark_detail_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shared/domain/entities/book.dart';
import 'package:shared/domain/entities/bookmark.dart';
import 'package:shared/presentation/extensions/app_error_extensions.dart';
import 'package:shared/presentation/extensions/context_extensions.dart';
import 'package:shared/presentation/navigation/navigation_extensions.dart';
import 'package:shared/presentation/widgets/circle_icon_button.dart';
import 'package:shared/presentation/widgets/confirm_dialog.dart';
import 'package:shared/presentation/widgets/highlight_image.dart';
import 'package:shared/presentation/widgets/ink_tap_box.dart';
import 'package:shared/presentation/widgets/paper_card.dart';
import 'package:shared/presentation/widgets/sheet_action_tile.dart';

class const BookmarkDetailScreen({
  super.key,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocConsumer<BookmarkDetailBloc, BookmarkDetailState>(
          listenWhen: (previous, current) => current is BookmarkDetailDeleted,
          listener: (context, state) => context.closeScreen(),
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
            BookmarkDetailDeleted() => const SizedBox.shrink(),
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
          if (_bookmark.voicePath case final String path) ...[
            _VoicePlayer(path: path, durationMs: _bookmark.voiceDurationMs ?? 0),
            const SizedBox(height: Spacing.m),
          ],
          _NoteCard(bookmark: _bookmark),
          const SizedBox(height: Spacing.m),
          _Actions(bookmark: _bookmark, book: _book),
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
}) extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final controller = useTextEditingController(text: _bookmark.note ?? "");
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
          TextField(
            controller: controller,
            minLines: 1,
            maxLines: 4,
            textCapitalization: TextCapitalization.sentences,
            style: context.t.bodyMedium?.copyWith(color: context.c.onSurface),
            onChanged: (value) =>
                context.read<BookmarkDetailBloc>().add(BookmarkDetailNoteChanged(value)),
            decoration: InputDecoration(
              isDense: true,
              filled: false,
              border: InputBorder.none,
              enabledBorder: InputBorder.none,
              focusedBorder: InputBorder.none,
              contentPadding: EdgeInsets.zero,
              hintText: context.s.bookmarkDetailNoteHint,
            ),
          ),
        ],
      ),
    );
  }
}

class const _Actions({
  required final Bookmark _bookmark,
  required final Book? _book,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _ActionButton(
          icon: _bookmark.isFavorite ? Icons.star_rounded : Icons.star_outline_rounded,
          label: context.s.bookmarkDetailStarredLabel,
          highlighted: _bookmark.isFavorite,
          onTap: () =>
              context.read<BookmarkDetailBloc>().add(const BookmarkDetailFavoriteToggled()),
        ),
        const SizedBox(width: Spacing.xl),
        _ActionButton(
          icon: Icons.north_east,
          label: context.s.bookmarkDetailShareLabel,
          highlighted: false,
          onTap: () => _shareMark(context, _bookmark, _book),
        ),
        const SizedBox(width: Spacing.xl),
        _ActionButton(
          icon: Icons.more_horiz,
          label: context.s.bookmarkDetailMoreLabel,
          highlighted: false,
          onTap: () => _showMarkMenu(context),
        ),
      ],
    );
  }
}

Future<void> _shareMark(BuildContext context, Bookmark bookmark, Book? book) async {
  final page = bookmark.pageNumber;
  final source = book == null
      ? context.s.libraryUnknownBook
      : (page == null ? book.title : "${book.title}, ${context.s.pageShortLabel(page)}");
  await Share.share(context.s.markShareBody(bookmark.quote, source));
}

Future<void> _showMarkMenu(BuildContext context) async {
  final bloc = context.read<BookmarkDetailBloc>();
  final deleteRequested = await showModalBottomSheet<bool>(
    context: context,
    useRootNavigator: true,
    builder: (_) => const _MarkMenu(),
  );
  if (deleteRequested != true || !context.mounted) return;
  final confirmed = await showConfirmDialog(
    context,
    title: context.s.markDeleteTitle,
    message: context.s.markDeleteMessage,
    confirmLabel: context.s.commonDelete,
    destructive: true,
  );
  if (confirmed) bloc.add(const BookmarkDetailDeleteRequested());
}

class const _MarkMenu() extends StatelessWidget {
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
              label: context.s.markDeleteAction,
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

class const _VoicePlayer({
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
              context.s.markVoiceLabel(label),
              style: context.t.bodyLarge?.copyWith(color: coral.onSolid),
            ),
          ),
          Icon(Icons.graphic_eq, color: coral.onSolid, size: Spacing.iconM),
        ],
      ),
    );
  }
}
