sealed class BookmarkDetailEvent {
  const BookmarkDetailEvent();
}

class const BookmarkDetailStarted() extends BookmarkDetailEvent;

class const BookmarkDetailFavoriteToggled() extends BookmarkDetailEvent;
