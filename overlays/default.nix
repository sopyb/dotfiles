{ inputs }:

final: prev: {
  custom = import ../packages { pkgs = final; };

  stable = import inputs.nixpkgs-stable {
    system = final.stdenv.hostPlatform.system;
    config = final.config;
  };
}
