import 'package:serverpod_auth_idp_server/providers/google.dart';

/// Exposes the Google identity provider. The base class carries the whole
/// flow; it only has to be subclassed so the generator picks it up.
class GoogleIdpEndpoint extends GoogleIdpBaseEndpoint {}
