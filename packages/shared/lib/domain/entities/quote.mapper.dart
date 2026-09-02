// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
// ignore_for_file: type=lint
// ignore_for_file: invalid_use_of_protected_member
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'quote.dart';

class QuoteMapper extends ClassMapperBase<Quote> {
  QuoteMapper._();

  static QuoteMapper? _instance;
  static QuoteMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = QuoteMapper._());
      QuotePageMapper.ensureInitialized();
      RecognizedWordMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'Quote';

  static String _$id(Quote v) => v.id;
  static const Field<Quote, String> _f$id = Field('id', _$id);
  static String _$bookId(Quote v) => v.bookId;
  static const Field<Quote, String> _f$bookId = Field('bookId', _$bookId);
  static List<int> _$pageNumbers(Quote v) => v.pageNumbers;
  static const Field<Quote, List<int>> _f$pageNumbers = Field(
    'pageNumbers',
    _$pageNumbers,
  );
  static String _$quote(Quote v) => v.quote;
  static const Field<Quote, String> _f$quote = Field('quote', _$quote);
  static String? _$note(Quote v) => v.note;
  static const Field<Quote, String> _f$note = Field('note', _$note);
  static String? _$voiceNotePath(Quote v) => v.voiceNotePath;
  static const Field<Quote, String> _f$voiceNotePath = Field(
    'voiceNotePath',
    _$voiceNotePath,
  );
  static int? _$voiceNoteDurationMs(Quote v) => v.voiceNoteDurationMs;
  static const Field<Quote, int> _f$voiceNoteDurationMs = Field(
    'voiceNoteDurationMs',
    _$voiceNoteDurationMs,
  );
  static List<QuotePage> _$pages(Quote v) => v.pages;
  static const Field<Quote, List<QuotePage>> _f$pages = Field('pages', _$pages);
  static bool _$isFavorite(Quote v) => v.isFavorite;
  static const Field<Quote, bool> _f$isFavorite = Field(
    'isFavorite',
    _$isFavorite,
  );
  static DateTime _$createdAt(Quote v) => v.createdAt;
  static const Field<Quote, DateTime> _f$createdAt = Field(
    'createdAt',
    _$createdAt,
  );
  static List<RecognizedWord> _$words(Quote v) => v.words;
  static const Field<Quote, List<RecognizedWord>> _f$words = Field(
    'words',
    _$words,
    opt: true,
    def: const [],
  );
  static List<int> _$markedWordIndexes(Quote v) => v.markedWordIndexes;
  static const Field<Quote, List<int>> _f$markedWordIndexes = Field(
    'markedWordIndexes',
    _$markedWordIndexes,
    opt: true,
    def: const [],
  );

  @override
  final MappableFields<Quote> fields = const {
    #id: _f$id,
    #bookId: _f$bookId,
    #pageNumbers: _f$pageNumbers,
    #quote: _f$quote,
    #note: _f$note,
    #voiceNotePath: _f$voiceNotePath,
    #voiceNoteDurationMs: _f$voiceNoteDurationMs,
    #pages: _f$pages,
    #isFavorite: _f$isFavorite,
    #createdAt: _f$createdAt,
    #words: _f$words,
    #markedWordIndexes: _f$markedWordIndexes,
  };

  static Quote _instantiate(DecodingData data) {
    return Quote(
      id: data.dec(_f$id),
      bookId: data.dec(_f$bookId),
      pageNumbers: data.dec(_f$pageNumbers),
      quote: data.dec(_f$quote),
      note: data.dec(_f$note),
      voiceNotePath: data.dec(_f$voiceNotePath),
      voiceNoteDurationMs: data.dec(_f$voiceNoteDurationMs),
      pages: data.dec(_f$pages),
      isFavorite: data.dec(_f$isFavorite),
      createdAt: data.dec(_f$createdAt),
      words: data.dec(_f$words),
      markedWordIndexes: data.dec(_f$markedWordIndexes),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static Quote fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<Quote>(map);
  }

  static Quote fromJson(String json) {
    return ensureInitialized().decodeJson<Quote>(json);
  }
}

mixin QuoteMappable {
  String toJson() {
    return QuoteMapper.ensureInitialized().encodeJson<Quote>(this as Quote);
  }

  Map<String, dynamic> toMap() {
    return QuoteMapper.ensureInitialized().encodeMap<Quote>(this as Quote);
  }

  QuoteCopyWith<Quote, Quote, Quote> get copyWith =>
      _QuoteCopyWithImpl<Quote, Quote>(this as Quote, $identity, $identity);
  @override
  String toString() {
    return QuoteMapper.ensureInitialized().stringifyValue(this as Quote);
  }

  @override
  bool operator ==(Object other) {
    return QuoteMapper.ensureInitialized().equalsValue(this as Quote, other);
  }

  @override
  int get hashCode {
    return QuoteMapper.ensureInitialized().hashValue(this as Quote);
  }
}

extension QuoteValueCopy<$R, $Out> on ObjectCopyWith<$R, Quote, $Out> {
  QuoteCopyWith<$R, Quote, $Out> get $asQuote =>
      $base.as((v, t, t2) => _QuoteCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class QuoteCopyWith<$R, $In extends Quote, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  ListCopyWith<$R, int, ObjectCopyWith<$R, int, int>> get pageNumbers;
  ListCopyWith<$R, QuotePage, QuotePageCopyWith<$R, QuotePage, QuotePage>>
  get pages;
  ListCopyWith<
    $R,
    RecognizedWord,
    RecognizedWordCopyWith<$R, RecognizedWord, RecognizedWord>
  >
  get words;
  ListCopyWith<$R, int, ObjectCopyWith<$R, int, int>> get markedWordIndexes;
  $R call({
    String? id,
    String? bookId,
    List<int>? pageNumbers,
    String? quote,
    String? note,
    String? voiceNotePath,
    int? voiceNoteDurationMs,
    List<QuotePage>? pages,
    bool? isFavorite,
    DateTime? createdAt,
    List<RecognizedWord>? words,
    List<int>? markedWordIndexes,
  });
  QuoteCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _QuoteCopyWithImpl<$R, $Out> extends ClassCopyWithBase<$R, Quote, $Out>
    implements QuoteCopyWith<$R, Quote, $Out> {
  _QuoteCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<Quote> $mapper = QuoteMapper.ensureInitialized();
  @override
  ListCopyWith<$R, int, ObjectCopyWith<$R, int, int>> get pageNumbers =>
      ListCopyWith(
        $value.pageNumbers,
        (v, t) => ObjectCopyWith(v, $identity, t),
        (v) => call(pageNumbers: v),
      );
  @override
  ListCopyWith<$R, QuotePage, QuotePageCopyWith<$R, QuotePage, QuotePage>>
  get pages => ListCopyWith(
    $value.pages,
    (v, t) => v.copyWith.$chain(t),
    (v) => call(pages: v),
  );
  @override
  ListCopyWith<
    $R,
    RecognizedWord,
    RecognizedWordCopyWith<$R, RecognizedWord, RecognizedWord>
  >
  get words => ListCopyWith(
    $value.words,
    (v, t) => v.copyWith.$chain(t),
    (v) => call(words: v),
  );
  @override
  ListCopyWith<$R, int, ObjectCopyWith<$R, int, int>> get markedWordIndexes =>
      ListCopyWith(
        $value.markedWordIndexes,
        (v, t) => ObjectCopyWith(v, $identity, t),
        (v) => call(markedWordIndexes: v),
      );
  @override
  $R call({
    String? id,
    String? bookId,
    List<int>? pageNumbers,
    String? quote,
    Object? note = $none,
    Object? voiceNotePath = $none,
    Object? voiceNoteDurationMs = $none,
    List<QuotePage>? pages,
    bool? isFavorite,
    DateTime? createdAt,
    List<RecognizedWord>? words,
    List<int>? markedWordIndexes,
  }) => $apply(
    FieldCopyWithData({
      if (id != null) #id: id,
      if (bookId != null) #bookId: bookId,
      if (pageNumbers != null) #pageNumbers: pageNumbers,
      if (quote != null) #quote: quote,
      if (note != $none) #note: note,
      if (voiceNotePath != $none) #voiceNotePath: voiceNotePath,
      if (voiceNoteDurationMs != $none)
        #voiceNoteDurationMs: voiceNoteDurationMs,
      if (pages != null) #pages: pages,
      if (isFavorite != null) #isFavorite: isFavorite,
      if (createdAt != null) #createdAt: createdAt,
      if (words != null) #words: words,
      if (markedWordIndexes != null) #markedWordIndexes: markedWordIndexes,
    }),
  );
  @override
  Quote $make(CopyWithData data) => Quote(
    id: data.get(#id, or: $value.id),
    bookId: data.get(#bookId, or: $value.bookId),
    pageNumbers: data.get(#pageNumbers, or: $value.pageNumbers),
    quote: data.get(#quote, or: $value.quote),
    note: data.get(#note, or: $value.note),
    voiceNotePath: data.get(#voiceNotePath, or: $value.voiceNotePath),
    voiceNoteDurationMs: data.get(
      #voiceNoteDurationMs,
      or: $value.voiceNoteDurationMs,
    ),
    pages: data.get(#pages, or: $value.pages),
    isFavorite: data.get(#isFavorite, or: $value.isFavorite),
    createdAt: data.get(#createdAt, or: $value.createdAt),
    words: data.get(#words, or: $value.words),
    markedWordIndexes: data.get(
      #markedWordIndexes,
      or: $value.markedWordIndexes,
    ),
  );

  @override
  QuoteCopyWith<$R2, Quote, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
      _QuoteCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

