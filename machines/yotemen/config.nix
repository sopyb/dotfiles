{
  machine = {
    name = "yotemen";
    type = "server";
    desktopEnvironment.enable = false;
    features = {
      sshd = true;
    };

    tweaks = {
      noSleep = true;
    };

    variables = { };
  };
}
