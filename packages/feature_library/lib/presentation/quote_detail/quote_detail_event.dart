sealed class QuoteDetailEvent {
  const QuoteDetailEvent();
}

class const QuoteDetailStarted() extends QuoteDetailEvent;

class const QuoteDetailFavoriteToggled() extends QuoteDetailEvent;

class const QuoteDetailNoteChanged(
  final String? note,
) extends QuoteDetailEvent;

class const QuoteDetailDeleteRequested() extends QuoteDetailEvent;
