#!/usr/bin/env python3
"""Generate every platform app-icon asset from design/app_icon/.

Run after changing anything in design/app_icon/:

    python3 tool/generate_app_icons.py

Nothing under ios/Runner/AppIcon.icon or android/.../mipmap-* is hand-editable;
this script owns those files.
"""

from __future__ import annotations

import json
import shutil
from pathlib import Path

from PIL import Image

ROOT = Path(__file__).resolve().parent.parent
SRC = ROOT / "design" / "app_icon"
IOS_ICON = ROOT / "ios" / "Runner" / "AppIcon.icon"
ANDROID_RES = ROOT / "android" / "app" / "src" / "main" / "res"
GENERATED = SRC / "generated"

# Android adaptive geometry, in dp on the 108dp canvas.
CANVAS_DP = 108
VISIBLE_DP = 72  # anything outside this is always masked away
SAFE_DP = 66  # guaranteed never clipped by an OEM mask

# Android glyph placement, as fractions of the 108dp canvas.
#
# This deliberately mirrors the iOS composition: the mark sits upper-right and is
# cut by the launcher mask, echoing the way it bleeds off the top edge on iOS.
# It is a design choice, not an oversight — it puts ~6% of the mark outside the
# 72dp mask, and the exact cut varies slightly between launcher mask shapes.
#
# For a clip-free variant keeping the same composition, use one of:
#   GLYPH_WIDTH_FRAC, GLYPH_CENTER = 0.406, (0.521, 0.432)   # 416px, clip-free
#   GLYPH_WIDTH_FRAC, GLYPH_CENTER = 0.436, (0.515, 0.451)   # 446px, clip-free
#   GLYPH_WIDTH_FRAC, GLYPH_CENTER = 0.505, (0.500, 0.500)   # 517px, centred
GLYPH_WIDTH_FRAC = 0.440
GLYPH_CENTER = (0.560, 0.305)

DENSITIES = {  # suffix -> scale factor against mdpi
    "mdpi": 1,
    "hdpi": 1.5,
    "xhdpi": 2,
    "xxhdpi": 3,
    "xxxhdpi": 4,
}


def hex_to_rgb(value: str) -> tuple[int, int, int]:
    h = value.lstrip("#")
    return tuple(int(h[i : i + 2], 16) for i in (0, 2, 4))  # type: ignore[return-value]


def hex_to_extended_srgb(value: str, alpha: float = 1.0) -> str:
    r, g, b = (c / 255 for c in hex_to_rgb(value))
    return f"extended-srgb:{r:.5f},{g:.5f},{b:.5f},{alpha:.5f}"


def load_colors() -> dict[str, str]:
    return json.loads((SRC / "colors.json").read_text())


def trimmed(path: Path) -> Image.Image:
    """Load a glyph and crop to its alpha bounding box."""
    img = Image.open(path).convert("RGBA")
    box = img.getchannel("A").getbbox()
    if box is None:
        raise SystemExit(f"{path} is fully transparent")
    return img.crop(box)


def recolor(glyph: Image.Image, color: str) -> Image.Image:
    """Replace RGB with `color`, keeping the alpha channel."""
    solid = Image.new("RGBA", glyph.size, hex_to_rgb(color) + (255,))
    solid.putalpha(glyph.getchannel("A"))
    return solid


def place(glyph: Image.Image, canvas: int, width_frac: float,
          center: tuple[float, float] = (0.5, 0.5), bg=None) -> Image.Image:
    """Place `glyph` on a square canvas at `center`, scaled to `width_frac` of it."""
    out = Image.new("RGBA", (canvas, canvas), bg or (0, 0, 0, 0))
    target_w = round(canvas * width_frac)
    scale = target_w / glyph.width
    size = (target_w, max(1, round(glyph.height * scale)))
    out.alpha_composite(
        glyph.resize(size, Image.LANCZOS),
        (round(canvas * center[0] - size[0] / 2), round(canvas * center[1] - size[1] / 2)),
    )
    return out


def to_visible_area(width_frac: float, center: tuple[float, float]):
    """Re-express a 108dp-canvas placement against the 72dp visible area.

    Legacy (pre-API-26) icons and the Play listing icon show a plain square, so
    the glyph must be rescaled to keep the same apparent size and position as it
    has inside the adaptive icon.
    """
    k = CANVAS_DP / VISIBLE_DP
    inset = (CANVAS_DP - VISIBLE_DP) / 2 / CANVAS_DP
    return width_frac * k, tuple((c - inset) * k for c in center)


# --------------------------------------------------------------------------- iOS


def build_ios(colors: dict[str, str]) -> None:
    """Write the Icon Composer package.

    The iOS composition is the artwork exactly as designed — the glyph bleeds off
    the top edge, which the squircle mask handles gracefully. Only Android needs
    the safe-zone re-layout.
    """
    assets = IOS_ICON / "Assets"
    if IOS_ICON.exists():
        shutil.rmtree(IOS_ICON)
    assets.mkdir(parents=True)

    shutil.copy2(SRC / "glyph.png", assets / "glyph.png")
    shutil.copy2(SRC / "glyph-dark.png", assets / "glyph-dark.png")

    icon = {
        "fill-specializations": [
            {"value": {"solid": hex_to_extended_srgb(colors["background"])}},
            {"appearance": "dark",
             "value": {"solid": hex_to_extended_srgb(colors["background-dark"])}},
        ],
        "groups": [
            {
                "layers": [
                    {
                        "name": "glyph",
                        # Deliberately flat: the specular/refraction pass blurs a
                        # bold mark like this at launcher sizes.
                        "glass": False,
                        "image-name-specializations": [
                            {"value": "glyph.png"},
                            {"appearance": "dark", "value": "glyph-dark.png"},
                        ],
                    }
                ],
                "shadow": {"kind": "neutral", "opacity": 0.5},
                "translucency": {"enabled": False, "value": 0.5},
            }
        ],
        "supported-platforms": {"squares": "shared"},
    }
    (IOS_ICON / "icon.json").write_text(json.dumps(icon, indent=2, sort_keys=True) + "\n")
    print(f"  ios      {IOS_ICON.relative_to(ROOT)}  (icon.json + 2 layers)")


# ----------------------------------------------------------------------- Android


def build_android(colors: dict[str, str]) -> None:
    glyph = trimmed(SRC / "glyph.png")
    mono = trimmed(SRC / "mono.png")

    fg_glyph = recolor(glyph, colors["glyph"])
    mono_glyph = recolor(mono, "#000000")  # system tints this; only alpha matters

    legacy_frac, legacy_center = to_visible_area(GLYPH_WIDTH_FRAC, GLYPH_CENTER)
    bg = hex_to_rgb(colors["background"]) + (255,)

    for name, factor in DENSITIES.items():
        d = ANDROID_RES / f"mipmap-{name}"
        d.mkdir(parents=True, exist_ok=True)

        adaptive_px = round(CANVAS_DP * factor)
        place(fg_glyph, adaptive_px, GLYPH_WIDTH_FRAC, GLYPH_CENTER).save(
            d / "ic_launcher_foreground.png")
        place(mono_glyph, adaptive_px, GLYPH_WIDTH_FRAC, GLYPH_CENTER).save(
            d / "ic_launcher_monochrome.png")

        legacy_px = round(48 * factor)
        place(fg_glyph, legacy_px, legacy_frac, legacy_center, bg=bg).convert("RGB").save(
            d / "ic_launcher.png")

    (ANDROID_RES / "mipmap-anydpi-v26").mkdir(parents=True, exist_ok=True)
    (ANDROID_RES / "mipmap-anydpi-v26" / "ic_launcher.xml").write_text(
        '<?xml version="1.0" encoding="utf-8"?>\n'
        '<adaptive-icon xmlns:android="http://schemas.android.com/apk/res/android">\n'
        '    <background android:drawable="@color/ic_launcher_background" />\n'
        '    <foreground android:drawable="@mipmap/ic_launcher_foreground" />\n'
        '    <monochrome android:drawable="@mipmap/ic_launcher_monochrome" />\n'
        "</adaptive-icon>\n"
    )
    (ANDROID_RES / "values" / "ic_launcher_background.xml").write_text(
        '<?xml version="1.0" encoding="utf-8"?>\n'
        "<resources>\n"
        f'    <color name="ic_launcher_background">{colors["background"]}</color>\n'
        "</resources>\n"
    )
    print(f"  android  {len(DENSITIES)} densities x 3 layers + adaptive xml + colour")


# -------------------------------------------------------------------- store copy


def build_store(colors: dict[str, str]) -> None:
    """Play listing icon: 512x512, 32-bit, no alpha, no rounded corners."""
    GENERATED.mkdir(parents=True, exist_ok=True)
    bg = hex_to_rgb(colors["background"]) + (255,)
    # Use the source artwork as-is: the Play listing shows a plain square, so it
    # should match the iOS icon rather than the safe-zone Android layout.
    art = Image.open(SRC / "glyph.png").convert("RGBA")
    out_img = Image.new("RGBA", art.size, bg)
    out_img.alpha_composite(art)
    out = GENERATED / "play_store_512.png"
    out_img.resize((512, 512), Image.LANCZOS).convert("RGB").save(out)
    print(f"  store    {out.relative_to(ROOT)}  (matches the iOS composition)")


def main() -> None:
    colors = load_colors()
    print("generating app icons from design/app_icon/")
    build_ios(colors)
    build_android(colors)
    build_store(colors)
    print("done")


if __name__ == "__main__":
    main()
