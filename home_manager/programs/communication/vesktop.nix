{ pkgs, makeDesktopItem, ...}:

(pkgs.vesktop.overrideAttrs (oldAttrs: rec {
  
  desktopItems = [
    (pkgs.makeDesktopItem {
      name = "Clementine";w
      exec = "vesktop %u";
      icon = "clementine";
      desktopName = "Clementine";
    })
  ];
}))