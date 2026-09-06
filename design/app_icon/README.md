# App icon source art

A glyph on a solid background. Everything under `ios/Runner/AppIcon.icon`,
`android/.../mipmap-*` and `generated/` is produced from the files here:

    python3 tool/generate_app_icons.py

Never hand-edit a generated icon — the next run overwrites it.

## Sources

| File | Form |
|---|---|
| `glyph.png` / `glyph-dark.png` | 1024x1024 PNG-24, transparent, artwork in final position |
| `mono.png` | same alpha, pure white — drives the Android themed icon |
| `glyph.svg` / `glyph-dark.svg` | vector originals, kept for re-export |
| `colors.json` | background + glyph hex, light and dark |

All three PNGs share one alpha bounding box (`358,0 -> 905,382`), so the glyph
sits identically across variants. The mark is cut flat at the top on purpose: it
bleeds off the icon's top edge.

## What each platform gets

**iOS** — `ios/Runner/AppIcon.icon`, an Icon Composer package written by hand
(`icon.json` + `Assets/`). The artwork is used exactly as designed; the squircle
mask handles the top bleed. One group, one layer, `glass: false` — the specular
pass visibly blurs a mark this bold at launcher sizes. Light and dark are
`image-name-specializations`; the tinted appearance is derived by `actool`, which
also emits the flat iOS 13-18 fallbacks. There is no `AppIcon.appiconset` any
more; the `.icon` replaces it.

**Android** — adaptive icon with `<background>`, `<foreground>` and
`<monochrome>` across five densities, plus legacy `ic_launcher.png` for API
24-25. The composition mirrors iOS: the mark sits upper-right and is cut by the
launcher mask.

**Play listing** — `generated/play_store_512.png`, 512x512, no alpha, no rounded
corners (Play adds them). Matches the iOS composition.

## The Android placement trade-off

Android guarantees only the centred 66dp of the 108dp canvas is never clipped;
the mask itself is at most 72dp. The chosen placement puts ~6% of the mark
outside that, across the tops of both lobes, so the cut varies slightly between
launcher mask shapes (a circle also trims the right lobe's outer edge; squircle
and rounded square do not). This is deliberate — it echoes the iOS top bleed.

`_android_placement_options.png` compares it against three clip-free variants of
the same composition. To switch, change `GLYPH_WIDTH_FRAC` / `GLYPH_CENTER` in
`tool/generate_app_icons.py`; the alternatives are listed in a comment there.

## Rules if the artwork changes

- Glyph only. No background plate, no rounded corners, no shadow, no gloss —
  every platform applies its own mask and container.
- Keep the three PNG variants sharing one alpha bounding box.
- Outline text before exporting SVG (Icon Composer reports `svg-contains-text`).
- Re-run the generator, then rebuild both platforms to confirm.
