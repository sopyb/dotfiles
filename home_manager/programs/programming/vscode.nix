{ pkgs, ... }:

{
  programs.vscode = {
    enable = true;
    enableUpdateCheck = false;
    enableExtensionUpdateCheck = true;

    package = pkgs.vscode;

    extensions = with pkgs.vscode-extensions; [
      arrterian.nix-env-selector

      bierner.github-markdown-preview
      bierner.markdown-preview-github-styles

      catppuccin.catppuccin-vsc
      catppuccin.catppuccin-vsc-icons

      firefox-devtools.vscode-firefox-debug

      github.copilot
      github.copilot-chat
      github.vscode-github-actions
      github.vscode-pull-request-github

      jnoortheen.nix-ide

      mkhl.direnv

      ms-python.debugpy
      ms-python.python
      ms-python.vscode-pylance

      wakatime.vscode-wakatime
    ];

    keybindings = [
      {
        key = "ctrl+alt+l";
        command = "editor.action.formatDocument";
        when = "editorHasDocumentFormattingProvider && editorTextFocus && !editorReadonly && !inCompositeEditor";
      }
    ];

    userSettings = {
      "diffEditor.ignoreTrimWhitespace" = false;

      "files.autoSave" = "afterDelay";

      "git.enableCommitSigning" = true;
      "git.enableSmartCommit" = true;
      "git.autofetch" = true;

      "github.copilot.enable" = {
        "*" = true;
      };

      "nix.enableLanguageServer" = true;
      "nix.serverPath" = "nil";
      "nix.serverSettings" = {
        nil = {
          diagnostics = {
            ignored = [ "unused_with" ];
          };
          formatting = {
            command = [ "nixpkgs-fmt" ];
          };
        };
      };

      "terminal.integrated.fontFamily" = "JetBrainsMono Nerd Font";

      "workbench.colorTheme" = "Catppuccin Macchiato";
    };
  };
}
