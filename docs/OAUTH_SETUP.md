# Sign-in credentials

Google is wired up. Apple is deferred until an Apple Developer account exists.

## Where each value lives

Both target files are gitignored. Never commit either.

| Value | File | Key |
|---|---|---|
| Web client JSON, whole file | `server/book_marker_server/config/passwords.yaml` | `googleClientSecret` |
| Web client ID | `dart_defines.json` | `GOOGLE_SERVER_CLIENT_ID` |
| iOS client ID | `dart_defines.json` | `GOOGLE_CLIENT_ID` |
| iOS reversed client ID | `ios/Runner/Info.plist` | `CFBundleURLSchemes` |
| Android client IDs | nowhere | registration alone is what works |

## Google Cloud, current state

Project "Commonplace book", four OAuth clients:

- **Web**: the one the server verifies tokens against. Its JSON must contain
  `redirect_uris`, because `GoogleClientSecret.fromJson` throws
  `FormatException('Missing "redirect_uris"')` without it, and Google only emits
  that field if at least one redirect URI was added. Ours are
  `http://localhost:8080/auth/google/callback` and
  `https://book-marker-api.timdavidfriedrich.de/auth/google/callback`.
- **iOS**: bundle `de.timdavidfriedrich.bookMarker`.
- **Android debug** and **Android upload**: package
  `de.timdavidfriedrich.book_marker`. One SHA-1 per client, which is why there
  are two.

A third Android client is needed once the app ships through Play, using the
SHA-1 from Play Console under Setup, App signing. Google re-signs the upload,
so without it sign-in fails only for users who installed from Play, and works
everywhere in testing.

Fingerprints:

```bash
keytool -list -v -alias androiddebugkey -keystore ~/.android/debug.keystore \
  -storepass android -keypass android | grep SHA1
keytool -list -v -alias upload -keystore ~/keys/commonplace-upload.jks | grep SHA1
```

## Publishing status

The consent screen is in **Testing**, so only accounts listed under Audience,
Test users can sign in. Everyone else gets `access_denied`. Limit is 100.

Publishing needs a homepage URL and a privacy policy, deferred. It will not need
Google's verification review: the app requests only
`userinfo.email` and `userinfo.profile`, both non-sensitive. Verification applies
to sensitive and restricted scopes.

Google expires refresh tokens after 7 days while an app is in Testing. It should
not surface here, because Google is used only for the initial exchange and
Serverpod issues its own session token afterwards. It would start to matter if
`getExtraGoogleInfoCallback` were added to keep calling Google APIs.

## Apple, deferred

Needs a paid Apple Developer account. When it exists:

1. App ID for `de.timdavidfriedrich.bookMarker` with Sign in with Apple enabled
   -> `appleBundleIdentifier`.
2. A **Services ID**, which is not the bundle ID, for example
   `de.timdavidfriedrich.bookMarker.signin` -> `appleServiceIdentifier` and the
   `APPLE_SERVICE_IDENTIFIER` dart-define.
3. A Key with Sign in with Apple enabled. The `.p8` downloads **once** ->
   `appleKey`, its id -> `appleKeyId`.
4. Team ID -> `appleTeamId`.
5. `appleAndroidPackageIdentifier` = `de.timdavidfriedrich.book_marker`, or the
   Android callback returns 500.
6. Return URL, both `appleRedirectUri` and `APPLE_REDIRECT_URI`:
   `https://book-marker-api.timdavidfriedrich.de/appleIdp/callback`
7. Add the Sign in with Apple capability to the Runner target in Xcode.

Until then the Apple button is hidden, driven by `hasAppleSignIn` in
`build_config.dart`, and the server registers only the providers whose
credentials are present.

**App Store review requires Sign in with Apple wherever another social sign-in
is offered.** An Android-only release is fine without it; an iOS release is not.
