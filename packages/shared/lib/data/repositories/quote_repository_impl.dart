import 'package:core/error/app_error.dart';
import 'package:core/error/app_result.dart';
import 'package:core/sync/attachment_service.dart';
import 'package:injectable/injectable.dart';
import 'package:shared/data/data_sources/quote_local_data_source.dart';
import 'package:shared/data/data_sources/theme_local_data_source.dart';
import 'package:shared/data/database/attachment_paths.dart';
import 'package:shared/data/mappers/quote_mappers.dart';
import 'package:shared/domain/entities/quote.dart';
import 'package:shared/domain/entities/quote_page.dart';
import 'package:shared/domain/entities/voice_note.dart';
import 'package:shared/domain/repositories/quote_repository.dart';

@Injectable(as: QuoteRepository)
class const QuoteRepositoryImpl(
  final QuoteLocalDataSource _localDataSource,
  final ThemeLocalDataSource _themeLocalDataSource,
  final AttachmentService _attachments,
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
      if (localQuote?.voiceNotePath case final path?) {
        await _attachments.discard(path);
      }
      if (localQuote == null) return const Failure(NotFoundError());
      return Success(localQuote.toQuote());
    } on Object {
      return const Failure(UnexpectedError());
    }
  }

  @override
  Future<AppResult<()>> saveQuote(Quote quote) async {
    try {
      // * the attachment service names the file, not the quote. An id it minted
      // * is the same on every device; a name built from the quote id would be
      // * a second, weaker identity for the same bytes
      final storedPages = <QuotePage>[];
      for (final page in quote.pages) {
        storedPages.add(
          page.copyWith(
            photoPath: await _attachments.adopt(page.photoPath, photoExtension),
          ),
        );
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
  Future<AppResult<()>> setQuote(String id, String quote) async {
    try {
      await _localDataSource.setQuote(id, quote);
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
      // * the recorder writes wherever it likes; adopting moves the file into
      // * attachment storage and queues it, exactly as a page photograph is
      final previous = await _localDataSource.readQuote(id);
      final path = voiceNote == null
          ? null
          : await _attachments.adopt(voiceNote.path, voiceNoteExtension);
      await _localDataSource.setVoiceNote(id, path, voiceNote?.durationMs);
      if (previous?.voiceNotePath case final replaced?) {
        await _attachments.discard(replaced);
      }
      return const Success(());
    } on Object {
      return const Failure(UnexpectedError());
    }
  }

  @override
  Future<AppResult<()>> deleteQuote(String id) async {
    try {
      final localQuote = await _localDataSource.readQuote(id);
      if (localQuote?.voiceNotePath case final path?) {
        await _attachments.discard(path);
      }
      // * no foreign key cascades from a PowerSync view, so the theme links go
      // * here or they outlive the quote and sync as orphans
      await _themeLocalDataSource.removeQuoteEverywhere(id);
      await _localDataSource.deleteQuote(id);
      for (final page in localQuote?.pages ?? const <QuotePage>[]) {
        await _attachments.discard(page.photoPath);
      }
      return const Success(());
    } on Object {
      return const Failure(UnexpectedError());
    }
  }
}
