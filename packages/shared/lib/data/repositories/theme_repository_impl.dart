import 'package:core/error/app_error.dart';
import 'package:core/error/app_result.dart';
import 'package:core/theme/accent_color.dart';
import 'package:injectable/injectable.dart';
import 'package:shared/data/data_sources/theme_local_data_source.dart';
import 'package:shared/data/mappers/accent_mappers.dart';
import 'package:shared/data/mappers/theme_mappers.dart';
import 'package:shared/domain/entities/mark_theme.dart';
import 'package:shared/domain/repositories/theme_repository.dart';
import 'package:uuid/uuid.dart';

const _uuid = Uuid();

@Injectable(as: ThemeRepository)
class const ThemeRepositoryImpl(
  final ThemeLocalDataSource _localDataSource,
) implements ThemeRepository {
  @override
  Stream<AppResult<List<MarkTheme>>> watchThemes() async* {
    try {
      yield* _localDataSource.watchThemes().map<AppResult<List<MarkTheme>>>(
        (rows) => Success(rows.map((it) => it.toMarkTheme()).toList()),
      );
    } on Object {
      yield const Failure(UnexpectedError());
    }
  }

  @override
  Stream<AppResult<Map<String, Set<String>>>> watchThemeMembership() async* {
    try {
      yield* _localDataSource.watchThemeMarks().map<AppResult<Map<String, Set<String>>>>((rows) {
        final membership = <String, Set<String>>{};
        for (final row in rows) {
          membership.putIfAbsent(row.themeId, () => <String>{}).add(row.bookmarkId);
        }
        return Success(membership);
      });
    } on Object {
      yield const Failure(UnexpectedError());
    }
  }

  @override
  Future<AppResult<MarkTheme>> createTheme(String name) async {
    try {
      final theme = MarkTheme(id: _uuid.v4(), name: name, createdAt: DateTime.now().toUtc());
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
  Future<AppResult<()>> setThemeAccent(String id, AccentColor? accent) async {
    try {
      await _localDataSource.setAccent(id, accent?.value);
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
  Future<AppResult<()>> addMarkToTheme({
    required String themeId,
    required String bookmarkId,
  }) async {
    try {
      await _localDataSource.addMark(themeId, bookmarkId);
      return const Success(());
    } on Object {
      return const Failure(UnexpectedError());
    }
  }

  @override
  Future<AppResult<()>> removeMarkFromTheme({
    required String themeId,
    required String bookmarkId,
  }) async {
    try {
      await _localDataSource.removeMark(themeId, bookmarkId);
      return const Success(());
    } on Object {
      return const Failure(UnexpectedError());
    }
  }
}
