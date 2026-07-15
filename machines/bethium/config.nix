{
  machine = {
    name = "bethium";
    type = "desktop";
    features = { };
    desktopEnvironment = {
      enable = true;
      types = [ "gnome" ];
      displayManager = "none";
    };
    variables = {
      gitSigningKey = "0x9807678BAB0693F4";
      gitSigning = true;
    };
  };
}
