{ pkgs, ... }:

(pkgs.vesktop.overrideAttrs (oldAttrs: {

  desktopItems = [
    (pkgs.makeDesktopItem {
      name = "Clementine";
      exec = "vesktop %u";
      icon = "clementine";
      desktopName = "Clementine";
    })
  ];
}))
