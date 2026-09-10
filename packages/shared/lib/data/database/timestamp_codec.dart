const _microsecondDigits = 6;
const _microsecondsPerMillisecond = 1000;
const _utcSuffix = "Z";

// * PowerSync replicates a Postgres timestamp as "2026-09-10T12:34:56.789000":
// * T separated, six fractional digits, no zone marker. Dart's own
// * toIso8601String appends Z and drops trailing microseconds, so a row written
// * here and a row that came back from the server would not be byte identical.
// * That matters because these columns are sorted lexicographically in SQL, and
// * ".789Z" sorts after ".790000" even though it is earlier.
String encodeTimestamp(DateTime value) {
  final utc = value.toUtc();
  final microseconds = utc.millisecond * _microsecondsPerMillisecond + utc.microsecond;
  return "${_pad(utc.year, 4)}-${_pad(utc.month, 2)}-${_pad(utc.day, 2)}"
      "T${_pad(utc.hour, 2)}:${_pad(utc.minute, 2)}:${_pad(utc.second, 2)}"
      ".${_pad(microseconds, _microsecondDigits)}";
}

// * the stored value is UTC without saying so, so the marker is added before
// * parsing; the result is local, which is what every entity above expects
DateTime decodeTimestamp(String value) {
  final normalised = value.endsWith(_utcSuffix) ? value : "$value$_utcSuffix";
  return DateTime.parse(normalised).toLocal();
}

String _pad(int value, int width) => value.toString().padLeft(width, "0");
