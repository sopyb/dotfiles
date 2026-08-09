{
  machine = {
    name = "alphicta";
    type = "desktop";
    features = {
      virtualization = true;
      deckmode = false;
      noDGPUspecialization = true;
    };
    desktopEnvironment = {
      enable = true;
      types = [ "gnome" ];
      displayManager = "gdm";
    };
    variables = {
      gitSigningKey = "0xF23DB4349DDE0FAA";
      gitSigning = true;
    };
  };
}
