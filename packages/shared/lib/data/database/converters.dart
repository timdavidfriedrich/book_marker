import 'dart:convert';

import 'package:drift/drift.dart';
import 'package:shared/domain/entities/quote_page.dart';
import 'package:shared/domain/entities/recognized_word.dart';

class StringListConverter extends TypeConverter<List<String>, String> {
  const StringListConverter();

  @override
  List<String> fromSql(String fromDb) =>
      (jsonDecode(fromDb) as List<dynamic>).map((it) => it as String).toList();

  @override
  String toSql(List<String> value) => jsonEncode(value);
}

class IntListConverter extends TypeConverter<List<int>, String> {
  const IntListConverter();

  @override
  List<int> fromSql(String fromDb) =>
      (jsonDecode(fromDb) as List<dynamic>).map((it) => it as int).toList();

  @override
  String toSql(List<int> value) => jsonEncode(value);
}

class QuotePageListConverter extends TypeConverter<List<QuotePage>, String> {
  const QuotePageListConverter();

  @override
  List<QuotePage> fromSql(String fromDb) => (jsonDecode(fromDb) as List<dynamic>)
      .map((it) => QuotePageMapper.fromMap((it as Map<dynamic, dynamic>).cast<String, dynamic>()))
      .toList();

  @override
  String toSql(List<QuotePage> value) => jsonEncode(value.map((it) => it.toMap()).toList());
}

class RecognizedWordListConverter extends TypeConverter<List<RecognizedWord>, String> {
  const RecognizedWordListConverter();

  @override
  List<RecognizedWord> fromSql(String fromDb) => (jsonDecode(fromDb) as List<dynamic>)
      .map(
        (it) => RecognizedWordMapper.fromMap((it as Map<dynamic, dynamic>).cast<String, dynamic>()),
      )
      .toList();

  @override
  String toSql(List<RecognizedWord> value) => jsonEncode(value.map((it) => it.toMap()).toList());
}
