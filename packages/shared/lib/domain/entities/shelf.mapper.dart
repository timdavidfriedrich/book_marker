// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
// ignore_for_file: type=lint
// ignore_for_file: invalid_use_of_protected_member
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'shelf.dart';

class ShelfMapper extends ClassMapperBase<Shelf> {
  ShelfMapper._();

  static ShelfMapper? _instance;
  static ShelfMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = ShelfMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'Shelf';

  static String _$id(Shelf v) => v.id;
  static const Field<Shelf, String> _f$id = Field('id', _$id);
  static String _$name(Shelf v) => v.name;
  static const Field<Shelf, String> _f$name = Field('name', _$name);
  static DateTime _$createdAt(Shelf v) => v.createdAt;
  static const Field<Shelf, DateTime> _f$createdAt = Field(
    'createdAt',
    _$createdAt,
  );
  static AccentColor _$accent(Shelf v) => v.accent;
  static const Field<Shelf, AccentColor> _f$accent = Field('accent', _$accent);
  static CollectionSymbol _$symbol(Shelf v) => v.symbol;
  static const Field<Shelf, CollectionSymbol> _f$symbol = Field(
    'symbol',
    _$symbol,
  );

  @override
  final MappableFields<Shelf> fields = const {
    #id: _f$id,
    #name: _f$name,
    #createdAt: _f$createdAt,
    #accent: _f$accent,
    #symbol: _f$symbol,
  };

  static Shelf _instantiate(DecodingData data) {
    return Shelf(
      id: data.dec(_f$id),
      name: data.dec(_f$name),
      createdAt: data.dec(_f$createdAt),
      accent: data.dec(_f$accent),
      symbol: data.dec(_f$symbol),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static Shelf fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<Shelf>(map);
  }

  static Shelf fromJson(String json) {
    return ensureInitialized().decodeJson<Shelf>(json);
  }
}

mixin ShelfMappable {
  String toJson() {
    return ShelfMapper.ensureInitialized().encodeJson<Shelf>(this as Shelf);
  }

  Map<String, dynamic> toMap() {
    return ShelfMapper.ensureInitialized().encodeMap<Shelf>(this as Shelf);
  }

  ShelfCopyWith<Shelf, Shelf, Shelf> get copyWith =>
      _ShelfCopyWithImpl<Shelf, Shelf>(this as Shelf, $identity, $identity);
  @override
  String toString() {
    return ShelfMapper.ensureInitialized().stringifyValue(this as Shelf);
  }

  @override
  bool operator ==(Object other) {
    return ShelfMapper.ensureInitialized().equalsValue(this as Shelf, other);
  }

  @override
  int get hashCode {
    return ShelfMapper.ensureInitialized().hashValue(this as Shelf);
  }
}

extension ShelfValueCopy<$R, $Out> on ObjectCopyWith<$R, Shelf, $Out> {
  ShelfCopyWith<$R, Shelf, $Out> get $asShelf =>
      $base.as((v, t, t2) => _ShelfCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class ShelfCopyWith<$R, $In extends Shelf, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call({
    String? id,
    String? name,
    DateTime? createdAt,
    AccentColor? accent,
    CollectionSymbol? symbol,
  });
  ShelfCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _ShelfCopyWithImpl<$R, $Out> extends ClassCopyWithBase<$R, Shelf, $Out>
    implements ShelfCopyWith<$R, Shelf, $Out> {
  _ShelfCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<Shelf> $mapper = ShelfMapper.ensureInitialized();
  @override
  $R call({
    String? id,
    String? name,
    DateTime? createdAt,
    AccentColor? accent,
    CollectionSymbol? symbol,
  }) => $apply(
    FieldCopyWithData({
      if (id != null) #id: id,
      if (name != null) #name: name,
      if (createdAt != null) #createdAt: createdAt,
      if (accent != null) #accent: accent,
      if (symbol != null) #symbol: symbol,
    }),
  );
  @override
  Shelf $make(CopyWithData data) => Shelf(
    id: data.get(#id, or: $value.id),
    name: data.get(#name, or: $value.name),
    createdAt: data.get(#createdAt, or: $value.createdAt),
    accent: data.get(#accent, or: $value.accent),
    symbol: data.get(#symbol, or: $value.symbol),
  );

  @override
  ShelfCopyWith<$R2, Shelf, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
      _ShelfCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

