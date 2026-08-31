import 'package:flutter/material.dart';
import 'package:shared/domain/entities/book.dart';
import 'package:shared/presentation/extensions/context_extensions.dart';

extension BookStatusExtensions on BookStatus {
  String toLabel(BuildContext context) => switch (this) {
    BookStatus.reading => context.s.libraryStatusReading,
    BookStatus.paused => context.s.libraryStatusPaused,
    BookStatus.finished => context.s.libraryStatusFinished,
  };

  String? toSummaryLabel(BuildContext context) =>
      this == BookStatus.reading ? null : toLabel(context);

  String toActionLabel(BuildContext context) => switch (this) {
    BookStatus.reading => context.s.bookDetailMarkReading,
    BookStatus.paused => context.s.bookDetailMarkPaused,
    BookStatus.finished => context.s.bookDetailMarkFinished,
  };

  IconData toIcon() => switch (this) {
    BookStatus.reading => Icons.menu_book_outlined,
    BookStatus.paused => Icons.pause_circle_outline,
    BookStatus.finished => Icons.check_circle_outline,
  };
}
