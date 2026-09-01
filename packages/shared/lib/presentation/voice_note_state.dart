import 'package:core/error/app_error.dart';
import 'package:shared/domain/entities/voice_note.dart';

sealed class VoiceNoteState {
  const VoiceNoteState();
}

class const VoiceNoteIdle() extends VoiceNoteState;

class const VoiceNoteRecording({
  required final Duration elapsed,
}) extends VoiceNoteState;

class const VoiceNoteRecorded({
  required final VoiceNote voiceNote,
}) extends VoiceNoteState;

class const VoiceNotePlaying({
  required final String path,
  required final Duration position,
}) extends VoiceNoteState;

class const VoiceNoteFailure({
  required final AppError error,
}) extends VoiceNoteState;
