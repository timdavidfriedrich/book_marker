# book_marker

Flutter app for marking quotes in physical books: photograph a page, recognise the text,
select the passage, save it to a book.

## Setup

FVM is mandatory — every Flutter and Dart command runs through it.

```bash
fvm flutter pub get
```

Code generation runs per package, member packages before the app package:

```bash
for package in packages/* .; do
  grep -q "build_runner" "$package/pubspec.yaml" || continue
  (cd "$package" && fvm dart run build_runner build)
done
```

Localisation lives in `packages/shared`:

```bash
cd packages/shared && fvm flutter gen-l10n
```

### iOS

`google_mlkit_text_recognition` has no Swift Package Manager support, so CocoaPods is used
alongside SPM. Run `pod install` once after cloning, **before** the first build — otherwise
CocoaPods installs during the build, after Xcode has already resolved the dependency graph,
and linking fails with `Framework 'Pods_Runner' not found`.

```bash
cd ios && pod install
```

Minimum deployment target is iOS 15.5, required by `google_mlkit_commons`.

## Structure

`core` ← `shared` ← `feature_*` ← app. Dependencies are strict and acyclic; a feature never
imports another feature. Each package is cut by layer (`data/`, `domain/`, `presentation/`),
except `core` and the app package, which are cut by capability.

Entities live in `packages/shared/lib/domain/entities/`. UI talks only to a Bloc or Cubit,
never to a repository or use case directly.
