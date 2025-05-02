{ pkgs, inputs, ... }:

{
  imports = [
    inputs.vscode-server.nixosModules.default
  ];

  services = {
    cockpit = {
      enable = true;
      package = pkgs.cockpit;

      port = 9090;
      openFirewall = true;
    };

    openssh = {
      enable = true;
      settings = {
        PermitRootLogin = "no";
        PasswordAuthentication = false;
      };
    };
  };
}
