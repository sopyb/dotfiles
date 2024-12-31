{ pkgs, ... }:

{
  home.packages = with pkgs; [
    nodejs_20
    github-copilot-cli
  ];

  programs.zsh = {
    enable = true;

    autosuggestion.enable = true;

    autocd = true;
    dotDir = ".config/zsh";
    enableCompletion = true;
    shellAliases = {
      sl = "eza";
      ls = "eza";
      l = "eza -l";
      la = "eza -la";
      neofetch = "hyfetch";
    };

    initExtra = ''
      eval "$(github-copilot-cli alias -- "$0")"
      POWERLEVEL9K_DISABLE_CONFIGURATION_WIZARD=true
    '';


    zplug = {
      enable = true;
      plugins = [
        { name = "romkatv/powerlevel10k"; tags = [ as:theme depth:1 ]; }
        { name = "wbingli/zsh-wakatime"; tags = [ as:plugin ]; }
        { name = "zsh-users/zsh-autosuggestions"; tags = [ as:plugin ]; }
        { name = "zsh-users/zsh-completions"; tags = [ as:plugin ]; }
        { name = "zsh-users/zsh-syntax-highlighting"; tags = [ as:plugin ]; }
      ];
    };
  };

  programs.fzf = {
    enable = true;
    enableZshIntegration = true;
  };
}
