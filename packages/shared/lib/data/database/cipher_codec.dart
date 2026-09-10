import 'dart:collection';
import 'dart:convert';

import 'package:core/security/field_cipher.dart';
import 'package:injectable/injectable.dart';

const _cacheLimit = 4000;

// * one place where "encrypted column" is turned into a value and back, so the
// * five local data sources do not each repeat jsonEncode plus encrypt. Nothing
// * above the data sources ever sees a cipher string.
@LazySingleton()
class CipherCodec(
  final FieldCipher _cipher,
) {
  // * a stream that re-emits an unchanged row would otherwise decrypt every
  // * field again. Ciphertext changes whenever the value does, so it is a safe
  // * cache key, and a wrong key throws before anything is stored.
  final LinkedHashMap<String, String> _plaintext = LinkedHashMap();

  Future<String> encode(String value) => _cipher.encrypt(value);

  Future<String?> encodeOptional(String? value) async =>
      value == null ? null : _cipher.encrypt(value);

  Future<String> encodeJson(Object value) => _cipher.encrypt(jsonEncode(value));

  Future<String?> encodeOptionalJson(Object? value) async =>
      value == null ? null : _cipher.encrypt(jsonEncode(value));

  Future<String> decode(String value) async {
    final cached = _plaintext[value];
    if (cached != null) return cached;
    final plaintext = await _cipher.decrypt(value);
    if (_plaintext.length >= _cacheLimit) {
      _plaintext.remove(_plaintext.keys.first);
    }
    return _plaintext[value] = plaintext;
  }

  Future<String?> decodeOptional(String? value) async => value == null ? null : decode(value);

  Future<List<T>> decodeList<T>(
    String value,
    T Function(Object? element) toElement,
  ) async {
    final decoded = jsonDecode(await decode(value)) as List<dynamic>;
    return decoded.map(toElement).toList();
  }

  Future<Map<String, dynamic>?> decodeOptionalMap(String? value) async {
    if (value == null) return null;
    return (jsonDecode(await decode(value)) as Map<dynamic, dynamic>).cast<String, dynamic>();
  }

  void forget() => _plaintext.clear();
}
