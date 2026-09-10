import 'dart:io';

import 'package:yaml/yaml.dart';

import '../generated/protocol.dart';
import 'entitlements.dart';

const _configPath = 'app_config.yaml';

/// Reads `app_config.yaml`, the single source of truth for every value that can
/// change in production without a deploy or an app release.
///
/// The parsed result is cached and re-read whenever the file's mtime changes,
/// so editing it on the host takes effect on the next request with no restart.
/// A stat per request costs nothing at this size.
class ConfigSource {
  const ConfigSource();

  static RuntimeConfig? _cached;
  static DateTime? _cachedModifiedAt;

  RuntimeConfig read() {
    final file = File(_configPath);
    if (!file.existsSync()) {
      throw StateError(
        'Runtime configuration is missing. Expected `$_configPath` relative to '
        '${Directory.current.path}. In production it is mounted from the host '
        'by docker-compose.prod.yaml; in development it sits beside pubspec.yaml.',
      );
    }

    final modifiedAt = file.lastModifiedSync();
    final cached = _cached;
    if (cached != null && _cachedModifiedAt == modifiedAt) return cached;

    // Two concurrent requests may both parse here. That is harmless: parsing is
    // pure and both produce the same value, so a lock would only add contention.
    final parsed = _parse(file.readAsStringSync());
    _cached = parsed;
    _cachedModifiedAt = modifiedAt;
    return parsed;
  }

  /// Resolves a plan name from the entitlement row to its limits. An unknown
  /// plan resolves to `free`, which is the safe direction to fail in.
  PlanLimits limitsFor(final String plan) {
    final config = read();
    return plan == planPremium ? config.premium : config.free;
  }
}

RuntimeConfig _parse(final String source) {
  final root = _mapAt(loadYaml(source), 'root');
  final plans = _mapAt(root['plans'], 'plans');
  final recognition = _mapAt(root['recognition'], 'recognition');
  final client = _mapAt(root['client'], 'client');

  return RuntimeConfig(
    version: _intAt(root['version'], 'version'),
    free: _planAt(plans['free'], 'plans.free'),
    premium: _planAt(plans['premium'], 'plans.premium'),
    recognition: RecognitionConfig(
      provider: _stringAt(recognition['provider'], 'recognition.provider'),
      cloudEnabledByDefault: _boolAt(
        recognition['cloudEnabledByDefault'],
        'recognition.cloudEnabledByDefault',
      ),
    ),
    client: ClientConfig(
      minSupportedVersion: _stringAt(
        client['minSupportedVersion'],
        'client.minSupportedVersion',
      ),
      maintenanceMode: _boolAt(
        client['maintenanceMode'],
        'client.maintenanceMode',
      ),
      maintenanceMessage: _optionalStringAt(
        client['maintenanceMessage'],
        'client.maintenanceMessage',
      ),
    ),
  );
}

PlanLimits _planAt(final Object? value, final String path) {
  final plan = _mapAt(value, path);
  return PlanLimits(
    ocrPerDay: _intAt(plan['ocrPerDay'], '$path.ocrPerDay'),
    ocrPerWeek: _intAt(plan['ocrPerWeek'], '$path.ocrPerWeek'),
    ocrPerMonth: _intAt(plan['ocrPerMonth'], '$path.ocrPerMonth'),
    maxImageBytes: _intAt(plan['maxImageBytes'], '$path.maxImageBytes'),
    attachmentsEnabled: _boolAt(
      plan['attachmentsEnabled'],
      '$path.attachmentsEnabled',
    ),
  );
}

Map<dynamic, dynamic> _mapAt(final Object? value, final String path) =>
    value is Map ? value : _invalid(path, 'a map');

int _intAt(final Object? value, final String path) =>
    value is int ? value : _invalid(path, 'an integer');

bool _boolAt(final Object? value, final String path) =>
    value is bool ? value : _invalid(path, 'true or false');

String _stringAt(final Object? value, final String path) =>
    value is String ? value : _invalid(path, 'a string');

String? _optionalStringAt(final Object? value, final String path) =>
    value == null ? null : _stringAt(value, path);

Never _invalid(final String path, final String expected) => throw StateError(
  '`$_configPath` is invalid: `$path` must be $expected.',
);
