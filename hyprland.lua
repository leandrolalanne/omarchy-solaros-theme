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

    -- Blur desactivado a pedido: ENCOM se queda con la translucidez pareja
    -- de 0.88 y sin difuminado. Los valores de abajo quedan como estaban por
    -- si alguna vez se vuelve a poner enabled = true.
    blur = {
      enabled = false,
      size = 8,
      passes = 2,
      noise = 0,
      contrast = 1.0,
      brightness = 1.0,
      vibrancy = 0.1,
      vibrancy_darkness = 0,
      ignore_opacity = true,
      new_optimizations = true,
      xray = false,
      special = true,
      popups = true,
      popups_ignorealpha = 0.15,
      input_methods = true,
      input_methods_ignorealpha = 0.15,
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

-- SolarOS glass effect: only loaded while the Encom theme is active.
-- WhatsApp queda más sólido que el resto para que el chat se lea.
o.window("^chrome-web\\.whatsapp\\.com__-Default$", {
  opacity = "0.95 override 0.95 override 0.95 override",
  rounding = 0,
})

-- Regla de capas de las superficies del shell. blur = false: ENCOM no usa
-- difuminado; la regla se mantiene para conservar el match si se reactiva.
hl.layer_rule({
  name = "solaros-shell-glass",
  match = {
    namespace = "^(omarchy-bar|omarchy-menu|omarchy-notifications|omarchy-osd|omarchy-reminders|omarchy-polkit|omarchy-network-qr|omarchy-image-selector|omarchy-emojis|omarchy-clipboard|omarchy-keyboard-panel|omarchy-lock-preview)$",
  },
  blur = false,
  blur_popups = false,
  ignore_alpha = 0.10,
  xray = false,
})
