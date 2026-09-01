import 'dart:io';

import 'package:audioplayers/audioplayers.dart';
import 'package:core/error/app_error.dart';
import 'package:core/error/app_result.dart';
import 'package:injectable/injectable.dart';
import 'package:path_provider/path_provider.dart';
import 'package:record/record.dart';
import 'package:shared/domain/entities/voice_note.dart';
import 'package:shared/domain/repositories/voice_note_repository.dart';
import 'package:uuid/uuid.dart';

const _uuid = Uuid();
const _minDurationMs = 500;

@Injectable(as: VoiceNoteRepository)
class VoiceNoteRepositoryImpl() implements VoiceNoteRepository {
  final AudioRecorder _recorder = AudioRecorder();
  final AudioPlayer _player = AudioPlayer();
  final Stopwatch _recordingTime = Stopwatch();
  String? _loadedPath;

  @override
  Future<AppResult<()>> startRecording() async {
    try {
      if (!await _recorder.hasPermission()) return const Failure(MicrophonePermissionError());
      final directory = await getApplicationDocumentsDirectory();
      final path = "${directory.path}/voice_${_uuid.v4()}.m4a";
      await _recorder.start(const RecordConfig(), path: path);
      _recordingTime
        ..reset()
        ..start();
      return const Success(());
    } on Object {
      return const Failure(UnexpectedError());
    }
  }

  @override
  Future<AppResult<VoiceNote?>> stopRecording() async {
    try {
      _recordingTime.stop();
      final durationMs = _recordingTime.elapsedMilliseconds;
      final path = await _recorder.stop();
      if (path == null) return const Success(null);
      // * a press too short to hold any speech leaves nothing worth keeping on disk
      if (durationMs < _minDurationMs) {
        await File(path).delete();
        return const Success(null);
      }
      return Success(VoiceNote(path: path, durationMs: durationMs));
    } on Object {
      return const Failure(UnexpectedError());
    }
  }

  @override
  Future<AppResult<()>> startPlayback(String path) async {
    try {
      if (_loadedPath == path && _player.state == PlayerState.paused) {
        await _player.resume();
        return const Success(());
      }
      await _player.play(DeviceFileSource(path));
      _loadedPath = path;
      return const Success(());
    } on Object {
      return const Failure(UnexpectedError());
    }
  }

  @override
  Future<AppResult<()>> pausePlayback() async {
    try {
      await _player.pause();
      return const Success(());
    } on Object {
      return const Failure(UnexpectedError());
    }
  }

  @override
  Future<AppResult<()>> stopPlayback() async {
    try {
      await _player.stop();
      _loadedPath = null;
      return const Success(());
    } on Object {
      return const Failure(UnexpectedError());
    }
  }

  @override
  Stream<AppResult<Duration>> watchPlaybackPosition() =>
      _player.onPositionChanged.map<AppResult<Duration>>(Success.new);

  @override
  Stream<AppResult<()>> watchPlaybackFinished() =>
      _player.onPlayerComplete.map<AppResult<()>>((_) => const Success(()));

  @override
  Future<AppResult<()>> dispose() async {
    try {
      await _recorder.dispose();
      await _player.dispose();
      return const Success(());
    } on Object {
      return const Failure(UnexpectedError());
    }
  }
}
