import 'package:drift/drift.dart';
import 'package:injectable/injectable.dart';
import 'package:shared/data/database/app_database.dart';
import 'package:shared/data/database/cipher_codec.dart';
import 'package:shared/data/database/row_defaults.dart';
import 'package:shared/data/database/timestamp_codec.dart';
import 'package:shared/data/models/local_quote.dart';
import 'package:shared/domain/entities/quote_page.dart';
import 'package:shared/domain/entities/recognized_word.dart';

const _voiceNotePathKey = "path";
const _voiceNoteDurationKey = "durationMs";
const _favorite = 1;
const _notFavorite = 0;

abstract class QuoteLocalDataSource {
  Stream<List<LocalQuote>> watchQuotes();

  Future<LocalQuote?> readQuote(String id);

  Future<void> insertQuote(LocalQuote quote);

  Future<void> setFavorite(String id, {required bool isFavorite});

  Future<void> setQuote(String id, String quote);

  Future<void> setNote(String id, String? note);

  Future<void> setPageNumbers(String id, List<int> pageNumbers);

  Future<void> setVoiceNote(String id, String? path, int? durationMs);

  Future<void> deleteQuote(String id);
}

@Injectable(as: QuoteLocalDataSource)
class const QuoteLocalDataSourceImpl(
  final AppDatabase _database,
  final CipherCodec _codec,
) implements QuoteLocalDataSource {
  @override
  Stream<List<LocalQuote>> watchQuotes() {
    final query = _database.select(_database.quotes)
      ..orderBy([(table) => OrderingTerm.desc(table.createdAt)]);
    return query.watch().asyncMap((rows) => Future.wait(rows.map(_decode)));
  }

  @override
  Future<LocalQuote?> readQuote(String id) async {
    final query = _database.select(_database.quotes)..where((table) => table.id.equals(id));
    final row = await query.getSingleOrNull();
    return row == null ? null : _decode(row);
  }

  @override
  Future<void> insertQuote(LocalQuote quote) async =>
      _database.upsert(_database.quotes, await _encode(quote));

  @override
  Future<void> setFavorite(String id, {required bool isFavorite}) =>
      _write(id, QuotesCompanion(isFavorite: Value(isFavorite ? _favorite : _notFavorite)));

  @override
  Future<void> setQuote(String id, String quote) async =>
      _write(id, QuotesCompanion(quoteCipher: Value(await _codec.encode(quote))));

  @override
  Future<void> setNote(String id, String? note) async =>
      _write(id, QuotesCompanion(noteCipher: Value(await _codec.encodeOptional(note))));

  @override
  Future<void> setPageNumbers(String id, List<int> pageNumbers) async => _write(
    id,
    QuotesCompanion(pageNumbersCipher: Value(await _codec.encodeJson(pageNumbers))),
  );

  @override
  Future<void> setVoiceNote(String id, String? path, int? durationMs) async => _write(
    id,
    QuotesCompanion(
      voiceNoteCipher: Value(await _encodeVoiceNote(path, durationMs)),
    ),
  );

  @override
  Future<void> deleteQuote(String id) =>
      (_database.delete(_database.quotes)..where((table) => table.id.equals(id))).go();

  // * every write stamps updatedAt, which is what tells a second device that
  // * this row moved
  Future<void> _write(String id, QuotesCompanion changes) {
    final statement = _database.update(_database.quotes)..where((table) => table.id.equals(id));
    return statement.write(
      changes.copyWith(updatedAt: Value(encodeTimestamp(DateTime.now()))),
    );
  }

  Future<LocalQuote> _decode(QuoteRow row) async {
    final voiceNote = await _codec.decodeOptionalMap(row.voiceNoteCipher);
    return LocalQuote(
      id: row.id,
      bookId: row.bookId,
      pageNumbers: await _codec.decodeList(row.pageNumbersCipher, (it) => it! as int),
      quote: await _codec.decode(row.quoteCipher),
      note: await _codec.decodeOptional(row.noteCipher),
      voiceNotePath: voiceNote?[_voiceNotePathKey] as String?,
      voiceNoteDurationMs: voiceNote?[_voiceNoteDurationKey] as int?,
      pages: await _codec.decodeList(row.pagesCipher, _toQuotePage),
      words: await _codec.decodeList(row.wordsCipher, _toRecognizedWord),
      markedWordIndexes: await _codec.decodeList(
        row.markedWordIndexesCipher,
        (it) => it! as int,
      ),
      isFavorite: row.isFavorite == _favorite,
      createdAt: decodeTimestamp(row.createdAt),
    );
  }

  Future<QuotesCompanion> _encode(LocalQuote quote) async {
    return QuotesCompanion.insert(
      id: quote.id,
      ownerId: unownedRow,
      bookId: quote.bookId,
      isFavorite: quote.isFavorite ? _favorite : _notFavorite,
      createdAt: encodeTimestamp(quote.createdAt),
      updatedAt: encodeTimestamp(DateTime.now()),
      keyVersion: currentKeyVersion,
      quoteCipher: await _codec.encode(quote.quote),
      noteCipher: Value(await _codec.encodeOptional(quote.note)),
      pageNumbersCipher: await _codec.encodeJson(quote.pageNumbers),
      pagesCipher: await _codec.encodeJson(quote.pages.map((it) => it.toMap()).toList()),
      wordsCipher: await _codec.encodeJson(quote.words.map((it) => it.toMap()).toList()),
      markedWordIndexesCipher: await _codec.encodeJson(quote.markedWordIndexes),
      voiceNoteCipher: Value(
        await _encodeVoiceNote(quote.voiceNotePath, quote.voiceNoteDurationMs),
      ),
    );
  }

  Future<String?> _encodeVoiceNote(String? path, int? durationMs) => _codec.encodeOptionalJson(
    path == null ? null : {_voiceNotePathKey: path, _voiceNoteDurationKey: durationMs},
  );
}

QuotePage _toQuotePage(Object? element) =>
    QuotePageMapper.fromMap((element! as Map<dynamic, dynamic>).cast<String, dynamic>());

RecognizedWord _toRecognizedWord(Object? element) =>
    RecognizedWordMapper.fromMap((element! as Map<dynamic, dynamic>).cast<String, dynamic>());
