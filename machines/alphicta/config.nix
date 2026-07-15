{
  machine = {
    name = "alphicta";
    type = "desktop";
    features = {
      virtualization = true;
      deckmode = true;
      noDGPUspecialization = true;
    };
    desktopEnvironment = {
      enable = true;
      types = [ "niri" "gnome" ];
      displayManager = "gdm";
    };
    variables = {
      gitSigningKey = "0xF23DB4349DDE0FAA";
      gitSigning = true;
    };
  };
}
