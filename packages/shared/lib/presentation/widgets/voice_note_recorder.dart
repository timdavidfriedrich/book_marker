import 'dart:async';
import 'dart:math';

import 'package:core/theme/spacing.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:shared/presentation/extensions/app_error_extensions.dart';
import 'package:shared/presentation/extensions/context_extensions.dart';
import 'package:shared/presentation/extensions/duration_extensions.dart';
import 'package:shared/presentation/voice_note_cubit.dart';
import 'package:shared/presentation/voice_note_state.dart';
import 'package:shared/presentation/widgets/confirm_dialog.dart';
import 'package:shared/presentation/widgets/ink_tap_box.dart';

const _pillHeight = 60.0;
const _dotSize = 32.0;
const _buttonSize = 40.0;
const _floodDuration = Duration(milliseconds: 280);
const _pulseDuration = Duration(milliseconds: 1400);
const _pulseMaxScale = 1.75;
const _pulseOpacity = 0.4;
const _pillRadius = BorderRadius.all(Radius.circular(Spacing.radiusFull));

Future<void> _confirmDelete(
  BuildContext context,
  VoiceNoteCubit cubit,
  VoidCallback onCleared,
) async {
  final confirmed = await showConfirmDialog(
    context,
    title: context.s.voiceNoteDeleteTitle,
    message: context.s.voiceNoteDeleteMessage,
    confirmLabel: context.s.voiceNoteDeleteAction,
    destructive: true,
  );
  if (!confirmed) return;
  await cubit.discardPlayback();
  onCleared();
}

class const VoiceNoteRecorder({
  required final String? _path,
  required final int? _durationMs,
  required final void Function(String path, int durationMs) _onRecorded,
  required final VoidCallback _onCleared,
  final BorderRadiusGeometry _borderRadius = _pillRadius,
  super.key,
}) extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final origin = useState(Offset.zero);
    final flood = useAnimationController(duration: _floodDuration);
    final pulse = useAnimationController(duration: _pulseDuration);
    final cubit = context.watch<VoiceNoteCubit>();
    final state = cubit.state;
    final isRecording = state is VoiceNoteRecording;

    useEffect(() {
      if (!isRecording) {
        flood.reverse();
        return null;
      }
      unawaited(HapticFeedback.mediumImpact());
      flood.forward();
      pulse.repeat();
      return null;
    }, [isRecording]);

    useEffect(() {
      return () => unawaited(cubit.stopRecording());
    }, [cubit]);

    useEffect(() {
      void onFlood(AnimationStatus status) {
        if (status == AnimationStatus.dismissed) pulse.stop();
      }

      flood.addStatusListener(onFlood);
      return () => flood.removeStatusListener(onFlood);
    }, [flood, pulse]);

    final recordedPath = isRecording ? null : _path;
    final hasNote = recordedPath != null;
    final isPlaying = switch (state) {
      VoiceNotePlaying(:final path) => path == recordedPath,
      _ => false,
    };
    final label = switch (state) {
      VoiceNoteRecording(:final elapsed) => elapsed.toMinutesSecondsString(),
      VoiceNotePlaying(:final path, :final position) when path == recordedPath =>
        position.toMinutesSecondsString(),
      _ when hasNote => Duration(milliseconds: _durationMs ?? 0).toMinutesSecondsString(),
      _ => context.s.voiceNoteHint,
    };

    return BlocListener<VoiceNoteCubit, VoiceNoteState>(
      listenWhen: (previous, current) =>
          current is VoiceNoteRecorded || current is VoiceNoteFailure,
      listener: (context, state) {
        if (state case VoiceNoteRecorded(:final voiceNote)) {
          _onRecorded(voiceNote.path, voiceNote.durationMs);
        }
        if (state case VoiceNoteFailure(:final error)) context.showToast(error.toMessage(context));
      },
      child: Listener(
        behavior: HitTestBehavior.opaque,
        onPointerDown: hasNote
            ? null
            : (event) {
                origin.value = event.localPosition;
                unawaited(cubit.startRecording());
              },
        onPointerUp: hasNote ? null : (_) => unawaited(cubit.stopRecording()),
        onPointerCancel: hasNote ? null : (_) => unawaited(cubit.stopRecording()),
        child: AnimatedBuilder(
          animation: flood,
          builder: (context, child) {
            final progress = flood.value;
            final surface = hasNote ? context.c.tertiaryContainer : context.c.surfaceContainerHigh;
            final restForeground = hasNote
                ? context.c.onTertiaryContainer
                : context.c.onSurfaceVariant;
            final foreground = Color.lerp(restForeground, context.c.onTertiary, progress)!;
            final fill = Color.lerp(context.c.tertiary, context.c.onTertiary, progress)!;
            final onFill = Color.lerp(context.c.onTertiary, context.c.tertiary, progress)!;
            return DecoratedBox(
              decoration: BoxDecoration(color: surface, borderRadius: _borderRadius),
              child: ClipRRect(
                borderRadius: _borderRadius,
                child: CustomPaint(
                  painter: _FloodPainter(
                    origin: origin.value,
                    progress: progress,
                    color: context.c.tertiary,
                  ),
                  child: SizedBox(
                    height: _pillHeight,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: Spacing.s),
                      child: Row(
                        children: [
                          if (recordedPath case final String path)
                            _PlayPauseButton(
                              isPlaying: isPlaying,
                              fill: fill,
                              iconColor: onFill,
                              onTap: () => unawaited(
                                isPlaying ? cubit.pausePlayback() : cubit.startPlayback(path),
                              ),
                            )
                          else
                            _RecordingDot(
                              isRecording: isRecording,
                              fill: fill,
                              iconColor: onFill,
                              pulse: pulse,
                            ),
                          const SizedBox(width: Spacing.s),
                          Expanded(
                            child: Text(
                              label,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: context.t.bodyLarge?.copyWith(color: foreground),
                            ),
                          ),
                          if (hasNote)
                            SizedBox.square(
                              dimension: _buttonSize,
                              child: InkTapBox(
                                onTap: () => unawaited(_confirmDelete(context, cubit, _onCleared)),
                                circle: true,
                                child: Icon(
                                  Icons.delete_outline,
                                  size: Spacing.iconM,
                                  color: foreground,
                                ),
                              ),
                            )
                          else
                            Icon(
                              isRecording ? Icons.fiber_manual_record : Icons.graphic_eq,
                              color: foreground,
                              size: Spacing.iconM,
                            ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class const _PlayPauseButton({
  required final bool _isPlaying,
  required final Color _fill,
  required final Color _iconColor,
  required final VoidCallback _onTap,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox.square(
      dimension: _buttonSize,
      child: InkTapBox(
        onTap: _onTap,
        circle: true,
        color: _fill,
        child: Icon(
          _isPlaying ? Icons.pause_rounded : Icons.play_arrow_rounded,
          size: Spacing.iconM,
          color: _iconColor,
        ),
      ),
    );
  }
}

class const _RecordingDot({
  required final bool _isRecording,
  required final Color _fill,
  required final Color _iconColor,
  required final Animation<double> _pulse,
}) extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final scale = useMemoized(
      () => Tween(
        begin: 1.0,
        end: _pulseMaxScale,
      ).chain(CurveTween(curve: Curves.easeOut)).animate(_pulse),
      [_pulse],
    );
    final opacity = useMemoized(
      () => Tween(begin: _pulseOpacity, end: 0.0).animate(_pulse),
      [_pulse],
    );
    return Stack(
      alignment: Alignment.center,
      clipBehavior: Clip.none,
      children: [
        if (_isRecording)
          FadeTransition(
            opacity: opacity,
            child: ScaleTransition(
              scale: scale,
              child: Container(
                width: _dotSize,
                height: _dotSize,
                decoration: BoxDecoration(color: _fill, shape: BoxShape.circle),
              ),
            ),
          ),
        Container(
          width: _dotSize,
          height: _dotSize,
          alignment: Alignment.center,
          decoration: BoxDecoration(color: _fill, shape: BoxShape.circle),
          child: Icon(Icons.mic_rounded, size: Spacing.iconS, color: _iconColor),
        ),
      ],
    );
  }
}

class const _FloodPainter({
  required final Offset _origin,
  required final double _progress,
  required final Color _color,
}) extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    if (_progress <= 0) return;
    final corners = [
      Offset.zero,
      Offset(size.width, 0),
      Offset(0, size.height),
      Offset(size.width, size.height),
    ];
    final radius = corners.map((corner) => (corner - _origin).distance).reduce(max);
    canvas.drawCircle(_origin, radius * _progress, Paint()..color = _color);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
