sealed class BookmarkDetailEvent {
  const BookmarkDetailEvent();
}

class const BookmarkDetailStarted() extends BookmarkDetailEvent;

class const BookmarkDetailFavoriteToggled() extends BookmarkDetailEvent;

class const BookmarkDetailNoteChanged(
  final String? note,
) extends BookmarkDetailEvent;

class const BookmarkDetailDeleteRequested() extends BookmarkDetailEvent;
