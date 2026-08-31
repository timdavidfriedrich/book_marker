import 'package:drift/drift.dart';
import 'package:injectable/injectable.dart';
import 'package:shared/data/database/app_database.dart';

abstract class QuoteLocalDataSource {
  Stream<List<LocalQuote>> watchQuotes();

  Future<LocalQuote?> readQuote(String id);

  Future<void> insertQuote(LocalQuote quote);

  Future<void> setFavorite(String id, {required bool isFavorite});

  Future<void> setNote(String id, String? note);

  Future<void> deleteQuote(String id);
}

@Injectable(as: QuoteLocalDataSource)
class const QuoteLocalDataSourceImpl(
  final AppDatabase _database,
) implements QuoteLocalDataSource {
  @override
  Stream<List<LocalQuote>> watchQuotes() {
    final query = _database.select(_database.quotes)
      ..orderBy([(table) => OrderingTerm.desc(table.createdAt)]);
    return query.watch();
  }

  @override
  Future<LocalQuote?> readQuote(String id) {
    final query = _database.select(_database.quotes)..where((table) => table.id.equals(id));
    return query.getSingleOrNull();
  }

  @override
  Future<void> insertQuote(LocalQuote quote) =>
      _database.into(_database.quotes).insertOnConflictUpdate(quote);

  @override
  Future<void> setFavorite(String id, {required bool isFavorite}) {
    final statement = _database.update(_database.quotes)..where((table) => table.id.equals(id));
    return statement.write(QuotesCompanion(isFavorite: Value(isFavorite)));
  }

  @override
  Future<void> setNote(String id, String? note) {
    final statement = _database.update(_database.quotes)..where((table) => table.id.equals(id));
    return statement.write(QuotesCompanion(note: Value(note)));
  }

  @override
  Future<void> deleteQuote(String id) =>
      (_database.delete(_database.quotes)..where((table) => table.id.equals(id))).go();
}
