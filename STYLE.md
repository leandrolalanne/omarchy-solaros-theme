# SolarOS visual contract

What this theme assumes about type, and where it applies it. Kept because the
choices are deliberate, not defaults.

## Typography

Everything that receives the SolarOS treatment uses **JetBrainsMono Nerd Font**.
It stands in for software running inside the fiction.

**The theme cannot set this for you.** Fonts in Omarchy are global — `omarchy
font set` rewrites every terminal config and `fontconfig` at once, and no theme
touches any of it. The font is not shipped here either: it is a package, it
updates on its own, and no theme should be handing out megabytes of someone
else's typeface.

```bash
omarchy pkg add ttf-jetbrains-mono-nerd
omarchy font set "JetBrainsMono Nerd Font"
```

`ttf-jetbrains-mono-nerd-basic` works too and is smaller. JetBrains Mono is by
JetBrains under the SIL Open Font License; the Nerd Fonts patch adds the icon
glyphs.

Keep icon glyphs and emoji on their own fallback fonts. Replacing those breaks
rendering rather than restyling it.

## Where it lands

| Surface | How |
|---|---|
| Omarchy shell, terminals | resolve the system `monospace` alias |
| Nautilus and other GTK4 apps | `gtk-4.0.css` declares the family |
| Obsidian | `obsidian.css` |
| btop | `btop.theme` — colours only, the font follows the terminal |

## Borrowed names

`ENCOM` in the terminal banner is a name out of *Tron*, not a design element:
it is set in the same JetBrainsMono as everything around it and gets no
special treatment. Nothing here reproduces anyone's trademark artwork.

This is a fan theme; see [CREDITS.md](CREDITS.md).
