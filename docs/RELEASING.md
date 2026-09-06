# Releasing Commonplace

Release automation is fastlane, one setup per platform:

- `android/fastlane` — complete and usable.
- `ios/fastlane` — scaffolded, blocked on an Apple Developer Program membership.

Check the current state at any time:

```bash
cd android && bundle exec fastlane android doctor
cd ios     && bundle exec fastlane ios doctor
```

Both lanes report what is missing and change nothing.

---

## Android

### One-time setup

Three things are needed, and all three are yours to create — nothing in the repo
can stand in for them.

**1. The upload keystore**

```bash
mkdir -p ~/keys
keytool -genkey -v -keystore ~/keys/commonplace-upload.jks \
  -keyalg RSA -keysize 2048 -validity 10000 -alias upload
```

Back the `.jks` up somewhere durable and outside the repo. Under Play App
Signing a lost upload key can be reset through Google support, but that is a
delay you do not want mid-release.

**2. `android/key.properties`**

Copy `android/key.properties.example` to `android/key.properties` and fill in
the passwords you just chose. The file is gitignored, as are `*.jks`/`*.keystore`.

Without it, `flutter build` falls back to debug keys and prints a warning; the
fastlane release lanes refuse to run at all.

**3. A Play Console service account**

1. Play Console → **Setup → API access** → link a Google Cloud project.
2. In Google Cloud Console create a service account, then create a **JSON key**
   for it.
3. Back in Play Console → **Users and permissions** → invite the service account
   address and grant *Release apps to testing tracks* plus *Release to
   production* for this app.
4. Save the JSON as `android/fastlane/play-store-key.json` (gitignored), or point
   `PLAY_STORE_JSON_KEY` at it elsewhere.

**4. Create the app and make the first release by hand**

The Play API cannot create an app listing, and it will not accept an upload for
an app that has never had one. Create the app in Play Console, then upload one
AAB manually:

```bash
cd android && bundle exec fastlane android build_aab
# then upload build/app/outputs/bundle/release/app-release.aab in the console
```

Every release after that can go through fastlane.

### Day to day

```bash
cd android

bundle exec fastlane android doctor          # is the setup complete?
bundle exec fastlane android check           # analyze (+ tests, when they exist)

bundle exec fastlane android bump            # 0.1.0+1 -> 0.1.0+2
bundle exec fastlane android bump type:minor # 0.1.0+1 -> 0.2.0+2

bundle exec fastlane android validate        # build + validate, publishes nothing
bundle exec fastlane android internal        # ship to internal testing
bundle exec fastlane android beta            # ship to open testing + metadata
bundle exec fastlane android production rollout:0.1   # 10% staged rollout

bundle exec fastlane android promote from:internal to:beta
bundle exec fastlane android rollout rollout:0.5      # widen the rollout
bundle exec fastlane android metadata        # listing text only, no binary
```

`validate` is the safe first move against a live account — it does a real build
and a real API round trip with `validate_only`, so it catches credential and
manifest problems without publishing.

### Versioning

Play requires a strictly increasing `versionCode`, which Flutter takes from the
`+N` suffix in `pubspec.yaml`. `bump` increments it. If the repo has fallen
behind what is already live — easy after a manual upload — `sync_version_code`
queries every track and sets it one above the highest.

### Store listing

`android/fastlane/metadata/android/<locale>/` holds the listing text for `en-US`
and `de-DE`. Character caps are 30 for the title, 80 for the short description
and 4000 for the full one; current text is well inside all three.

`images/icon.png` is written by `tool/generate_app_icons.py` — regenerate rather
than editing it. Screenshots go in `images/phoneScreenshots/` and are still
missing; Play needs at least two before a listing can go live.

---

## iOS

Everything past `build_dev` needs an Apple Developer Program membership
(99 USD/year). A free Apple ID signs a build onto an attached device for seven
days and nothing more — no App Store Connect record, no TestFlight, no
distribution certificate, so `match`, `pilot` and `deliver` all have nothing to
talk to.

Working now:

```bash
cd ios
bundle exec fastlane ios doctor      # what is still missing
bundle exec fastlane ios build_dev   # unsigned release build, no account needed
```

Once enrolled:

1. Enrol at <https://developer.apple.com/programs/>.
2. Create the App Store Connect record for `de.timdavidfriedrich.bookMarker`.
3. `export APPLE_ID="you@example.com"`.
4. Create an empty **private** git repo for certificates and put its URL in
   `ios/fastlane/Matchfile` (replacing the `REPLACE_ME` placeholder).
5. `bundle exec fastlane ios certificates` to populate it.
6. `bundle exec fastlane ios beta` for TestFlight.

Note that the bundle identifier still reads `bookMarker`. It is baked into the
App Store record on first submission and cannot be changed afterwards, so decide
before step 2 whether to rename it to something like
`de.timdavidfriedrich.commonplace`.

Remember `pod install` before the first build after a clone — see the README for
why the ordering matters.

---

## CI

`dart_defines.json` holds the Google Books API key and is deliberately not
committed, so any CI runner has to materialise it before building — write it
from a secret, using `dart_defines.example.json` for the shape. The same applies
to `android/key.properties`, the keystore, and the Play service account JSON.
