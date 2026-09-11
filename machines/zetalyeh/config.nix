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
      immich = true;
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
      dGpuPciId = "0000:01:00.0";
      gitSigningKey = "";
      gitSigning = false;
      paths = {
        immich = "/mnt/storage/immich";
      };
    };
  };
}
