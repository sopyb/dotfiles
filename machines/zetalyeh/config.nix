{
  machine = {
    name = "zetalyeh";
    type = "hybrid";
    desktopEnvironment = {
      enable = true;
      types = [ "plasma" ];
      displayManager = "sddm";
    };
    features = {
      ollama = true;
      sshd = true;
      sunshine = true;
      virtualDisplay = true;
      virtualization = false;
    };
    tweaks = {
      autoLogin = true;
      noFirewall = true;
      noSleep = true;
    };
    specializations = {
      deckmode = false;
      noDedicatedGPU = false;
    };
    variables = {
      gitSigningKey = "";
      gitSigning = false;
    };
  };
}
