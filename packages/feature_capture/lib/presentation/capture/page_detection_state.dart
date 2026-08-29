import 'package:feature_capture/domain/capture_mode.dart';
import 'package:shared/domain/entities/page_quad.dart';

class const PageDetectionState({
  required final CaptureMode mode,
  required final PageQuad? quad,
  required final double? frameAspectRatio,
});
