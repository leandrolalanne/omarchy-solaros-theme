# SolarOS

A cold-phosphor desktop for [Omarchy](https://omarchy.org). Green on black,
evenly translucent, no blur — Flynn's basement, not a neon arcade.

![SolarOS](preview.png)

<details>
<summary>A second look — editor, system monitor, terminal, files</summary>

![SolarOS](preview-alt.png)

</details>

SolarOS is the operating system on Kevin Flynn's server in *Tron: Legacy* —
the prompt reads `SolarOS 4.0.1` when Sam wipes the dust off the terminal. This
is an unpaid fan project built around that look, released free under MIT. It is
not affiliated with Disney or with anyone else who owns a piece of *Tron*, and
it sells nothing. If a rights holder would rather it did not exist, say so and
it comes down.

## Install

**The whole thing** — theme, hooks, webapp skins, launchers, editor colours:

```bash
git clone https://github.com/leandrolalanne/omarchy-solaros-theme
cd omarchy-solaros-theme
./install.sh
omarchy theme set solaros
```

`install.sh` is idempotent: it overwrites what it owns and leaves everything
else alone, so re-running it after a `git pull` is how you update.

**Just the Omarchy theme**, if you only want the colours and wallpapers:

```bash
./install.sh --theme-only
```

## Why not `omarchy theme install`?

That works, and it is the shortest path to the palette:

```
omarchy theme install https://github.com/leandrolalanne/omarchy-solaros-theme
```

But Omarchy strips anything that executes code from a theme it installed by
URL and regenerates it from `colors.toml`. For this theme that means
**`hyprland.lua` is removed**, and with it the even 0.88 window opacity, the
gradient borders and the shadows. The palette survives; the depth does not.

Omarchy decides whether a theme is yours or cloned by looking for a `.git`
directory inside it — which is why `install.sh` copies files out of the clone
instead of making the clone itself the theme.

## The font

Not shipped. Fonts in Omarchy are global — `omarchy font set` rewrites every
terminal config at once, and no theme touches any of it. Two lines get you the
type in the screenshots:

```bash
omarchy pkg add ttf-jetbrains-mono-nerd
omarchy font set "JetBrainsMono Nerd Font"
```

## The browser extensions

`webapps/whatsapp` and `webapps/tidal` are unpacked MV3 extensions that restyle
WhatsApp Web and TIDAL to match the desktop. Chromium tracks unpacked
extensions by absolute path and will not pick them up on its own. Once per
machine, in each webapp window: `chrome://extensions` → Developer mode →
**Load unpacked** → point it at
`~/.config/omarchy/webapps/solaros/whatsapp` and `.../tidal`.

Both are theme-scoped. On any other theme the hooks swap in `neutral.css` and
the sites go back to stock.

## Nautilus

Omarchy writes `~/.config/gtk-4.0/gtk.css` as a thin importer of the libadwaita
palette it derives from `colors.toml`. This theme's own file manager rules are a
separate file, `gtk-4.0.css`, so `install.sh` adds a second import for it.

That import is how the scoping works: SolarOS is the only theme that ships a
`gtk-4.0.css`, so under any other theme the path does not resolve and GTK skips
it. Nothing to turn off.

## What is in here

| Path | What it is |
|---|---|
| `colors.toml` | The palette everything else is generated from |
| `ghostty.conf` | Terminal colours — regenerated from `colors.toml` on a URL install |
| `hyprland.lua` | Window opacity, borders, shadows. **Stripped on a URL install** |
| `btop.theme` · `icons.theme` | System monitor, icon set |
| `shell.*.toml` | Omarchy shell surfaces — bar, launcher, notifications |
| `gtk-4.0.css` | GTK4 apps, Nautilus included |
| `obsidian.css` | Obsidian |
| `backgrounds/` | Fifteen wallpapers, ordered flat grid → grid in perspective → scenes → abstract |
| `hooks/` | Re-apply the Hyprland opacity and the webapp palettes on every theme switch |
| `bin/` | The WhatsApp launcher and the two palette-swap scripts the hooks call |
| `webapps/` | The WhatsApp and TIDAL extensions |
| `applications/` | Desktop entry for the WhatsApp webapp |
| `vscode/` | SolarOS Phosphor 1984, the editor colour theme |
| `openrgb/` | Keyboard lighting profile |
| `extras/` | The terminal banner — branding, not theming |
| `STYLE.md` | The typography contract the whole suite follows |

Two files are generated rather than tracked: each webapp's `active.css` (a copy
of whichever palette matches the current theme, written by the hooks) and the
theme's `vscode.json` (written by Omarchy from `colors.toml`).

## Credits

Wallpapers and assets, with their origin, are listed in
[CREDITS.md](CREDITS.md).

## License

MIT for this project's own files — see [LICENSE](LICENSE). Wallpapers that came
from elsewhere keep their own terms; see [CREDITS.md](CREDITS.md).
