import 'package:shared/data/database/app_database.dart';
import 'package:shared/data/mappers/accent_mappers.dart';
import 'package:shared/domain/entities/mark_theme.dart';

extension LocalThemeMappers on LocalTheme {
  MarkTheme toMarkTheme() {
    return MarkTheme(id: id, name: name, createdAt: createdAt, accent: accent?.toAccentColor());
  }
}

extension MarkThemeMappers on MarkTheme {
  LocalTheme toLocalTheme() {
    return LocalTheme(id: id, name: name, createdAt: createdAt, accent: accent?.value);
  }
}
