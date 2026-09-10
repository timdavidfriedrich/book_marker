/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: implementation_imports
// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: non_constant_identifier_names
// ignore_for_file: public_member_api_docs
// ignore_for_file: type_literal_in_constant_pattern
// ignore_for_file: use_super_parameters
// ignore_for_file: invalid_use_of_internal_member

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _ida;
import 'dart:typed_data' as _idt;
import 'package:book_marker_client/src/protocol/config/runtime_config.dart'
    as _i0ksu74t;
import 'package:book_marker_client/src/protocol/entitlements/entitlement_view.dart'
    as _i54kjtar;
import 'package:book_marker_client/src/protocol/entitlements/ocr_result.dart'
    as _ihko1ch1;
import 'package:book_marker_client/src/protocol/sync/sync_result.dart'
    as _ikx0tj25;
import 'package:book_marker_client/src/protocol/sync/sync_write.dart'
    as _ihx5no0d;
import 'package:http/http.dart' as _i85jenna;
import 'package:serverpod_auth_core_client/serverpod_auth_core_client.dart'
    as _iacc;
import 'package:serverpod_auth_idp_client/serverpod_auth_idp_client.dart'
    as _iaic;
import 'package:serverpod_client/serverpod_client.dart' as _isc;
import 'protocol.dart' as _il2as5qe;

/// Exposes the Apple identity provider. See [GoogleIdpEndpoint].
/// {@category Endpoint}
class EndpointAppleIdp extends _iaic.EndpointAppleIdpBase {
  EndpointAppleIdp(_isc.EndpointCaller caller) : super(caller);

  @override
  String get name => 'appleIdp';

  /// Signs in a user with their Apple account.
  ///
  /// If no user exists yet linked to the Apple-provided identifier, a new one
  /// will be created (without any `Scope`s). Further their provided name and
  /// email (if any) will be used for the `UserProfile` which will be linked to
  /// their `AuthUser`.
  ///
  /// Returns a session for the user upon successful login.
  @override
  _ida.Future<_iacc.AuthSuccess> login({
    required String identityToken,
    required String authorizationCode,
    required bool isNativeApplePlatformSignIn,
    String? firstName,
    String? lastName,
  }) => caller.callServerEndpoint<_iacc.AuthSuccess>(
    'appleIdp',
    'login',
    {
      'identityToken': identityToken,
      'authorizationCode': authorizationCode,
      'isNativeApplePlatformSignIn': isNativeApplePlatformSignIn,
      'firstName': firstName,
      'lastName': lastName,
    },
  );

  @override
  _ida.Future<bool> hasAccount() => caller.callServerEndpoint<bool>(
    'appleIdp',
    'hasAccount',
    {},
  );
}

/// Exposes the Google identity provider. The base class carries the whole
/// flow; it only has to be subclassed so the generator picks it up.
/// {@category Endpoint}
class EndpointGoogleIdp extends _iaic.EndpointGoogleIdpBase {
  EndpointGoogleIdp(_isc.EndpointCaller caller) : super(caller);

  @override
  String get name => 'googleIdp';

  /// Validates a Google ID token and either logs in the associated user or
  /// creates a new user account if the Google account ID is not yet known.
  ///
  /// If a new user is created an associated [UserProfile] is also created.
  @override
  _ida.Future<_iacc.AuthSuccess> login({
    required String idToken,
    required String? accessToken,
  }) => caller.callServerEndpoint<_iacc.AuthSuccess>(
    'googleIdp',
    'login',
    {
      'idToken': idToken,
      'accessToken': accessToken,
    },
  );

  /// Validates a Google authorization code from the web OAuth2 PKCE flow and
  /// either logs in the associated user or creates a new account.
  ///
  /// This is the web counterpart of [login], which accepts an ID token directly
  /// (used on native platforms via the `google_sign_in` package).
  ///
  /// If a new user is created an associated [UserProfile] is also created.
  @override
  _ida.Future<_iacc.AuthSuccess> loginWithCode({
    required String code,
    required String codeVerifier,
    required String redirectUri,
  }) => caller.callServerEndpoint<_iacc.AuthSuccess>(
    'googleIdp',
    'loginWithCode',
    {
      'code': code,
      'codeVerifier': codeVerifier,
      'redirectUri': redirectUri,
    },
  );

  @override
  _ida.Future<bool> hasAccount() => caller.callServerEndpoint<bool>(
    'googleIdp',
    'hasAccount',
    {},
  );
}

/// By extending [RefreshJwtTokensEndpoint], the JWT token refresh endpoint
/// is made available on the server and enables automatic token refresh on the client.
/// {@category Endpoint}
class EndpointJwtRefresh extends _iacc.EndpointRefreshJwtTokens {
  EndpointJwtRefresh(_isc.EndpointCaller caller) : super(caller);

  @override
  String get name => 'jwtRefresh';

  /// Creates a new token pair for the given [refreshToken].
  ///
  /// If [refreshToken] is omitted, cookie-mode web clients fall back to the
  /// configured HttpOnly refresh cookie. When neither source is present this
  /// throws [RefreshTokenNotFoundException], the same public "no usable refresh
  /// credential" exception used for unknown refresh tokens.
  ///
  /// Can throw the following exceptions:
  /// -[RefreshTokenMalformedException]: refresh token is malformed and could
  ///   not be parsed. Not expected to happen for tokens issued by the server.
  /// -[RefreshTokenNotFoundException]: refresh token is unknown to the server.
  ///   Either the token was deleted or generated by a different server.
  /// -[RefreshTokenExpiredException]: refresh token has expired. Will happen
  ///   only if it has not been used within configured `refreshTokenLifetime`.
  /// -[RefreshTokenInvalidSecretException]: refresh token is incorrect, meaning
  ///   it does not refer to the current secret refresh token. This indicates
  ///   either a malfunctioning client or a malicious attempt by someone who has
  ///   obtained the refresh token. In this case the underlying refresh token
  ///   will be deleted, and access to it will expire fully when the last access
  ///   token is elapsed.
  ///
  /// This endpoint is unauthenticated, meaning the client won't include any
  /// authentication information with the call.
  @override
  _ida.Future<_iacc.AuthSuccess> refreshAccessToken({String? refreshToken}) =>
      caller.callServerEndpoint<_iacc.AuthSuccess>(
        'jwtRefresh',
        'refreshAccessToken',
        {'refreshToken': refreshToken},
        authenticated: false,
      );
}

/// Account deletion, which DSGVO requires and which nothing else on this server
/// does: every other path only ever adds or updates.
///
/// Deliberately allowed while blocked. A suspended account still has the right
/// to its own erasure, and refusing would turn a legal obligation into a
/// support ticket.
/// {@category Endpoint}
class EndpointAccount extends _isc.EndpointRef {
  EndpointAccount(_isc.EndpointCaller caller) : super(caller);

  @override
  String get name => 'account';

  _ida.Future<void> delete() => caller.callServerEndpoint<void>(
    'account',
    'delete',
    {},
  );
}

/// Serves the runtime configuration to the app.
///
/// Deliberately unauthenticated. `maintenanceMode` and `minSupportedVersion`
/// have to reach a client that cannot sign in, which is the situation they
/// exist for, and the file holds nothing that is not already visible in a
/// decompiled APK.
/// {@category Endpoint}
class EndpointConfig extends _isc.EndpointRef {
  EndpointConfig(_isc.EndpointCaller caller) : super(caller);

  @override
  String get name => 'config';

  _ida.Future<_i0ksu74t.RuntimeConfig> fetch() =>
      caller.callServerEndpoint<_i0ksu74t.RuntimeConfig>(
        'config',
        'fetch',
        {},
      );
}

/// Plan, account status and cloud OCR usage, read straight from the database.
///
/// This is the path that works before PowerSync connects, which is the only
/// path available at sign-in: the master key has to be resolved before the
/// encrypted local database can be opened, so sync cannot answer it.
/// {@category Endpoint}
class EndpointEntitlement extends _isc.EndpointRef {
  EndpointEntitlement(_isc.EndpointCaller caller) : super(caller);

  @override
  String get name => 'entitlement';

  /// Deliberately does NOT refuse a blocked account. The client has to read the
  /// status to explain the block; refusing here would leave it with nothing to
  /// show but a generic error.
  _ida.Future<_i54kjtar.EntitlementView> fetch() =>
      caller.callServerEndpoint<_i54kjtar.EntitlementView>(
        'entitlement',
        'fetch',
        {},
      );

  /// Also allowed while blocked, unlike every other write. It consumes nothing
  /// and grants nothing; withholding it would leave a device holding a key the
  /// server has no record of, which is the one state that loses data later.
  ///
  /// Returns the row as it stands afterwards. A caller whose verifier is not
  /// the one that came back lost a race with another device and must not keep
  /// its own key.
  _ida.Future<_i54kjtar.EntitlementView> registerBackup(String verifier) =>
      caller.callServerEndpoint<_i54kjtar.EntitlementView>(
        'entitlement',
        'registerBackup',
        {'verifier': verifier},
      );
}

/// The cloud OCR proxy. It exists so the model provider's API key never ships
/// in an app binary, and so the per-user limits are enforced somewhere the user
/// cannot edit.
///
/// The image is not end-to-end encrypted and cannot be: it reaches this server
/// in the clear and is forwarded in the clear. What it never does is touch the
/// disk, a log, or anything stored. Everything the app *keeps* stays E2E; this
/// one request in flight is not, and the privacy policy has to say so.
/// {@category Endpoint}
class EndpointOcr extends _isc.EndpointRef {
  EndpointOcr(_isc.EndpointCaller caller) : super(caller);

  @override
  String get name => 'ocr';

  _ida.Future<_ihko1ch1.OcrResult> recognizePage(_idt.ByteData image) =>
      caller.callServerEndpoint<_ihko1ch1.OcrResult>(
        'ocr',
        'recognizePage',
        {'image': image},
      );
}

/// Hands the client a PowerSync credential. This is the real gate on sync: a
/// blocked account is refused here, and the 10-minute token lifetime bounds how
/// long an already-issued one stays usable.
/// {@category Endpoint}
class EndpointPowerSync extends _isc.EndpointRef {
  EndpointPowerSync(_isc.EndpointCaller caller) : super(caller);

  @override
  String get name => 'powerSync';

  _ida.Future<String> createToken() => caller.callServerEndpoint<String>(
    'powerSync',
    'createToken',
    {},
  );
}

/// The upload half of sync. PowerSync streams rows down; everything the device
/// writes comes back up through here.
/// {@category Endpoint}
class EndpointSync extends _isc.EndpointRef {
  EndpointSync(_isc.EndpointCaller caller) : super(caller);

  @override
  String get name => 'sync';

  _ida.Future<_ikx0tj25.SyncResult> upload(List<_ihx5no0d.SyncWrite> writes) =>
      caller.callServerEndpoint<_ikx0tj25.SyncResult>(
        'sync',
        'upload',
        {'writes': writes},
      );
}

class Modules {
  Modules(Client client) {
    serverpod_auth_idp = _iaic.Caller(client);
    serverpod_auth_core = _iacc.Caller(client);
  }

  late final _iaic.Caller serverpod_auth_idp;

  late final _iacc.Caller serverpod_auth_core;
}

class Client extends _isc.ServerpodClientShared {
  Client(
    String host, {
    dynamic securityContext,
    Duration? streamingConnectionTimeout,
    Duration? connectionTimeout,
    Function(
      _isc.MethodCallContext,
      Object,
      StackTrace,
    )?
    onFailedCall,
    Function(_isc.MethodCallContext)? onSucceededCall,
    bool? disconnectStreamsOnLostInternetConnection,
    _i85jenna.Client? httpClientOverride,
  }) : super(
         host,
         _il2as5qe.Protocol(),
         securityContext: securityContext,
         streamingConnectionTimeout: streamingConnectionTimeout,
         connectionTimeout: connectionTimeout,
         onFailedCall: onFailedCall,
         onSucceededCall: onSucceededCall,
         disconnectStreamsOnLostInternetConnection:
             disconnectStreamsOnLostInternetConnection,
         httpClientOverride: httpClientOverride,
       ) {
    appleIdp = EndpointAppleIdp(this);
    googleIdp = EndpointGoogleIdp(this);
    jwtRefresh = EndpointJwtRefresh(this);
    account = EndpointAccount(this);
    config = EndpointConfig(this);
    entitlement = EndpointEntitlement(this);
    ocr = EndpointOcr(this);
    powerSync = EndpointPowerSync(this);
    sync = EndpointSync(this);
    modules = Modules(this);
  }

  late final EndpointAppleIdp appleIdp;

  late final EndpointGoogleIdp googleIdp;

  late final EndpointJwtRefresh jwtRefresh;

  late final EndpointAccount account;

  late final EndpointConfig config;

  late final EndpointEntitlement entitlement;

  late final EndpointOcr ocr;

  late final EndpointPowerSync powerSync;

  late final EndpointSync sync;

  late final Modules modules;

  @override
  Map<String, _isc.EndpointRef> get endpointRefLookup => {
    'appleIdp': appleIdp,
    'googleIdp': googleIdp,
    'jwtRefresh': jwtRefresh,
    'account': account,
    'config': config,
    'entitlement': entitlement,
    'ocr': ocr,
    'powerSync': powerSync,
    'sync': sync,
  };

  @override
  Map<String, _isc.ModuleEndpointCaller> get moduleLookup => {
    'serverpod_auth_idp': modules.serverpod_auth_idp,
    'serverpod_auth_core': modules.serverpod_auth_core,
  };
}
