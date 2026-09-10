class const RemoteOcrResult({
  required final String text,
  required final String engine,
  required final int usedDay,
  required final int usedWeek,
  required final int usedMonth,
});

// * the two refusals the app answers the same way, by recognising on device.
// * They are separate types because the quota one carries numbers worth showing
class const CloudScanQuotaException({
  required final int usedDay,
  required final int usedWeek,
  required final int usedMonth,
  required final int limitDay,
  required final int limitWeek,
  required final int limitMonth,
}) implements Exception;

class const CloudScanUnavailableException(final String reason) implements Exception;
