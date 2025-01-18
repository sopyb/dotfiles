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

      settings = {
        AllowUnencrypted = true;
      };
    };

    openssh = {
      enable = true;
      settings = {
        PermitRootLogin = "no";
        PasswordAuthentication = false;
      };
    };

    displayManager.autoLogin = {
      enable = true;
      user = "sopy";
    };

    vscode-server.enable = true;
  };

  users.users.sopy = {
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAILiep/t/LdGXd2KfTFRQFu6KcPNDbHiix1tnO8+MXGyx sopy@alphicta"
    ];
  };
}
