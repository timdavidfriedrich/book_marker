// ignore_for_file: avoid_print

// Fails if the generated DI code resolves a dependency nobody registers.
//
//   dart run tool/check_di.dart
//
// injectable emits the `gh<T>()` lookup whether or not T is registered
// anywhere, so a class that lost its annotation compiles, analyses and builds
// cleanly and then throws on the first frame. That happened once; this is so it
// cannot happen quietly again.

import 'dart:io';

final _registration = RegExp(
  r'gh\.(?:factory|lazySingleton|singleton|factoryParam|singletonAsync|'
  r'lazySingletonAsync|factoryAsync)<[^>]*?\.?(\w+)>',
);
final _resolution = RegExp(r'gh<[^>]*?\.?(\w+)>');

void main() {
  final files = [
    ...Directory('packages').listSync().whereType<Directory>().expand(_moduleFiles),
    ...Directory('lib/src/di').listSync().whereType<File>().where(_isGenerated),
  ];

  final registered = <String>{};
  final resolved = <String, Set<String>>{};
  for (final file in files) {
    final source = file.readAsStringSync();
    registered.addAll(_registration.allMatches(source).map((m) => m.group(1)!));
    for (final match in _resolution.allMatches(source)) {
      resolved.putIfAbsent(match.group(1)!, () => {}).add(file.path);
    }
  }

  final missing = resolved.keys.where((name) => !registered.contains(name)).toList()..sort();
  if (missing.isEmpty) {
    print('DI: ${resolved.length} resolved types, all registered (${files.length} files)');
    return;
  }
  for (final name in missing) {
    print('$name is resolved but never registered, wanted by ${resolved[name]!.join(", ")}');
  }
  exit(1);
}

Iterable<File> _moduleFiles(Directory package) {
  final di = Directory('${package.path}/lib/di');
  if (!di.existsSync()) return const [];
  return di.listSync().whereType<File>().where(_isGenerated);
}

bool _isGenerated(File file) =>
    file.path.endsWith('.module.dart') || file.path.endsWith('.config.dart');
