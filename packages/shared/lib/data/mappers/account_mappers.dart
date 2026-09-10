import 'package:shared/data/models/remote_account.dart';
import 'package:shared/domain/entities/account.dart';

extension RemoteAccountMappers on RemoteAccount {
  Account toAccount() {
    return Account(
      id: id,
      displayName: _firstNonEmpty([fullName, userName, email]),
      email: email,
    );
  }
}

String? _firstNonEmpty(List<String?> candidates) {
  for (final candidate in candidates) {
    if (candidate != null && candidate.trim().isNotEmpty) return candidate.trim();
  }
  return null;
}
