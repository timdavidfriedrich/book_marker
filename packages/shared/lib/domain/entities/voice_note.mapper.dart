// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
// ignore_for_file: type=lint
// ignore_for_file: invalid_use_of_protected_member
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'voice_note.dart';

class VoiceNoteMapper extends ClassMapperBase<VoiceNote> {
  VoiceNoteMapper._();

  static VoiceNoteMapper? _instance;
  static VoiceNoteMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = VoiceNoteMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'VoiceNote';

  static String _$path(VoiceNote v) => v.path;
  static const Field<VoiceNote, String> _f$path = Field('path', _$path);
  static int _$durationMs(VoiceNote v) => v.durationMs;
  static const Field<VoiceNote, int> _f$durationMs = Field(
    'durationMs',
    _$durationMs,
  );

  @override
  final MappableFields<VoiceNote> fields = const {
    #path: _f$path,
    #durationMs: _f$durationMs,
  };

  static VoiceNote _instantiate(DecodingData data) {
    return VoiceNote(
      path: data.dec(_f$path),
      durationMs: data.dec(_f$durationMs),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static VoiceNote fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<VoiceNote>(map);
  }

  static VoiceNote fromJson(String json) {
    return ensureInitialized().decodeJson<VoiceNote>(json);
  }
}

mixin VoiceNoteMappable {
  String toJson() {
    return VoiceNoteMapper.ensureInitialized().encodeJson<VoiceNote>(
      this as VoiceNote,
    );
  }

  Map<String, dynamic> toMap() {
    return VoiceNoteMapper.ensureInitialized().encodeMap<VoiceNote>(
      this as VoiceNote,
    );
  }

  VoiceNoteCopyWith<VoiceNote, VoiceNote, VoiceNote> get copyWith =>
      _VoiceNoteCopyWithImpl<VoiceNote, VoiceNote>(
        this as VoiceNote,
        $identity,
        $identity,
      );
  @override
  String toString() {
    return VoiceNoteMapper.ensureInitialized().stringifyValue(
      this as VoiceNote,
    );
  }

  @override
  bool operator ==(Object other) {
    return VoiceNoteMapper.ensureInitialized().equalsValue(
      this as VoiceNote,
      other,
    );
  }

  @override
  int get hashCode {
    return VoiceNoteMapper.ensureInitialized().hashValue(this as VoiceNote);
  }
}

extension VoiceNoteValueCopy<$R, $Out> on ObjectCopyWith<$R, VoiceNote, $Out> {
  VoiceNoteCopyWith<$R, VoiceNote, $Out> get $asVoiceNote =>
      $base.as((v, t, t2) => _VoiceNoteCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class VoiceNoteCopyWith<$R, $In extends VoiceNote, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call({String? path, int? durationMs});
  VoiceNoteCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _VoiceNoteCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, VoiceNote, $Out>
    implements VoiceNoteCopyWith<$R, VoiceNote, $Out> {
  _VoiceNoteCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<VoiceNote> $mapper =
      VoiceNoteMapper.ensureInitialized();
  @override
  $R call({String? path, int? durationMs}) => $apply(
    FieldCopyWithData({
      if (path != null) #path: path,
      if (durationMs != null) #durationMs: durationMs,
    }),
  );
  @override
  VoiceNote $make(CopyWithData data) => VoiceNote(
    path: data.get(#path, or: $value.path),
    durationMs: data.get(#durationMs, or: $value.durationMs),
  );

  @override
  VoiceNoteCopyWith<$R2, VoiceNote, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _VoiceNoteCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

