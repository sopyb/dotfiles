{ pkgs, ... }:

{
  services = {
    ollama = {
      enable = true;
      acceleration = "cuda";
    };

    postgresql = {
      enable = true;
      ensureDatabases = [ "mydatabase" ];
      authentication = pkgs.lib.mkOverride 10 ''
        # Allow accessa_user to connect locally over IPv4/IPv6
        host    accessa     accessa_user    127.0.0.1/32    trust
        host    accessa     accessa_user    ::1/128         trust
        # Default local trust for all users
        local   all         all             trust
      '';
    };
  };
}
