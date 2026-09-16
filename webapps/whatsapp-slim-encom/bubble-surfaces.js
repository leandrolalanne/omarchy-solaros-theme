/*
 * Find the painted message surface without relying on WhatsApp's obfuscated
 * inner class names. This script reads only element styles and geometry; it
 * never reads, stores, or transmits message text.
 */
(() => {
  const surfaceAttribute = "data-solaros-bubble-surface";
  let scanScheduled = false;

  function hasPaintedBackground(element) {
    const color = getComputedStyle(element).backgroundColor;
    return color !== "transparent" &&
      color !== "rgba(0, 0, 0, 0)" &&
      color !== "rgba(0,0,0,0)";
  }

  function surfaceFor(wrapper) {
    const candidates = new Set();
    for (const element of wrapper.querySelectorAll("div")) {
      if (hasPaintedBackground(element)) {
        const rectangle = element.getBoundingClientRect();
        if (rectangle.width >= 20 && rectangle.height >= 18) {
          candidates.add(element);
        }
      }
    }

    let best = null;
    let bestArea = 0;

    for (const candidate of candidates) {
      const rectangle = candidate.getBoundingClientRect();
      const area = rectangle.width * rectangle.height;
      if (area > bestArea) {
        best = candidate;
        bestArea = area;
      }
    }

    return best;
  }

  function markDirection(direction) {
    const wrappers = document.querySelectorAll(`.message-${direction}`);

    for (const wrapper of wrappers) {
      if (!wrapper.querySelector(`[${surfaceAttribute}]`)) {
        const surface = surfaceFor(wrapper);
        if (surface) surface.setAttribute(surfaceAttribute, direction);
      }
    }
  }

  function scan() {
    scanScheduled = false;
    markDirection("out");
    markDirection("in");
  }

  function scheduleScan() {
    if (scanScheduled) return;
    scanScheduled = true;
    requestAnimationFrame(scan);
  }

  function start() {
    scan();
    new MutationObserver(scheduleScan).observe(document.documentElement, {
      childList: true,
      subtree: true
    });
    setInterval(scan, 2000);
  }

  if (document.readyState === "loading") {
    document.addEventListener("DOMContentLoaded", start, { once: true });
  } else {
    start();
  }
})();
