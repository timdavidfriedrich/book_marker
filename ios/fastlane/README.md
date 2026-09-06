fastlane documentation
----

# Installation

Make sure you have the latest version of the Xcode command line tools installed:

```sh
xcode-select --install
```

For _fastlane_ installation instructions, see [Installing _fastlane_](https://docs.fastlane.tools/#installing-fastlane)

# Available Actions

## iOS

### ios doctor

```sh
[bundle exec] fastlane ios doctor
```

Report what iOS release automation still needs

### ios build_dev

```sh
[bundle exec] fastlane ios build_dev
```

Unsigned release build - verifies the app compiles, needs no account

### ios certificates

```sh
[bundle exec] fastlane ios certificates
```

Sync signing certificates and profiles via match

### ios build_ipa

```sh
[bundle exec] fastlane ios build_ipa
```

Build a signed IPA

### ios beta

```sh
[bundle exec] fastlane ios beta
```

Build and upload to TestFlight

### ios release

```sh
[bundle exec] fastlane ios release
```

Build and submit to the App Store for review

----

This README.md is auto-generated and will be re-generated every time [_fastlane_](https://fastlane.tools) is run.

More information about _fastlane_ can be found on [fastlane.tools](https://fastlane.tools).

The documentation of _fastlane_ can be found on [docs.fastlane.tools](https://docs.fastlane.tools).
