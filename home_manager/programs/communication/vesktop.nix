{ pkgs, makeDesktopItem, ...}:

(pkgs.vesktop.overrideAttrs (oldAttrs: rec {
  
  desktopItems = [
    (pkgs.makeDesktopItem {
      name = "Clementine";
      exec = "vesktop %u";
      icon = "clementine";
      desktopName = "Clementine";
    })
  ];
}))