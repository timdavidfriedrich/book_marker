import 'package:dart_mappable/dart_mappable.dart';

part 'plan_limits.mapper.dart';

@MappableClass()
class const PlanLimits({
  required final int ocrPerDay,
  required final int ocrPerWeek,
  required final int ocrPerMonth,
  required final int maxImageBytes,
  required final bool attachmentsEnabled,
}) with PlanLimitsMappable;
