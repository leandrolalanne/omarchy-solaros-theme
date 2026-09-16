# ENCOM / SolarOS visual contract

## Typography

All operational UI that receives ENCOM/SolarOS visual treatment uses `JetBrainsMono Nerd Font` as its primary family. It represents software running inside the fictional SolarOS environment; it is not a replacement for ENCOM's canonical brand typography.

- Native/terminal family: `JetBrainsMono Nerd Font`
- Web stack: `"JetBrainsMono Nerd Font", "JetBrains Mono", "IBM Plex Mono", "Noto Color Emoji", monospace`
- Keep icon glyphs and emoji on their required fallback fonts when replacing them would break rendering.
- Apply the family only with the ENCOM/SolarOS layer when the integration is theme-scoped; neutral modes must remain neutral.

## Branding boundary

- ENCOM logos, wordmarks, proportions, and established brand typography remain canonical and must not be restyled to match the SolarOS UI font.
- Treat JetBrains Mono as diegetic operating-system typography: terminals, controls, labels, status text, application content, and technical annotations.
- Brand marks embedded in wallpapers, icons, launchers, or application chrome preserve their original approved construction.

## Coverage

- Omarchy shell and terminal applications resolve the system `monospace` alias, currently `JetBrainsMono Nerd Font`.
- Nautilus declares the family in `gtk-4.0.css`.
- WhatsApp and TIDAL declare the web stack in their ENCOM extension CSS.
- Obsidian receives the family from this theme's `obsidian.css`.
- VS Code's editor and integrated terminal resolve the system `monospace` alias; the SolarOS color theme remains color-only because VS Code color themes do not own the workbench font family.
- Operational and technical text in ENCOM SVG backgrounds uses the SolarOS UI family; ENCOM logos and wordmarks preserve their canonical brand typography.
