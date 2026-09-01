import 'package:core/error/app_result.dart';
import 'package:shared/domain/entities/voice_note.dart';

abstract class VoiceNoteRepository {
  Future<AppResult<()>> startRecording();
  Future<AppResult<VoiceNote?>> stopRecording();
  Future<AppResult<()>> startPlayback(String path);
  Future<AppResult<()>> pausePlayback();
  Future<AppResult<()>> stopPlayback();
  Stream<AppResult<Duration>> watchPlaybackPosition();
  Stream<AppResult<()>> watchPlaybackFinished();
  Future<AppResult<()>> dispose();
}
