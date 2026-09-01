import 'package:dart_mappable/dart_mappable.dart';

part 'voice_note.mapper.dart';

@MappableClass()
class const VoiceNote({
  required final String path,
  required final int durationMs,
}) with VoiceNoteMappable;
