{ inputs }:

final: prev: {
  custom = import ../packages { pkgs = final; };

  stable = import inputs.nixpkgs-stable {
    system = final.system;
    config = final.config;
  };
}
