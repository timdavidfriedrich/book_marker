import 'package:drift/drift.dart';
import 'package:injectable/injectable.dart';
import 'package:shared/data/database/app_database.dart';
import 'package:shared/data/database/cipher_codec.dart';
import 'package:shared/data/database/row_defaults.dart';
import 'package:shared/data/database/timestamp_codec.dart';
import 'package:shared/data/models/local_book.dart';

const _thumbnailUrlKey = "thumbnailUrl";
const _coverPathKey = "coverPath";

abstract class BookLocalDataSource {
  Stream<List<LocalBook>> watchBooks();

  Future<List<LocalBook>> readBooks();

  Future<LocalBook?> readBook(String id);

  Future<void> upsertBook(LocalBook book);

  Future<void> touchBook(String id, DateTime lastUsedAt);

  Future<void> setStatus(String id, String status);

  Future<void> deleteBook(String id);
}

@Injectable(as: BookLocalDataSource)
class const BookLocalDataSourceImpl(
  final AppDatabase _database,
  final CipherCodec _codec,
) implements BookLocalDataSource {
  @override
  Stream<List<LocalBook>> watchBooks() {
    final query = _database.select(_database.books)
      ..orderBy([(table) => OrderingTerm.desc(table.lastUsedAt)]);
    return query.watch().asyncMap(_decodeAll);
  }

  @override
  Future<List<LocalBook>> readBooks() async =>
      _decodeAll(await _database.select(_database.books).get());

  @override
  Future<LocalBook?> readBook(String id) async {
    final query = _database.select(_database.books)..where((table) => table.id.equals(id));
    final row = await query.getSingleOrNull();
    return row == null ? null : _decode(row);
  }

  @override
  Future<void> upsertBook(LocalBook book) async =>
      _database.upsert(_database.books, await _encode(book));

  @override
  Future<void> touchBook(String id, DateTime lastUsedAt) {
    final statement = _database.update(_database.books)..where((table) => table.id.equals(id));
    return statement.write(
      BooksCompanion(
        lastUsedAt: Value(encodeTimestamp(lastUsedAt)),
        updatedAt: Value(encodeTimestamp(DateTime.now())),
      ),
    );
  }

  @override
  Future<void> setStatus(String id, String status) {
    final statement = _database.update(_database.books)..where((table) => table.id.equals(id));
    return statement.write(
      BooksCompanion(
        status: Value(status),
        updatedAt: Value(encodeTimestamp(DateTime.now())),
      ),
    );
  }

  @override
  Future<void> deleteBook(String id) =>
      (_database.delete(_database.books)..where((table) => table.id.equals(id))).go();

  Future<List<LocalBook>> _decodeAll(List<BookRow> rows) => Future.wait(rows.map(_decode));

  Future<LocalBook> _decode(BookRow row) async {
    final cover = await _codec.decodeOptionalMap(row.coverCipher);
    return LocalBook(
      id: row.id,
      title: await _codec.decode(row.titleCipher),
      authors: await _codec.decodeList(row.authorsCipher, (it) => it! as String),
      isbn: await _codec.decodeOptional(row.isbnCipher),
      thumbnailUrl: cover?[_thumbnailUrlKey] as String?,
      coverPath: cover?[_coverPathKey] as String?,
      status: row.status,
      createdAt: decodeTimestamp(row.createdAt),
      lastUsedAt: decodeTimestamp(row.lastUsedAt),
    );
  }

  Future<BooksCompanion> _encode(LocalBook book) async {
    final hasCover = book.thumbnailUrl != null || book.coverPath != null;
    return BooksCompanion.insert(
      id: book.id,
      ownerId: unownedRow,
      status: book.status,
      createdAt: encodeTimestamp(book.createdAt),
      lastUsedAt: encodeTimestamp(book.lastUsedAt),
      updatedAt: encodeTimestamp(DateTime.now()),
      keyVersion: currentKeyVersion,
      titleCipher: await _codec.encode(book.title),
      authorsCipher: await _codec.encodeJson(book.authors),
      isbnCipher: Value(await _codec.encodeOptional(book.isbn)),
      coverCipher: Value(
        await _codec.encodeOptionalJson(
          hasCover ? {_thumbnailUrlKey: book.thumbnailUrl, _coverPathKey: book.coverPath} : null,
        ),
      ),
    );
  }
}
