{
  machine = {
    name = "alphicta";
    type = "desktop";
    desktopEnvironment = {
      enable = true;
      types = [ "plasma" ];
      displayManager = "sddm";
    };
    features = {
      virtualization = true;
      ollama = true;
    };
    tweaks = {
      noFirewall = true;
    };
    specializations = {
      deckmode = false;
      noDedicatedGPU = true;
    };
    variables = {
      gitSigningKey = "0xF23DB4349DDE0FAA";
      gitSigning = true;
      dGpuPciId = "01:00:00";
    };
  };
}
