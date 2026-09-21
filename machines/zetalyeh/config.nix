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
      authentik = true;
      immich = true;
      nextcloud = true;
      nginx = true;
      overleaf = true;
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
      nginx = {
        domain = "sopy.one";
        ssl = true;
      };
      paths = {
        authentik = "/mnt/storage/authentik";
        immich = "/mnt/storage/immich";
        nextcloud = "/mnt/storage/nextcloud";
        overleaf = "/mnt/storage/overleaf";
      };
    };
  };
}
