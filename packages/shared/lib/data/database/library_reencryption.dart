import 'dart:typed_data';

import 'package:core/security/field_cipher.dart';
import 'package:injectable/injectable.dart';
import 'package:shared/data/database/cipher_codec.dart';
import 'package:shared/data/database/sync_database.dart';
import 'package:shared/data/database/sync_schema.dart';

const _cipherSuffix = "_cipher";
const _idColumn = "id";

// * a library built before signing in is encrypted under the key this device
// * generated on first launch. Entering a recovery code adopts a DIFFERENT key,
// * and without this every one of those rows would become unreadable, then be
// * adopted and uploaded as ciphertext the account can never open again. That
// * is worse than losing them locally, because it puts permanent garbage in the
// * account. Rewriting them first is what makes unlocking non destructive.
@lazySingleton
class const LibraryReencryption(
  final SyncDatabase _syncDatabase,
  final FieldCipher _cipher,
  final CipherCodec _codec,
) {
  // * runs while the library is still local only, which is the only time it is
  // * correct: unlocking happens in the locked state and adoption follows it,
  // * so the public table names still belong to the local half here
  Future<void> rotate({required Uint8List from, required Uint8List to}) async {
    await _syncDatabase.connection.writeTransaction((transaction) async {
      for (final entry in syncedTableColumns.entries) {
        final columns = entry.value.where((column) => column.endsWith(_cipherSuffix)).toList();
        if (columns.isEmpty) continue;
        final rows = await transaction.getAll(
          "SELECT $_idColumn, ${columns.join(", ")} FROM ${entry.key}",
        );
        for (final row in rows) {
          final values = <Object?>[];
          for (final column in columns) {
            final value = row[column] as String?;
            values.add(value == null ? null : await _cipher.rotate(value, from: from, to: to));
          }
          await transaction.execute(
            "UPDATE ${entry.key} SET ${columns.map((column) => "$column = ?").join(", ")} "
            "WHERE $_idColumn = ?",
            [...values, row[_idColumn]],
          );
        }
      }
    });
    // * the cache is keyed by ciphertext, and every ciphertext just changed
    _codec.forget();
  }
}
