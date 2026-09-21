{
  machine = {
    name = "yotemensus";
    type = "server";
    desktopEnvironment.enable = false;
    features = {
      sshd = true;
    };
    variables = { };
  };
}
