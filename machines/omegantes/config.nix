{
  machine = {
    name = "omegantes";
    type = "server";
    desktopEnvironment.enable = false;
    features = {
      nginx = true;
      sshd = true;
    };
    variables = {
      nginx = {
        domain = "sopy.one";
        ssl = true;
      };
    };
  };
}
