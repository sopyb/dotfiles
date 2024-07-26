{ inputs, ... }:

{
  imports = [ inputs.nixos-cosmic.nixosModules.default ];

  nix.settings = {
    substituters = old: old ++ "https://cosmic.cachix.org/";
    trusted-public-keys = old: old ++ "cosmic.cachix.org-1:Dya9IyXD4xdBehWjrkPv6rtxpmMdRel02smYzA85dPE=";
  };
  
  services.displayManager.cosmic-greeter.enable = true;
  services.desktopManager.cosmic.enable = true;
}