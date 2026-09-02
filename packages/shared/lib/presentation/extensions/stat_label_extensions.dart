import 'package:flutter/widgets.dart';
import 'package:shared/presentation/extensions/context_extensions.dart';

const _statSeparator = ", ";

extension StatCountExtensions on int {
  String toQuotesStat(BuildContext context) => context.s.libraryQuotesCount(this);

  String toBooksStat(BuildContext context) => context.s.libraryBooksCount(this);

  String? toFavoritesStat(BuildContext context) =>
      this == 0 ? null : context.s.libraryFavoritesCount(this);
}

extension StatLabelExtensions on List<String?> {
  String joinStats() => [
    for (final label in this)
      if (label != null && label.isNotEmpty) label,
  ].join(_statSeparator);
}
