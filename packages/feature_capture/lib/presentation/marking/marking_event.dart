sealed class MarkingEvent {
  const MarkingEvent();
}

class const MarkingStarted() extends MarkingEvent;

class const MarkingLineToggled(
  final int index,
) extends MarkingEvent;

class const MarkingPageNumberChanged(
  final int? pageNumber,
) extends MarkingEvent;

class const MarkingStarToggled() extends MarkingEvent;

class const MarkingSaveRequested() extends MarkingEvent;
