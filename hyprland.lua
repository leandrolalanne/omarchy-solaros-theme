local active_border_color = { colors = { "rgba(8fffe3ee)", "rgba(52cdb5cc)" }, angle = 90 }
local inactive_border_color = "rgba(174a4066)"

hl.config({
  general = {
    col = {
      active_border = active_border_color,
      inactive_border = inactive_border_color,
    },
  },

  group = {
    col = {
      border_active = active_border_color,
      border_inactive = inactive_border_color,
    },
  },

  decoration = {
    -- Translucidez pareja para todas las ventanas (WhatsApp sube a 0.95 abajo).
    active_opacity = 0.88,
    inactive_opacity = 0.88,

    -- Sin difuminado: SolarOS es translucidez pareja, no vidrio. Hyprland
    -- trae blur activado por defecto, asi que hay que apagarlo explicitamente.
    blur = {
      enabled = false,
    },

    shadow = {
      enabled = true,
      range = 5,
      render_power = 3,
      color = "rgba(52cdb530)",
      color_inactive = "rgba(00030320)",
    },
  },
})

-- Solo se carga mientras SolarOS es el tema activo.
-- WhatsApp queda más sólido que el resto para que el chat se lea.
o.window("^chrome-web\\.whatsapp\\.com__-Default$", {
  opacity = "0.95 override 0.95 override 0.95 override",
  rounding = 0,
})

-- Superficies del shell: blur = false para que ninguna quede difuminada si
-- otro tema dejo el blur global encendido.
hl.layer_rule({
  name = "solaros-shell-surfaces",
  match = {
    namespace = "^(omarchy-bar|omarchy-menu|omarchy-notifications|omarchy-osd|omarchy-reminders|omarchy-polkit|omarchy-network-qr|omarchy-image-selector|omarchy-emojis|omarchy-clipboard|omarchy-keyboard-panel|omarchy-lock-preview)$",
  },
  blur = false,
  blur_popups = false,
  ignore_alpha = 0.10,
  xray = false,
})
