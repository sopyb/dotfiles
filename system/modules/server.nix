{ ... }:

{
  imports = [
    ./common.nix

    ./server/services.nix
  ];

  users.users.sopy.openssh.authorizedKeys.keys = [
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAILiep/t/LdGXd2KfTFRQFu6KcPNDbHiix1tnO8+MXGyx sopy@alphicta"
  ];
}
