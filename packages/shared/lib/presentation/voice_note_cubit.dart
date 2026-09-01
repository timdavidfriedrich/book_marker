import 'dart:async';

import 'package:core/error/app_result.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:shared/domain/entities/voice_note.dart';
import 'package:shared/domain/repositories/voice_note_repository.dart';
import 'package:shared/presentation/voice_note_state.dart';

const _tickInterval = Duration(milliseconds: 200);

@injectable
class VoiceNoteCubit extends Cubit<VoiceNoteState> {
  VoiceNoteCubit(this._voiceNoteRepository) : super(const VoiceNoteIdle());

  final VoiceNoteRepository _voiceNoteRepository;
  final Stopwatch _recordingTime = Stopwatch();
  Timer? _ticker;
  StreamSubscription<AppResult<Duration>>? _positionSubscription;
  StreamSubscription<AppResult<()>>? _finishedSubscription;
  Duration _position = Duration.zero;
  String? _playingPath;
  bool _isStarting = false;
  bool _isStopRequested = false;

  Future<void> startRecording() async {
    if (_isStarting || state is VoiceNoteRecording) return;
    _isStarting = true;
    _isStopRequested = false;
    _playingPath = null;
    await _voiceNoteRepository.stopPlayback();
    final result = await _voiceNoteRepository.startRecording();
    _isStarting = false;
    if (isClosed) return;
    if (result case Failure(:final error)) {
      emit(VoiceNoteFailure(error: error));
      return;
    }
    _recordingTime
      ..reset()
      ..start();
    // * the press can end while the recorder is still starting up
    if (_isStopRequested) {
      await stopRecording();
      return;
    }
    _ticker = Timer.periodic(
      _tickInterval,
      (_) => emit(VoiceNoteRecording(elapsed: _recordingTime.elapsed)),
    );
    emit(const VoiceNoteRecording(elapsed: Duration.zero));
  }

  Future<void> stopRecording() async {
    if (_isStarting) {
      _isStopRequested = true;
      return;
    }
    if (state is! VoiceNoteRecording) return;
    _ticker?.cancel();
    _ticker = null;
    _recordingTime.stop();
    final result = await _voiceNoteRepository.stopRecording();
    if (isClosed) return;
    emit(switch (result) {
      Failure(:final error) => VoiceNoteFailure(error: error),
      Success(data: final VoiceNote voiceNote) => VoiceNoteRecorded(voiceNote: voiceNote),
      Success() => const VoiceNoteIdle(),
    });
  }

  Future<void> startPlayback(String path) async {
    if (state is VoiceNoteRecording) return;
    if (_playingPath != path) _position = Duration.zero;
    final result = await _voiceNoteRepository.startPlayback(path);
    if (isClosed) return;
    if (result case Failure(:final error)) {
      emit(VoiceNoteFailure(error: error));
      return;
    }
    _playingPath = path;
    _positionSubscription ??= _voiceNoteRepository.watchPlaybackPosition().listen(_onPosition);
    _finishedSubscription ??= _voiceNoteRepository.watchPlaybackFinished().listen(_onFinished);
    emit(VoiceNotePlaying(path: path, position: _position));
  }

  Future<void> pausePlayback() async {
    if (state is! VoiceNotePlaying) return;
    final result = await _voiceNoteRepository.pausePlayback();
    if (isClosed) return;
    emit(switch (result) {
      Failure(:final error) => VoiceNoteFailure(error: error),
      Success() => const VoiceNoteIdle(),
    });
  }

  Future<void> discardPlayback() async {
    _position = Duration.zero;
    _playingPath = null;
    await _voiceNoteRepository.stopPlayback();
    if (isClosed) return;
    emit(const VoiceNoteIdle());
  }

  void _onPosition(AppResult<Duration> result) {
    if (result case Success(data: final position)) {
      _position = position;
      if (state case VoiceNotePlaying(:final path)) {
        emit(VoiceNotePlaying(path: path, position: position));
      }
    }
  }

  void _onFinished(AppResult<()> result) {
    _position = Duration.zero;
    if (state is VoiceNotePlaying) emit(const VoiceNoteIdle());
  }

  @override
  Future<void> close() async {
    _ticker?.cancel();
    await _positionSubscription?.cancel();
    await _finishedSubscription?.cancel();
    await _voiceNoteRepository.dispose();
    return super.close();
  }
}
