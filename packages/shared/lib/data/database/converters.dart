import 'dart:convert';

import 'package:drift/drift.dart';
import 'package:shared/domain/entities/highlight_region.dart';

class StringListConverter extends TypeConverter<List<String>, String> {
  const StringListConverter();

  @override
  List<String> fromSql(String fromDb) =>
      (jsonDecode(fromDb) as List<dynamic>).map((it) => it as String).toList();

  @override
  String toSql(List<String> value) => jsonEncode(value);
}

class HighlightListConverter extends TypeConverter<List<HighlightRegion>, String> {
  const HighlightListConverter();

  @override
  List<HighlightRegion> fromSql(String fromDb) => (jsonDecode(fromDb) as List<dynamic>)
      .map(
        (it) =>
            HighlightRegionMapper.fromMap((it as Map<dynamic, dynamic>).cast<String, dynamic>()),
      )
      .toList();

  @override
  String toSql(List<HighlightRegion> value) => jsonEncode(value.map((it) => it.toMap()).toList());
}
