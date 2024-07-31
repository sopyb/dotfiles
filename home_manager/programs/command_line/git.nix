{ ... }:

{
  programs.git = {
    enable = true;
    
    userName = "Sopy";
    userEmail = "contact@sopy.one";

    signing = {
      key = "670B2256BE1A9B17";
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