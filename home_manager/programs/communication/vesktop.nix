{ pkgs, ... }:

(pkgs.discord.override {
  withVencord = true;
  desktopName = "Clementine";
}).overrideAttrs (oldAttrs: {
  desktopItem = pkgs.makeDesktopItem {
    name = "clementine";
    exec = "discord";
    icon = "clementine";
    desktopName = "Clementine";
    genericName = "Chat Application";
    categories = [ "Network" "InstantMessaging" ];
    mimeTypes = [ "x-scheme-handler/discord" ];
    startupWMClass = "discord";
  };
})
