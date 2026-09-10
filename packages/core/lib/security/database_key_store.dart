import 'dart:convert';
import 'dart:math';
import 'dart:typed_data';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:injectable/injectable.dart';

const _storageKey = "book_marker.database_key";
const _keyBytes = 32;
const _byteRange = 256;

// * separate from the master key on purpose. This one encrypts the local
// * database FILE and never leaves the device, so it needs no recovery path;
// * the master key encrypts field contents and must survive a lost phone.
// * Tying the two would mean a signed out user's database could not be opened.
abstract class DatabaseKeyStore {
  Future<String> readOrCreate();
}

@LazySingleton(as: DatabaseKeyStore)
class DatabaseKeyStoreImpl(
  final FlutterSecureStorage _storage,
) implements DatabaseKeyStore {
  String? _cached;

  @override
  Future<String> readOrCreate() async {
    final existing = _cached ?? await _storage.read(key: _storageKey);
    if (existing != null) return _cached = existing;
    final random = Random.secure();
    final key = Uint8List.fromList(
      List.generate(_keyBytes, (_) => random.nextInt(_byteRange)),
    );
    final encoded = base64Encode(key);
    await _storage.write(key: _storageKey, value: encoded);
    return _cached = encoded;
  }
}
