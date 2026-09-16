/* Own the live palette and reload it after an Omarchy theme set. */
(() => {
  const styleId = "solaros-whatsapp-live-palette";
  let lastCss = "";

  async function refreshPalette() {
    try {
      const url = `${chrome.runtime.getURL("active.css")}?v=${Date.now()}`;
      const response = await fetch(url, { cache: "no-store" });
      const css = await response.text();

      const enabled = /--solaros-enabled:\s*1\b/.test(css);
      if (enabled) {
        document.documentElement.setAttribute("data-solaros-theme", "true");
      } else {
        document.documentElement.removeAttribute("data-solaros-theme");
      }

      if (!css || css === lastCss) return;

      let style = document.getElementById(styleId);
      if (!style) {
        style = document.createElement("style");
        style.id = styleId;
        (document.head || document.documentElement).appendChild(style);
      }

      style.textContent = css;
      lastCss = css;
    } catch (_) {
      // Extension resources can be briefly unavailable during browser startup.
    }
  }

  refreshPalette();
  setInterval(refreshPalette, 2000);
})();
