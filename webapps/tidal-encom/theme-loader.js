/* Keep the TIDAL palette synchronized with the active Omarchy theme. */
(() => {
  const styleId = "solaros-tidal-live-palette";
  let lastCss = "";

  async function refreshPalette() {
    try {
      const url = `${chrome.runtime.getURL("active.css")}?v=${Date.now()}`;
      const response = await fetch(url, { cache: "no-store" });
      const css = await response.text();
      const enabled = /--solaros-enabled:\s*1\b/.test(css);

      document.documentElement.toggleAttribute("data-solaros-theme", enabled);

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
      // Extension resources may be briefly unavailable during browser startup.
    }
  }

  refreshPalette();
  setInterval(refreshPalette, 2000);
})();
