import 'package:book_marker_client/book_marker_client.dart';
import 'package:injectable/injectable.dart';
import 'package:shared/data/models/remote_entitlement.dart';

// * the only place the generated entitlement types are used; everything above
// * this file sees RemoteEntitlement
abstract class EntitlementRemoteDataSource {
  Future<RemoteEntitlement> fetchEntitlement();

  Future<RemoteEntitlement> registerBackup(String verifier);
}

@Injectable(as: EntitlementRemoteDataSource)
class const EntitlementRemoteDataSourceImpl(
  final Client _client,
) implements EntitlementRemoteDataSource {
  @override
  Future<RemoteEntitlement> fetchEntitlement() async =>
      _toRemoteEntitlement(await _client.entitlement.fetch());

  @override
  Future<RemoteEntitlement> registerBackup(String verifier) async =>
      _toRemoteEntitlement(await _client.entitlement.registerBackup(verifier));
}

RemoteEntitlement _toRemoteEntitlement(EntitlementView view) {
  return RemoteEntitlement(
    plan: view.plan,
    status: view.status,
    blockedReason: view.blockedReason,
    backupVerifier: view.backupVerifier,
    usedDay: view.usedDay,
    usedWeek: view.usedWeek,
    usedMonth: view.usedMonth,
  );
}
