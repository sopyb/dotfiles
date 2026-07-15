{ config, lib, pkgs, machineName, ... }:
let
  machineUtils = import ../../utils/machineVariables.nix { inherit lib config; };
  machineVars = machineUtils.getMachineVariables machineName;
in
{
  programs.vscode = {
    enable = true;

    package = pkgs.vscode;

    profiles.default = {
      enableUpdateCheck = false;
      enableExtensionUpdateCheck = true;

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

        "git.autofetch" = true;
        "git.confirmSync" = false;
        "git.enableCommitSigning" = machineVars.gitSigning;
        "git.enableSmartCommit" = true;

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

        "terminal.integrated.fontFamily" = "JetBrainsMonoNL NF";

        "workbench.colorTheme" = "Catppuccin Macchiato";
        "catppuccin.accentColor" = "lavender";
      };
    };
  };
}
