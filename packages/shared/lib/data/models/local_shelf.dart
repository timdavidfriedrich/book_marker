class const LocalShelf({
  required final String id,
  required final String name,
  required final String? accent,
  required final String? symbol,
  required final DateTime createdAt,
});

class const LocalShelfBook({
  required final String id,
  required final String shelfId,
  required final String bookId,
});
