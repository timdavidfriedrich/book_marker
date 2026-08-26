import 'package:core/theme/spacing.dart';
import 'package:feature_capture/presentation/add_book/add_book_bloc.dart';
import 'package:feature_capture/presentation/add_book/add_book_event.dart';
import 'package:feature_capture/presentation/add_book/add_book_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:shared/domain/entities/book.dart';
import 'package:shared/presentation/extensions/app_error_extensions.dart';
import 'package:shared/presentation/extensions/context_extensions.dart';
import 'package:shared/presentation/navigation/navigation_extensions.dart';

const _thumbnailWidth = 40.0;

class const AddBookScreen({
  super.key,
}) extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final searchController = useTextEditingController();
    return Scaffold(
      appBar: AppBar(title: Text(context.s.addBookTitle)),
      body: BlocListener<AddBookBloc, AddBookState>(
        listenWhen: (previous, current) => current is AddBookSaved,
        listener: (context, state) {
          if (state is AddBookSaved) {
            context.closeScreenWithResult(state.bookId);
          }
        },
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(Spacing.m),
              child: _SearchField(controller: searchController),
            ),
            const Expanded(child: _Results()),
          ],
        ),
      ),
    );
  }
}

class const _SearchField({
  required final TextEditingController _controller,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: _controller,
      textInputAction: TextInputAction.search,
      onSubmitted: (query) => context.read<AddBookBloc>().add(AddBookSearched(query)),
      decoration: InputDecoration(
        hintText: context.s.addBookSearchHint,
        prefixIcon: const Icon(Icons.search),
        suffixIcon: IconButton(
          tooltip: context.s.addBookScanButton,
          icon: const Icon(Icons.qr_code_scanner),
          onPressed: () => _scanBarcode(context, _controller),
        ),
      ),
    );
  }
}

class const _Results() extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddBookBloc, AddBookState>(
      builder: (context, state) => switch (state) {
        AddBookInitial() => _Message(text: context.s.addBookInitialMessage),
        AddBookLoading() => const Center(child: CircularProgressIndicator()),
        AddBookEmpty() => _Message(text: context.s.addBookEmptyMessage),
        AddBookFailure(:final error) => _Message(text: error.toMessage(context)),
        AddBookResults(:final books) => _BookList(books: books),
        AddBookSaved() => const Center(child: CircularProgressIndicator()),
      },
    );
  }
}

class const _BookList({
  required final List<Book> _books,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: Spacing.m),
      itemCount: _books.length,
      itemBuilder: (context, index) {
        final book = _books[index];
        return ListTile(
          leading: _Thumbnail(url: book.thumbnailUrl),
          title: Text(book.title),
          subtitle: Text(
            book.authors.isEmpty ? context.s.bookAuthorsUnknown : book.authors.join(", "),
          ),
          onTap: () => context.read<AddBookBloc>().add(AddBookSelected(book)),
        );
      },
    );
  }
}

class const _Thumbnail({
  required final String? _url,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final url = _url;
    if (url == null) return const Icon(Icons.menu_book);
    return Image.network(
      url,
      width: _thumbnailWidth,
      fit: BoxFit.contain,
      errorBuilder: (context, error, stackTrace) => const Icon(Icons.menu_book),
    );
  }
}

class const _Message({
  required final String _text,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(Spacing.l),
        child: Text(_text, textAlign: TextAlign.center),
      ),
    );
  }
}

Future<void> _scanBarcode(BuildContext context, TextEditingController controller) async {
  final addBookBloc = context.read<AddBookBloc>();
  final code = await context.pushBarcodeScanner();
  if (code == null) return;
  controller.text = code;
  addBookBloc.add(AddBookSearched(code));
}
