import 'package:core/error/app_error.dart';
import 'package:core/error/app_result.dart';
import 'package:core/theme/accent_color.dart';
import 'package:core/theme/collection_symbol.dart';
import 'package:core/theme/mark_defaults.dart';
import 'package:injectable/injectable.dart';
import 'package:shared/data/data_sources/theme_local_data_source.dart';
import 'package:shared/data/mappers/accent_mappers.dart';
import 'package:shared/data/mappers/collection_symbol_mappers.dart';
import 'package:shared/data/mappers/theme_mappers.dart';
import 'package:shared/domain/entities/quote_theme.dart';
import 'package:shared/domain/repositories/theme_repository.dart';
import 'package:uuid/uuid.dart';

const _uuid = Uuid();

@Injectable(as: ThemeRepository)
class const ThemeRepositoryImpl(
  final ThemeLocalDataSource _localDataSource,
) implements ThemeRepository {
  @override
  Stream<AppResult<List<QuoteTheme>>> watchThemes() async* {
    try {
      yield* _localDataSource.watchThemes().map<AppResult<List<QuoteTheme>>>(
        (rows) => Success(rows.map((it) => it.toQuoteTheme()).toList()),
      );
    } on Object {
      yield const Failure(UnexpectedError());
    }
  }

  @override
  Stream<AppResult<Map<String, Set<String>>>> watchThemeMembership() async* {
    try {
      yield* _localDataSource.watchThemeQuotes().map<AppResult<Map<String, Set<String>>>>((rows) {
        final membership = <String, Set<String>>{};
        for (final row in rows) {
          membership.putIfAbsent(row.themeId, () => <String>{}).add(row.quoteId);
        }
        return Success(membership);
      });
    } on Object {
      yield const Failure(UnexpectedError());
    }
  }

  @override
  Future<AppResult<QuoteTheme>> createTheme(String name) async {
    try {
      final existing = (await _localDataSource.loadThemes())
          .map((it) => it.toQuoteTheme())
          .toList();
      final theme = QuoteTheme(
        id: _uuid.v4(),
        name: name,
        createdAt: DateTime.now().toUtc(),
        accent: MarkDefaults.accentFor(existing.map((it) => it.accent)),
        symbol: MarkDefaults.symbolFor(existing.map((it) => it.symbol)),
      );
      await _localDataSource.upsertTheme(theme.toLocalTheme());
      return Success(theme);
    } on Object {
      return const Failure(UnexpectedError());
    }
  }

  @override
  Future<AppResult<()>> renameTheme(String id, String name) async {
    try {
      await _localDataSource.renameTheme(id, name);
      return const Success(());
    } on Object {
      return const Failure(UnexpectedError());
    }
  }

  @override
  Future<AppResult<()>> setThemeAccent(String id, AccentColor accent) async {
    try {
      await _localDataSource.setAccent(id, accent.value);
      return const Success(());
    } on Object {
      return const Failure(UnexpectedError());
    }
  }

  @override
  Future<AppResult<()>> setThemeSymbol(String id, CollectionSymbol symbol) async {
    try {
      await _localDataSource.setSymbol(id, symbol.value);
      return const Success(());
    } on Object {
      return const Failure(UnexpectedError());
    }
  }

  @override
  Future<AppResult<()>> deleteTheme(String id) async {
    try {
      await _localDataSource.deleteTheme(id);
      return const Success(());
    } on Object {
      return const Failure(UnexpectedError());
    }
  }

  @override
  Future<AppResult<()>> addQuoteToTheme({
    required String themeId,
    required String quoteId,
  }) async {
    try {
      await _localDataSource.addQuote(themeId, quoteId);
      return const Success(());
    } on Object {
      return const Failure(UnexpectedError());
    }
  }

  @override
  Future<AppResult<()>> removeQuoteFromTheme({
    required String themeId,
    required String quoteId,
  }) async {
    try {
      await _localDataSource.removeQuote(themeId, quoteId);
      return const Success(());
    } on Object {
      return const Failure(UnexpectedError());
    }
  }
}
