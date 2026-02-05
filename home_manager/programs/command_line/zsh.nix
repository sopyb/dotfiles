{ pkgs, config, ... }:

{
  home = {
    packages = with pkgs; [
      nodejs_20
    ];
  };

  programs.zsh = {
    enable = true;

    autosuggestion.enable = true;

    autocd = true;
    dotDir = "${config.xdg.configHome}/zsh";
    enableCompletion = true;
    shellAliases = {
      ls = "eza";
      sl = "eza";
      l = "eza -l";
      la = "eza -la";
      neofetch = "hyfetch";
    };

    completionInit = "autoload -U compinit && compinit -i";

    initContent = ''
      export "MICRO_TRUECOLOR=1"

      if [[ -n "$CONTAINER_ID" ]] && [[ "$CONTAINER_ID" == "ros2" ]]; then
        compinit() {
          builtin autoload -U compinit
          builtin compinit -u "$@"
        }

        source /opt/ros/humble/setup.zsh
        export ROS_DOMAIN_ID=0
      fi

      function edit() {
        query="$@"
        result=$(fzf -e --query "$query")

        if [ -n "$result" ]; then
          micro "$result"
        else
          echo "No file selected"
        fi
      }
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
    ];

  };

  programs.starship = {
    enable = true;
    enableZshIntegration = true;
  };

  programs.fzf = {
    enable = true;
    enableZshIntegration = true;
  };
}
