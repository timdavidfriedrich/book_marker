extension DurationExtensions on Duration {
  String toMinutesSecondsString() => "$inMinutes:${(inSeconds % 60).toString().padLeft(2, "0")}";
}
