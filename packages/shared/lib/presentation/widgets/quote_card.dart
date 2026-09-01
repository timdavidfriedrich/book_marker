import 'package:audioplayers/audioplayers.dart';
import 'package:core/theme/spacing.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:shared/presentation/extensions/context_extensions.dart';
import 'package:shared/presentation/widgets/book_cover.dart';
import 'package:shared/presentation/widgets/expandable_text.dart';
import 'package:shared/presentation/widgets/ink_tap_box.dart';
import 'package:shared/presentation/widgets/page_pill.dart';

const _coverWidth = 52.0;
const _coverHeight = 68.0;
const _quoteMaxLines = 4;
const _voiceNoteDotSize = 18.0;
const _voiceNoteIconSize = 12.0;

class const QuoteCard({
  required final String _quote,
  required final String _bookTitle,
  final String? _coverImage,
  final List<int> _pages = const [],
  final String? _note,
  final String? _sourceLabel,
  final bool _isFavorite = false,
  final bool _hasVoiceNote = false,
  final Duration? _voiceNoteDuration,
  final String? _voiceNotePath,
  final VoidCallback? _onTap,
  super.key,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return InkTapBox(
      onTap: _onTap,
      color: context.c.surfaceContainerLow,
      radius: Spacing.radiusL,
      padding: const EdgeInsets.all(Spacing.m),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            children: [
              BookCover(
                title: _bookTitle,
                image: _coverImage,
                width: _coverWidth,
                height: _coverHeight,
              ),
              if (_pages.isNotEmpty) ...[
                const SizedBox(height: Spacing.xs),
                PagePill(pages: _pages),
              ],
            ],
          ),
          const SizedBox(width: Spacing.m),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ExpandableText(
                  text: _quote,
                  maxLines: _quoteMaxLines,
                  style: context.typography.readingQuote,
                ),
                if (_note case final String note) ...[
                  const SizedBox(height: Spacing.xs),
                  Text(
                    note,
                    style: context.t.bodyMedium?.copyWith(color: context.c.onSurfaceVariant),
                  ),
                ],
                const SizedBox(height: Spacing.s),
                Row(
                  children: [
                    if (_sourceLabel case final String source)
                      Expanded(
                        child: Text(
                          source,
                          style: context.typography.monoLabel.copyWith(
                            color: context.c.onSurfaceVariant,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      )
                    else
                      const Spacer(),
                    if (_hasVoiceNote) ...[
                      const SizedBox(width: Spacing.s),
                      _VoiceNoteTag(
                        duration: _voiceNoteDuration ?? Duration.zero,
                        path: _voiceNotePath,
                      ),
                    ],
                    if (_isFavorite) ...[
                      const SizedBox(width: Spacing.s),
                      Icon(
                        Icons.star_rounded,
                        size: Spacing.iconM,
                        color: context.c.primary,
                      ),
                    ],
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class const _VoiceNoteTag({
  required final Duration _duration,
  final String? _path,
}) extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final minutes = _duration.inMinutes;
    final seconds = _duration.inSeconds % 60;
    final label = "$minutes:${seconds.toString().padLeft(2, "0")}";

    final player = useMemoized(AudioPlayer.new);
    useEffect(() => player.dispose, [player]);
    final playing = useState(false);
    useEffect(() {
      final subscription = player.onPlayerComplete.listen((_) => playing.value = false);
      return subscription.cancel;
    }, [player]);

    final path = _path;
    final content = Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: _voiceNoteDotSize,
          height: _voiceNoteDotSize,
          alignment: Alignment.center,
          decoration: BoxDecoration(color: context.c.tertiary, shape: BoxShape.circle),
          child: Icon(
            path == null
                ? Icons.mic_rounded
                : (playing.value ? Icons.pause : Icons.play_arrow_rounded),
            size: _voiceNoteIconSize,
            color: context.c.onTertiary,
          ),
        ),
        const SizedBox(width: Spacing.xxs),
        Text(
          context.s.quoteVoiceNoteLabel(label),
          style: context.typography.monoLabel.copyWith(
            color: path == null ? context.c.onSurfaceVariant : context.c.onTertiaryContainer,
          ),
        ),
      ],
    );

    if (path == null) return content;

    return InkTapBox(
      radius: Spacing.radiusFull,
      color: context.c.tertiaryContainer,
      padding: const EdgeInsets.symmetric(horizontal: Spacing.xs, vertical: Spacing.xxs),
      onTap: () async {
        if (playing.value) {
          await player.pause();
          playing.value = false;
        } else {
          await player.play(DeviceFileSource(path));
          playing.value = true;
        }
      },
      child: content,
    );
  }
}
