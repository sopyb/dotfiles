{ config, lib, pkgs, ... }:

{
  home.packages = with pkgs; [
    nodejs_20
    github-copilot-cli
  ];

  xdg.configFile."shell".source = lib.getExe pkgs.zsh;

  programs.zsh = {
    enable = true;

    autosuggestion.enable = true;

    autocd = true;
    dotDir = ".config/zsh";
    enableCompletion = true;
    shellAliases = {
      sl = "eza --icons --grid";
      ls = "eza --icons --grid";
      l = "eza --icons --grid -l";
      la = "eza --icons --grid -la";
      neofetch = "hyfetch -b fastfetch";
    
    };

    initExtra = ''
      eval "$(github-copilot-cli alias -- "$0")"
    '';

    
    zplug = {
      enable = true;
      plugins = [
        { name = "romkatv/powerlevel10k"; tags = [ as:theme depth:1 ]; }
      ];
    };
  };

  programs.fzf = {
    enable = true;
    enableZshIntegration = true;
  };
}
