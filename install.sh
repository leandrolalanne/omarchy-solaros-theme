#!/usr/bin/env bash
#
# Install SolarOS from this repository.
#
# This repo is the single source of truth: everything SolarOS touches on a
# machine is generated from here, so a fresh box only needs a clone and this
# script. Running it again is safe -- it overwrites what it owns and leaves
# everything else alone.
#
#   ./install.sh              theme + hooks + webapps + launchers + editor
#   ./install.sh --theme-only just the Omarchy theme, nothing else
#
set -euo pipefail

SRC=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)

CONFIG=${XDG_CONFIG_HOME:-$HOME/.config}
DATA=${XDG_DATA_HOME:-$HOME/.local/share}
BIN=$HOME/.local/bin

THEME_DIR=$CONFIG/omarchy/themes/solaros
WEBAPP_WA=$CONFIG/omarchy/webapps/encom-communications/whatsapp-slim-encom
WEBAPP_TIDAL=$CONFIG/omarchy/webapps/encom-audio/tidal-encom
BRANDING_DIR=$CONFIG/omarchy/branding
HOOK_DIR=$CONFIG/omarchy/hooks

theme_only=false
[[ ${1:-} == --theme-only ]] && theme_only=true

say() { printf '  %s\n' "$*"; }

# ---------------------------------------------------------------- the theme
# Everything Omarchy itself reads. Note that hyprland.lua is deliberately
# copied here: Omarchy strips it from any theme it installed by URL, which is
# exactly the problem this script exists to solve.
say "theme -> $THEME_DIR"
mkdir -p "$THEME_DIR"
for f in colors.toml ghostty.conf hyprland.lua btop.theme icons.theme \
         gtk-4.0.css obsidian.css shell.bar.toml shell.launcher.toml \
         shell.notifications.toml STYLE.md preview.png preview-alt.png; do
  install -Dm 644 "$SRC/$f" "$THEME_DIR/$f"
done
rm -rf "$THEME_DIR/backgrounds" "$THEME_DIR/assets"
cp -a "$SRC/backgrounds" "$SRC/assets" "$THEME_DIR/"

if $theme_only; then
  say "done -- run: omarchy theme set solaros"
  exit 0
fi

# ---------------------------------------------------------------- the hooks
# theme-set.d runs on every theme switch; post-boot.d runs once at login,
# because a switch that happened before the compositor was up leaves nothing
# applied. Both directories get the same Hyprland hook on purpose.
say "hooks -> $HOOK_DIR"
mkdir -p "$HOOK_DIR/theme-set.d" "$HOOK_DIR/post-boot.d"
for h in solaros-hyprland-opacity solaros-whatsapp solaros-tidal; do
  install -Dm 755 "$SRC/hooks/$h" "$HOOK_DIR/theme-set.d/$h"
done
install -Dm 755 "$SRC/hooks/solaros-hyprland-opacity" "$HOOK_DIR/post-boot.d/solaros-hyprland-opacity"

# ------------------------------------------------------------------ nautilus
# Omarchy generates $CONFIG/gtk-4.0/gtk.css as a thin importer of the palette
# it derives from colors.toml. The theme's own Nautilus rules live alongside
# it in gtk-4.0.css, so they need a second import. Only SolarOS ships that
# file, so on any other theme the import simply does not resolve and GTK
# ignores it -- which is the whole scoping mechanism.
GTK_CSS=$CONFIG/gtk-4.0/gtk.css
GTK_IMPORT='@import url("file://'$HOME'/.local/state/omarchy/current/theme/gtk-4.0.css");'
mkdir -p "$CONFIG/gtk-4.0"
if [[ ! -f $GTK_CSS ]]; then
  printf '%s\n' "$GTK_IMPORT" > "$GTK_CSS"
  say "nautilus -> $GTK_CSS (created)"
elif ! grep -qF 'current/theme/gtk-4.0.css' "$GTK_CSS"; then
  # @import has to precede every other rule, so it goes in at the top.
  printf '%s\n%s\n' "$GTK_IMPORT" "$(cat "$GTK_CSS")" > "$GTK_CSS"
  say "nautilus -> $GTK_CSS (import added)"
else
  say "nautilus -> $GTK_CSS (already imported)"
fi

# ------------------------------------------------------------- the launchers
say "scripts -> $BIN"
for b in "$SRC"/bin/*; do
  install -Dm 755 "$b" "$BIN/$(basename "$b")"
done
install -Dm 755 "$SRC/extras/omarchy-terminal-welcome" "$BIN/omarchy-terminal-welcome"
install -Dm 644 "$SRC/extras/solaros-ascii.txt" "$BRANDING_DIR/solaros-ascii.txt"
install -Dm 644 "$SRC/applications/solaros-whatsapp.desktop" "$DATA/applications/solaros-whatsapp.desktop"

# -------------------------------------------------------------- the webapps
# active.css is not in the repo: it is a copy of whichever palette matches the
# current theme, and the two *-theme scripts below regenerate it.
# The directory names are the ones Chromium has registered. It tracks unpacked
# extensions by absolute path, so renaming these unloads them until someone
# re-adds them by hand -- not worth the tidier name.
say "webapps -> $WEBAPP_WA"
say "           $WEBAPP_TIDAL"
for pair in "webapps/whatsapp-slim-encom:$WEBAPP_WA" "webapps/tidal-encom:$WEBAPP_TIDAL"; do
  src=${pair%%:*}; dst=${pair#*:}
  mkdir -p "$(dirname "$dst")"
  rm -rf "$dst"
  cp -a "$SRC/$src" "$dst"
done
"$BIN/solaros-whatsapp-theme" >/dev/null
"$BIN/solaros-tidal-theme" >/dev/null

# --------------------------------------------------------------- the editor
say "vscode -> $HOME/.vscode/extensions/solaros.solaros-phosphor-1.0.0"
rm -rf "$HOME/.vscode/extensions/solaros.solaros-phosphor-1.0.0"
cp -a "$SRC/vscode" "$HOME/.vscode/extensions/solaros.solaros-phosphor-1.0.0"

# -------------------------------------------------------------- the keyboard
if [[ -d $CONFIG/OpenRGB ]]; then
  say "openrgb -> $CONFIG/OpenRGB/solaros-keyboard.orp"
  install -Dm 644 "$SRC/openrgb/solaros-keyboard.orp" "$CONFIG/OpenRGB/solaros-keyboard.orp"
fi

cat <<EOF

Installed. Two things this script cannot do for you:

  1. omarchy theme set solaros

  2. The two browser extensions are unpacked, and Chromium tracks those by
     absolute path -- it will not find them on its own. In each webapp
     window open chrome://extensions, turn on Developer mode, then
     "Load unpacked" and pick:

       $WEBAPP_WA
       $WEBAPP_TIDAL

EOF
