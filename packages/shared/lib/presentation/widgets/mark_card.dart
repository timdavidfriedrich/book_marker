import 'package:audioplayers/audioplayers.dart';
import 'package:core/theme/spacing.dart';
import 'package:core/theme/theme_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:shared/presentation/extensions/context_extensions.dart';
import 'package:shared/presentation/widgets/book_cover.dart';
import 'package:shared/presentation/widgets/ink_tap_box.dart';
import 'package:shared/presentation/widgets/page_pill.dart';

const _coverWidth = 52.0;
const _coverHeight = 68.0;
const _voiceDotSize = 18.0;
const _voiceIconSize = 12.0;

class const MarkCard({
  required final AccentColor _accent,
  required final String _quote,
  final String? _thumbnailUrl,
  final int? _page,
  final bool _pageFilled = false,
  final String? _note,
  final String? _sourceLabel,
  final bool _isStarred = false,
  final bool _hasVoice = false,
  final Duration? _voiceDuration,
  final String? _voicePath,
  final Color? _backgroundColor,
  final VoidCallback? _onTap,
  super.key,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return InkTapBox(
      onTap: _onTap,
      color: _backgroundColor ?? context.c.surfaceContainerLow,
      radius: Spacing.radiusL,
      padding: const EdgeInsets.all(Spacing.m),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
            Column(
              children: [
                BookCover(
                  accent: _accent,
                  url: _thumbnailUrl,
                  width: _coverWidth,
                  height: _coverHeight,
                ),
                if (_page case final int page) ...[
                  const SizedBox(height: Spacing.xs),
                  PagePill(page: page, accent: _accent, filled: _pageFilled),
                ],
              ],
            ),
            const SizedBox(width: Spacing.m),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(_quote, style: context.typography.readingQuote),
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
                            style: context.typography.monoLabel
                                .copyWith(color: context.c.onSurfaceVariant),
                            overflow: TextOverflow.ellipsis,
                          ),
                        )
                      else
                        const Spacer(),
                      if (_hasVoice) ...[
                        _VoiceTag(duration: _voiceDuration ?? Duration.zero, path: _voicePath),
                        const SizedBox(width: Spacing.s),
                      ],
                      if (_isStarred)
                        Icon(
                          Icons.star_rounded,
                          size: Spacing.iconM,
                          color: context.palette.amber.solid,
                        ),
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

class const _VoiceTag({
  required final Duration _duration,
  final String? _path,
}) extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final minutes = _duration.inMinutes;
    final seconds = _duration.inSeconds % 60;
    final label = "$minutes:${seconds.toString().padLeft(2, "0")}";
    final coral = context.palette.coral;

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
          width: _voiceDotSize,
          height: _voiceDotSize,
          alignment: Alignment.center,
          decoration: BoxDecoration(color: coral.solid, shape: BoxShape.circle),
          child: Icon(
            path == null
                ? Icons.mic_rounded
                : (playing.value ? Icons.pause : Icons.play_arrow_rounded),
            size: _voiceIconSize,
            color: coral.onSolid,
          ),
        ),
        const SizedBox(width: Spacing.xxs),
        Text(
          context.s.markVoiceLabel(label),
          style: context.typography.monoLabel.copyWith(color: context.c.onSurfaceVariant),
        ),
      ],
    );

    if (path == null) return content;

    return InkTapBox(
      radius: Spacing.radiusFull,
      color: coral.fill,
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
