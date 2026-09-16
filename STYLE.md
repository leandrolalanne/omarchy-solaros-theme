# SolarOS visual contract

What this theme assumes about type, and where it applies it. Kept because the
choices are deliberate, not defaults.

## Typography

Everything that receives the SolarOS treatment uses **JetBrainsMono Nerd Font**.
It stands in for software running inside the fiction; it is not a claim about
ENCOM's own brand typography.

**The theme cannot set this for you.** Fonts in Omarchy are global — `omarchy
font set` rewrites every terminal config and `fontconfig` at once, and no theme
touches any of it. If you want the type to match the screenshots:

```bash
omarchy font set "JetBrainsMono Nerd Font"
```

Keep icon glyphs and emoji on their own fallback fonts. Replacing those breaks
rendering rather than restyling it.

## Where it lands

| Surface | How |
|---|---|
| Omarchy shell, terminals | resolve the system `monospace` alias |
| Nautilus and other GTK4 apps | `gtk-4.0.css` declares the family |
| Obsidian | `obsidian.css` |
| btop | `btop.theme` — colours only, the font follows the terminal |

## Branding boundary

The ENCOM wordmark in `assets/` keeps its original construction: proportions,
letterforms and spacing are not restyled to match the UI font. Treat
JetBrainsMono as the operating system's type — terminals, labels, status text,
technical annotations — and leave the mark alone.

This is a fan theme; see [CREDITS.md](CREDITS.md).
