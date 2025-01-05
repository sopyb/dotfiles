{ pkgs, ... }:

{
  home = {
    packages = with pkgs; [
      nodejs_20
      github-copilot-cli
    ];

    file.".config/zsh/.p10k.zsh".text = builtins.readFile ./p10k.zsh;
  };

  programs.zsh = {
    enable = true;

    autosuggestion.enable = true;

    autocd = true;
    dotDir = ".config/zsh";
    enableCompletion = true;
    shellAliases = {
      ls = "eza";
      sl = "eza";
      l = "eza -l";
      la = "eza -la";
      neofetch = "hyfetch";
      cd = "z";
    };

    initExtra = ''
      source ${pkgs.zsh-powerlevel10k}/share/zsh-powerlevel10k/powerlevel10k.zsh-theme
      eval "$(github-copilot-cli alias -- "$0")"
      POWERLEVEL9K_DISABLE_CONFIGURATION_WIZARD=true

      source ~/.config/zsh/.p10k.zsh
    '';

    plugins = [
      {
        name = "nix-shell";
        src = "${pkgs.zsh-nix-shell}/share/zsh-nix-shell";
      }
      {
        name = "you-should-use";
        src = "${pkgs.zsh-you-should-use}/share/zsh/plugins/you-should-use";
      }
      {
        name = "zsh-z";
        src = "${pkgs.zsh-z}/share/zsh-z";
      }
      {
        name = "zsh-autosuggestions";
        src = "${pkgs.zsh-autosuggestions}/share/zsh-autosuggestions";
      }
      {
        name = "zsh-syntax-highlighting";
        src = "${pkgs.zsh-syntax-highlighting}/share/zsh-syntax-highlighting";
      }
      {
        name = "powerlevel10k";
        src = "${pkgs.zsh-powerlevel10k}/share/zsh-powerlevel10k";
      }
    ];

  };

  programs.fzf = {
    enable = true;
    enableZshIntegration = true;
  };
}
