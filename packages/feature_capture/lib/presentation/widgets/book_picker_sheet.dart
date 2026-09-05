import 'package:core/theme/corner_radii.dart';
import 'package:core/theme/spacing.dart';
import 'package:feature_capture/presentation/marking/marking_bloc.dart';
import 'package:feature_capture/presentation/marking/marking_event.dart';
import 'package:feature_capture/presentation/marking/marking_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared/domain/entities/book.dart';
import 'package:shared/presentation/extensions/context_extensions.dart';
import 'package:shared/presentation/navigation/navigation_extensions.dart';
import 'package:shared/presentation/widgets/book_cover.dart';
import 'package:shared/presentation/widgets/ink_tap_box.dart';
import 'package:shared/presentation/widgets/sheet_content.dart';

const _coverWidth = 36.0;
const _coverHeight = 48.0;
const _rowRadius = Spacing.radiusL;
const _rowPadding = Spacing.s;

Future<void> showBookPickerSheet(BuildContext context) async {
  final bloc = context.read<MarkingBloc>();
  final addsBook = await showModalBottomSheet<bool>(
    context: context,
    isScrollControlled: true,
    useRootNavigator: true,
    builder: (_) => BlocProvider.value(value: bloc, child: const _BookPickerSheet()),
  );
  if (addsBook != true || !context.mounted) return;
  final bookId = await context.pushAddBook();
  if (bookId != null) bloc.add(MarkingBookChanged(bookId));
}

class const _BookPickerSheet() extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MarkingBloc, MarkingState>(
      builder: (context, state) {
        if (state is! MarkingReady) return const SizedBox.shrink();
        return SheetContent(
          children: [
            Text(context.s.markingBookPickerTitle, style: context.t.titleMedium),
            const SizedBox(height: Spacing.m),
            Flexible(
              child: ListView.separated(
                shrinkWrap: true,
                padding: EdgeInsets.zero,
                itemCount: state.books.length,
                separatorBuilder: (context, index) => const SizedBox(height: Spacing.xs),
                itemBuilder: (context, index) => _BookPickerRow(
                  book: state.books[index],
                  selected: state.books[index].id == state.bookId,
                ),
              ),
            ),
            if (state.books.isNotEmpty) const SizedBox(height: Spacing.xs),
            const _AddBookRow(),
          ],
        );
      },
    );
  }
}

class const _AddBookRow() extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return InkTapBox(
      color: context.c.surfaceContainerHigh,
      radius: _rowRadius,
      padding: const EdgeInsets.all(_rowPadding),
      onTap: () => Navigator.of(context).pop(true),
      child: Row(
        children: [
          Container(
            width: _coverWidth,
            height: _coverHeight,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: context.c.primaryContainer,
              borderRadius: BorderRadius.circular(
                CornerRadii.nested(_rowRadius, _rowPadding),
              ),
            ),
            child: Icon(Icons.add, size: Spacing.iconM, color: context.c.onPrimaryContainer),
          ),
          const SizedBox(width: Spacing.s),
          Expanded(
            child: Text(context.s.markingAddBookButton, style: context.t.titleMedium),
          ),
        ],
      ),
    );
  }
}

class const _BookPickerRow({
  required final Book _book,
  required final bool _selected,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final authors = _book.authors.isEmpty ? context.s.bookAuthorsUnknown : _book.authors.join(", ");
    return InkTapBox(
      color: _selected ? context.c.secondaryContainer : context.c.surfaceContainerHigh,
      radius: _rowRadius,
      padding: const EdgeInsets.all(_rowPadding),
      onTap: () {
        context.read<MarkingBloc>().add(MarkingBookChanged(_book.id));
        Navigator.of(context).pop();
      },
      child: Row(
        children: [
          BookCover(
            title: _book.title,
            image: _book.coverImage,
            width: _coverWidth,
            height: _coverHeight,
            radius: CornerRadii.nested(_rowRadius, _rowPadding),
          ),
          const SizedBox(width: Spacing.s),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  _book.title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: context.t.titleMedium,
                ),
                Text(
                  authors,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: context.typography.label.copyWith(
                    color: context.c.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: Spacing.s),
          Icon(
            _selected ? Icons.check_circle : Icons.circle_outlined,
            color: _selected ? context.c.secondary : context.c.outline,
            size: Spacing.iconM,
          ),
        ],
      ),
    );
  }
}
