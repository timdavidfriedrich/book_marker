import 'package:core/error/app_error.dart';
import 'package:core/error/app_result.dart';
import 'package:injectable/injectable.dart';
import 'package:shared/data/data_sources/image_storage_data_source.dart';
import 'package:shared/data/data_sources/quote_local_data_source.dart';
import 'package:shared/data/mappers/quote_mappers.dart';
import 'package:shared/domain/entities/quote.dart';
import 'package:shared/domain/entities/quote_page.dart';
import 'package:shared/domain/entities/voice_note.dart';
import 'package:shared/domain/repositories/quote_repository.dart';

@Injectable(as: QuoteRepository)
class const QuoteRepositoryImpl(
  final QuoteLocalDataSource _localDataSource,
  final ImageStorageDataSource _imageStorageDataSource,
) implements QuoteRepository {
  @override
  Stream<AppResult<List<Quote>>> watchQuotes() async* {
    try {
      yield* _localDataSource.watchQuotes().map<AppResult<List<Quote>>>(
        (rows) => Success(rows.map((it) => it.toQuote()).toList()),
      );
    } on Object {
      yield const Failure(UnexpectedError());
    }
  }

  @override
  Future<AppResult<Quote>> getQuote(String id) async {
    try {
      final localQuote = await _localDataSource.readQuote(id);
      if (localQuote == null) return const Failure(NotFoundError());
      return Success(localQuote.toQuote());
    } on Object {
      return const Failure(UnexpectedError());
    }
  }

  @override
  Future<AppResult<()>> saveQuote(Quote quote) async {
    try {
      final storedPages = <QuotePage>[];
      for (final (index, page) in quote.pages.indexed) {
        final storedPath = await _imageStorageDataSource.persistImage(
          page.photoPath,
          "${quote.id}_$index",
        );
        storedPages.add(page.copyWith(photoPath: storedPath));
      }
      await _localDataSource.insertQuote(quote.copyWith(pages: storedPages).toLocalQuote());
      return const Success(());
    } on Object {
      return const Failure(UnexpectedError());
    }
  }

  @override
  Future<AppResult<()>> setFavorite(String id, {required bool isFavorite}) async {
    try {
      await _localDataSource.setFavorite(id, isFavorite: isFavorite);
      return const Success(());
    } on Object {
      return const Failure(UnexpectedError());
    }
  }

  @override
  Future<AppResult<()>> setNote(String id, String? note) async {
    try {
      await _localDataSource.setNote(id, note);
      return const Success(());
    } on Object {
      return const Failure(UnexpectedError());
    }
  }

  @override
  Future<AppResult<()>> setPageNumbers(String id, List<int> pageNumbers) async {
    try {
      await _localDataSource.setPageNumbers(id, pageNumbers);
      return const Success(());
    } on Object {
      return const Failure(UnexpectedError());
    }
  }

  @override
  Future<AppResult<()>> setVoiceNote(String id, VoiceNote? voiceNote) async {
    try {
      await _localDataSource.setVoiceNote(id, voiceNote?.path, voiceNote?.durationMs);
      return const Success(());
    } on Object {
      return const Failure(UnexpectedError());
    }
  }

  @override
  Future<AppResult<()>> deleteQuote(String id) async {
    try {
      final localQuote = await _localDataSource.readQuote(id);
      await _localDataSource.deleteQuote(id);
      for (final page in localQuote?.pages ?? const <QuotePage>[]) {
        await _imageStorageDataSource.deleteImage(page.photoPath);
      }
      return const Success(());
    } on Object {
      return const Failure(UnexpectedError());
    }
  }
}
