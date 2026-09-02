// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
// ignore_for_file: type=lint
// ignore_for_file: invalid_use_of_protected_member
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'recognized_word.dart';

class RecognizedWordMapper extends ClassMapperBase<RecognizedWord> {
  RecognizedWordMapper._();

  static RecognizedWordMapper? _instance;
  static RecognizedWordMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = RecognizedWordMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'RecognizedWord';

  static String _$text(RecognizedWord v) => v.text;
  static const Field<RecognizedWord, String> _f$text = Field('text', _$text);
  static double _$left(RecognizedWord v) => v.left;
  static const Field<RecognizedWord, double> _f$left = Field('left', _$left);
  static double _$top(RecognizedWord v) => v.top;
  static const Field<RecognizedWord, double> _f$top = Field('top', _$top);
  static double _$width(RecognizedWord v) => v.width;
  static const Field<RecognizedWord, double> _f$width = Field('width', _$width);
  static double _$height(RecognizedWord v) => v.height;
  static const Field<RecognizedWord, double> _f$height = Field(
    'height',
    _$height,
  );
  static int _$lineIndex(RecognizedWord v) => v.lineIndex;
  static const Field<RecognizedWord, int> _f$lineIndex = Field(
    'lineIndex',
    _$lineIndex,
  );
  static int _$pageIndex(RecognizedWord v) => v.pageIndex;
  static const Field<RecognizedWord, int> _f$pageIndex = Field(
    'pageIndex',
    _$pageIndex,
  );
  static double? _$confidence(RecognizedWord v) => v.confidence;
  static const Field<RecognizedWord, double> _f$confidence = Field(
    'confidence',
    _$confidence,
  );
  static bool _$isUncertain(RecognizedWord v) => v.isUncertain;
  static const Field<RecognizedWord, bool> _f$isUncertain = Field(
    'isUncertain',
    _$isUncertain,
  );
  static bool _$joinsWithNext(RecognizedWord v) => v.joinsWithNext;
  static const Field<RecognizedWord, bool> _f$joinsWithNext = Field(
    'joinsWithNext',
    _$joinsWithNext,
  );
  static List<String> _$suggestions(RecognizedWord v) => v.suggestions;
  static const Field<RecognizedWord, List<String>> _f$suggestions = Field(
    'suggestions',
    _$suggestions,
    opt: true,
    def: const [],
  );

  @override
  final MappableFields<RecognizedWord> fields = const {
    #text: _f$text,
    #left: _f$left,
    #top: _f$top,
    #width: _f$width,
    #height: _f$height,
    #lineIndex: _f$lineIndex,
    #pageIndex: _f$pageIndex,
    #confidence: _f$confidence,
    #isUncertain: _f$isUncertain,
    #joinsWithNext: _f$joinsWithNext,
    #suggestions: _f$suggestions,
  };

  static RecognizedWord _instantiate(DecodingData data) {
    return RecognizedWord(
      text: data.dec(_f$text),
      left: data.dec(_f$left),
      top: data.dec(_f$top),
      width: data.dec(_f$width),
      height: data.dec(_f$height),
      lineIndex: data.dec(_f$lineIndex),
      pageIndex: data.dec(_f$pageIndex),
      confidence: data.dec(_f$confidence),
      isUncertain: data.dec(_f$isUncertain),
      joinsWithNext: data.dec(_f$joinsWithNext),
      suggestions: data.dec(_f$suggestions),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static RecognizedWord fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<RecognizedWord>(map);
  }

  static RecognizedWord fromJson(String json) {
    return ensureInitialized().decodeJson<RecognizedWord>(json);
  }
}

mixin RecognizedWordMappable {
  String toJson() {
    return RecognizedWordMapper.ensureInitialized().encodeJson<RecognizedWord>(
      this as RecognizedWord,
    );
  }

  Map<String, dynamic> toMap() {
    return RecognizedWordMapper.ensureInitialized().encodeMap<RecognizedWord>(
      this as RecognizedWord,
    );
  }

  RecognizedWordCopyWith<RecognizedWord, RecognizedWord, RecognizedWord>
  get copyWith => _RecognizedWordCopyWithImpl<RecognizedWord, RecognizedWord>(
    this as RecognizedWord,
    $identity,
    $identity,
  );
  @override
  String toString() {
    return RecognizedWordMapper.ensureInitialized().stringifyValue(
      this as RecognizedWord,
    );
  }

  @override
  bool operator ==(Object other) {
    return RecognizedWordMapper.ensureInitialized().equalsValue(
      this as RecognizedWord,
      other,
    );
  }

  @override
  int get hashCode {
    return RecognizedWordMapper.ensureInitialized().hashValue(
      this as RecognizedWord,
    );
  }
}

extension RecognizedWordValueCopy<$R, $Out>
    on ObjectCopyWith<$R, RecognizedWord, $Out> {
  RecognizedWordCopyWith<$R, RecognizedWord, $Out> get $asRecognizedWord =>
      $base.as((v, t, t2) => _RecognizedWordCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class RecognizedWordCopyWith<$R, $In extends RecognizedWord, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  ListCopyWith<$R, String, ObjectCopyWith<$R, String, String>> get suggestions;
  $R call({
    String? text,
    double? left,
    double? top,
    double? width,
    double? height,
    int? lineIndex,
    int? pageIndex,
    double? confidence,
    bool? isUncertain,
    bool? joinsWithNext,
    List<String>? suggestions,
  });
  RecognizedWordCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  );
}

class _RecognizedWordCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, RecognizedWord, $Out>
    implements RecognizedWordCopyWith<$R, RecognizedWord, $Out> {
  _RecognizedWordCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<RecognizedWord> $mapper =
      RecognizedWordMapper.ensureInitialized();
  @override
  ListCopyWith<$R, String, ObjectCopyWith<$R, String, String>>
  get suggestions => ListCopyWith(
    $value.suggestions,
    (v, t) => ObjectCopyWith(v, $identity, t),
    (v) => call(suggestions: v),
  );
  @override
  $R call({
    String? text,
    double? left,
    double? top,
    double? width,
    double? height,
    int? lineIndex,
    int? pageIndex,
    Object? confidence = $none,
    bool? isUncertain,
    bool? joinsWithNext,
    List<String>? suggestions,
  }) => $apply(
    FieldCopyWithData({
      if (text != null) #text: text,
      if (left != null) #left: left,
      if (top != null) #top: top,
      if (width != null) #width: width,
      if (height != null) #height: height,
      if (lineIndex != null) #lineIndex: lineIndex,
      if (pageIndex != null) #pageIndex: pageIndex,
      if (confidence != $none) #confidence: confidence,
      if (isUncertain != null) #isUncertain: isUncertain,
      if (joinsWithNext != null) #joinsWithNext: joinsWithNext,
      if (suggestions != null) #suggestions: suggestions,
    }),
  );
  @override
  RecognizedWord $make(CopyWithData data) => RecognizedWord(
    text: data.get(#text, or: $value.text),
    left: data.get(#left, or: $value.left),
    top: data.get(#top, or: $value.top),
    width: data.get(#width, or: $value.width),
    height: data.get(#height, or: $value.height),
    lineIndex: data.get(#lineIndex, or: $value.lineIndex),
    pageIndex: data.get(#pageIndex, or: $value.pageIndex),
    confidence: data.get(#confidence, or: $value.confidence),
    isUncertain: data.get(#isUncertain, or: $value.isUncertain),
    joinsWithNext: data.get(#joinsWithNext, or: $value.joinsWithNext),
    suggestions: data.get(#suggestions, or: $value.suggestions),
  );

  @override
  RecognizedWordCopyWith<$R2, RecognizedWord, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _RecognizedWordCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

