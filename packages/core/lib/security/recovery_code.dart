import 'dart:math';
import 'dart:typed_data';

// * Crockford base32: no I, L, O or U, so 1/I/L and 0/O cannot be confused and
// * no four-letter word can appear in a generated code.
const _alphabet = "0123456789ABCDEFGHJKMNPQRSTVWXYZ";
const _bitsPerSymbol = 5;
const _keyBytes = 16;
const _checksumBytes = 4;
const _groupSize = 4;
const _groupCount = 8;
const _separator = " ";
const _crcPolynomial = 0xEDB88320;
const _crcSeed = 0xFFFFFFFF;
const _byteMask = 0xFF;
const _bitsPerByte = 8;
const _symbolMask = 0x1F;
const _byteRange = 256;

class const RecoveryCode({
  required final Uint8List key,
  required final String formatted,
}) {
  static const int groupCount = _groupCount;
  static const int groupSize = _groupSize;

  /// Folds what people actually type onto the alphabet, so an input field and
  /// [tryParse] agree on what a character means instead of each having its own
  /// idea of it.
  static String normalise(String input) => _normalise(input);

  static RecoveryCode generate() {
    final random = Random.secure();
    return fromKey(Uint8List.fromList(List.generate(_keyBytes, (_) => random.nextInt(_byteRange))));
  }

  static RecoveryCode fromKey(Uint8List key) {
    final payload = Uint8List(_keyBytes + _checksumBytes)
      ..setRange(0, _keyBytes, key)
      ..setRange(_keyBytes, _keyBytes + _checksumBytes, _checksumOf(key));
    return RecoveryCode(key: key, formatted: _group(_encode(payload)));
  }

  // * one verdict for the whole code, never per group: the UI must not reveal
  // * which part is wrong
  static RecoveryCode? tryParse(String input) {
    final symbols = _normalise(input);
    if (symbols.length != _groupCount * _groupSize) return null;

    final payload = _decode(symbols);
    if (payload == null) return null;

    final key = Uint8List.sublistView(payload, 0, _keyBytes);
    final checksum = Uint8List.sublistView(payload, _keyBytes, _keyBytes + _checksumBytes);
    final expected = _checksumOf(key);
    for (var index = 0; index < _checksumBytes; index += 1) {
      if (checksum[index] != expected[index]) return null;
    }
    return RecoveryCode(key: Uint8List.fromList(key), formatted: _group(symbols));
  }

  List<String> get groups => [
    for (var index = 0; index < _groupCount; index += 1)
      formatted.substring(index * (_groupSize + 1), index * (_groupSize + 1) + _groupSize),
  ];
}

// * accepts what people actually type: lower case, hyphens, missing spaces,
// * and the letters Crockford folds onto digits
String _normalise(String input) {
  final buffer = StringBuffer();
  for (final rune in input.toUpperCase().runes) {
    final character = String.fromCharCode(rune);
    final mapped = switch (character) {
      "O" => "0",
      "I" || "L" => "1",
      "U" => "V",
      _ => character,
    };
    if (_alphabet.contains(mapped)) buffer.write(mapped);
  }
  return buffer.toString();
}

String _group(String symbols) {
  return [
    for (var index = 0; index < symbols.length; index += _groupSize)
      symbols.substring(index, index + _groupSize),
  ].join(_separator);
}

String _encode(Uint8List bytes) {
  final buffer = StringBuffer();
  var accumulator = 0;
  var bits = 0;
  for (final byte in bytes) {
    accumulator = (accumulator << _bitsPerByte) | byte;
    bits += _bitsPerByte;
    while (bits >= _bitsPerSymbol) {
      bits -= _bitsPerSymbol;
      buffer.write(_alphabet[(accumulator >> bits) & _symbolMask]);
    }
  }
  if (bits > 0) {
    buffer.write(_alphabet[(accumulator << (_bitsPerSymbol - bits)) & _symbolMask]);
  }
  return buffer.toString();
}

Uint8List? _decode(String symbols) {
  final bytes = <int>[];
  var accumulator = 0;
  var bits = 0;
  for (final rune in symbols.runes) {
    final value = _alphabet.indexOf(String.fromCharCode(rune));
    if (value < 0) return null;
    accumulator = (accumulator << _bitsPerSymbol) | value;
    bits += _bitsPerSymbol;
    if (bits >= _bitsPerByte) {
      bits -= _bitsPerByte;
      bytes.add((accumulator >> bits) & _byteMask);
    }
  }
  if (bytes.length < _keyBytes + _checksumBytes) return null;
  return Uint8List.fromList(bytes.sublist(0, _keyBytes + _checksumBytes));
}

Uint8List _checksumOf(Uint8List key) {
  var crc = _crcSeed;
  for (final byte in key) {
    crc ^= byte;
    for (var bit = 0; bit < _bitsPerByte; bit += 1) {
      crc = (crc & 1) == 1 ? (crc >> 1) ^ _crcPolynomial : crc >> 1;
    }
  }
  crc ^= _crcSeed;
  return Uint8List.fromList([
    (crc >> 24) & _byteMask,
    (crc >> 16) & _byteMask,
    (crc >> 8) & _byteMask,
    crc & _byteMask,
  ]);
}
