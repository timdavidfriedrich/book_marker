import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';
import 'package:shared/data/database/converters.dart';
import 'package:shared/domain/entities/highlight_region.dart';

part 'app_database.g.dart';

const _databaseName = "book_marker";

@DataClassName("LocalBook")
class Books extends Table {
  TextColumn get id => text()();

  TextColumn get title => text()();

  TextColumn get authors => text().map(const StringListConverter())();

  TextColumn get isbn => text().nullable()();

  TextColumn get thumbnailUrl => text().nullable()();

  DateTimeColumn get createdAt => dateTime()();

  DateTimeColumn get lastUsedAt => dateTime()();

  @override
  Set<Column<Object>> get primaryKey => {id};
}

@DataClassName("LocalBookmark")
class Bookmarks extends Table {
  TextColumn get id => text()();

  TextColumn get bookId => text().references(Books, #id, onDelete: KeyAction.cascade)();

  IntColumn get pageNumber => integer().nullable()();

  TextColumn get quote => text()();

  TextColumn get photoPath => text()();

  RealColumn get imageAspectRatio => real()();

  TextColumn get highlights => text().map(const HighlightListConverter())();

  BoolColumn get isFavorite => boolean().withDefault(const Constant(false))();

  DateTimeColumn get createdAt => dateTime()();

  @override
  Set<Column<Object>> get primaryKey => {id};
}

@DriftDatabase(tables: [Books, Bookmarks])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(driftDatabase(name: _databaseName));

  @override
  int get schemaVersion => 1;
}
