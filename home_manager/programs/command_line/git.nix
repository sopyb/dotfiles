{ ... }:

{
  programs.git = {
    enable = true;

    userName = "Sopy";
    userEmail = "contact@sopy.one";

    signing = {
      key = "0x9807678BAB0693F4";
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
