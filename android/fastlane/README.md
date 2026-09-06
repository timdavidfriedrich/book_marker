fastlane documentation
----

# Installation

Make sure you have the latest version of the Xcode command line tools installed:

```sh
xcode-select --install
```

For _fastlane_ installation instructions, see [Installing _fastlane_](https://docs.fastlane.tools/#installing-fastlane)

# Available Actions

## Android

### android doctor

```sh
[bundle exec] fastlane android doctor
```

Verify everything needed for a release is in place

### android check

```sh
[bundle exec] fastlane android check
```

Static analysis (and tests, if any exist)

### android bump

```sh
[bundle exec] fastlane android bump
```

Bump the version. `type:` build (default), patch, minor or major.

### android sync_version_code

```sh
[bundle exec] fastlane android sync_version_code
```

Set versionCode to one above the highest already on Play

### android build_aab

```sh
[bundle exec] fastlane android build_aab
```

Build a signed release App Bundle

### android upload

```sh
[bundle exec] fastlane android upload
```

Upload to a track without building (internal by default)

### android internal

```sh
[bundle exec] fastlane android internal
```

Build and ship to internal testing

### android alpha

```sh
[bundle exec] fastlane android alpha
```

Build and ship to closed testing (alpha)

### android beta

```sh
[bundle exec] fastlane android beta
```

Build and ship to open testing (beta)

### android production

```sh
[bundle exec] fastlane android production
```

Build and ship to production. `rollout:` a fraction, e.g. 0.1 for 10%.

### android promote

```sh
[bundle exec] fastlane android promote
```

Move an existing build between tracks, e.g. from:internal to:beta

### android rollout

```sh
[bundle exec] fastlane android rollout
```

Increase the staged production rollout, e.g. rollout:0.5

### android metadata

```sh
[bundle exec] fastlane android metadata
```

Push store listing text and changelogs only - no binary

### android validate

```sh
[bundle exec] fastlane android validate
```

Dry run - build and validate against Play without publishing

----

This README.md is auto-generated and will be re-generated every time [_fastlane_](https://fastlane.tools) is run.

More information about _fastlane_ can be found on [fastlane.tools](https://fastlane.tools).

The documentation of _fastlane_ can be found on [docs.fastlane.tools](https://docs.fastlane.tools).
