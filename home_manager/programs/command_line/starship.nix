{ ... }:

{
  programs.starship = {
    enable = true;

    enableBashIntegration = true;
    enableZshIntegration = true;

    transientPrompt = false;

    settings = {
      add_newline = true;

      character = {
        success_symbol = "[󰮺](bold teal)";
        error_symbol = "[󰮺](bold red)";
      };
    };
  }
}