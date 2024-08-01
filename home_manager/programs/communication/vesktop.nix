{ pkgs, ...}:

(pkgs.vesktop.overrideAttrs (finalAttrs: previousAttrs: {
  desktopItems = [
    (makeDesktopItem {
      name = "Clementine";
      exec = "vesktop %u";
      icon = "clementine";
      desktopName = "Clementine";
    })
  ];
}))