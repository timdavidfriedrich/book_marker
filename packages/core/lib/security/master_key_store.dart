import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:injectable/injectable.dart';

const _storageKey = "book_marker.master_key";

abstract class MasterKeyStore {
  Uint8List? get cached;

  Future<Uint8List?> read();

  Future<void> write(Uint8List key);

  Future<void> clear();
}

@LazySingleton(as: MasterKeyStore)
class MasterKeyStoreImpl(
  final FlutterSecureStorage _storage,
) implements MasterKeyStore {
  Uint8List? _cached;

  @override
  Uint8List? get cached => _cached;

  @override
  Future<Uint8List?> read() async {
    final existing = _cached;
    if (existing != null) return existing;
    final stored = await _storage.read(key: _storageKey);
    if (stored == null) return null;
    // * a keystore entry that survived but no longer decodes is treated as
    // * absent, which routes the user to unlock rather than crashing the app
    try {
      return _cached = Uint8List.fromList(base64Decode(stored));
    } on FormatException {
      return null;
    }
  }

  @override
  Future<void> write(Uint8List key) async {
    _cached = key;
    await _storage.write(key: _storageKey, value: base64Encode(key));
  }

  @override
  Future<void> clear() async {
    _cached = null;
    await _storage.delete(key: _storageKey);
  }
}

@module
abstract class SecureStorageModule {
  @lazySingleton
  FlutterSecureStorage secureStorage() => const FlutterSecureStorage(
    // * first_unlock_this_device, not first_unlock: the key must not ride an
    // * iCloud keychain backup to another device, or the recovery code stops
    // * being the only way in
    iOptions: IOSOptions(accessibility: KeychainAccessibility.first_unlock_this_device),
  );
}
