{
  machine = {
    name = "omegantes";
    type = "server";
    desktopEnvironment.enable = false;
    features = {
      nginx = true;
      sshd = true;
      uptime-kuma = true;
    };
    tweaks = {
      noFirewall = true;
    };
    variables = {
      nginx = {
        domain = "sopy.one";
        ssl = true;
      };
    };
  };
}
