{ ... }:

{
  programs.git = {
    enable = true;
    
    userName = "Sopy";
    userEmail = "contact@sopy.one";

    signing = {
      key = "0xF23DB4349DDE0FAA";
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
