{ inputs, self, ... }:

final: prev: {
  custom = import (self + /packages) { pkgs = final; };

  stable = import inputs.nixpkgs-stable {
    system = final.stdenv.hostPlatform.system;
    config = { allowUnfree = final.config.allowUnfree or false; };
  };

  fork = import inputs.nixpkgs-fork {
    system = final.stdenv.hostPlatform.system;
    config = { allowUnfree = final.config.allowUnfree or false; };
  };
}
