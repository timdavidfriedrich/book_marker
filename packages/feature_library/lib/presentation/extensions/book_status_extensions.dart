import 'package:flutter/material.dart';
import 'package:shared/domain/entities/book.dart';
import 'package:shared/presentation/extensions/context_extensions.dart';
import 'package:shared/presentation/widgets/status_chip.dart';

extension BookStatusExtensions on BookStatus {
  String toLabel(BuildContext context) => switch (this) {
    BookStatus.reading => context.s.libraryStatusReading,
    BookStatus.paused => context.s.libraryStatusPaused,
    BookStatus.finished => context.s.libraryStatusFinished,
  };

  Widget toChip(BuildContext context) =>
      StatusChip(label: toLabel(context), icon: toIcon());

  Widget? toSummaryChip(BuildContext context) =>
      this == BookStatus.reading ? null : toChip(context);

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
