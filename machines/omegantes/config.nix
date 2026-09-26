{
  machine = {
    name = "omegantes";
    type = "server";
    features = {
      sshd = true;
    };
    desktopEnvironment.enable = false;
    variables = { };
  };
}
