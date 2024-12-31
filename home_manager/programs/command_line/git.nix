{ ... }:

{
  programs.git = {
    enable = true;

    userName = "Sopy";
    userEmail = "contact@sopy.one";

    signing = {
      key = machineVars.gitSigningKey;
      signByDefault = true;
    };

    extraConfig = {
      core = {
        autocrlf = "input";
        editor = "micro";
      };

      url = {
        "ssh://git@github.com:" = {
          insteadOf = "https://github.com/";
        };
      };
    };
  };
}
