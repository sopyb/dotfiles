{
  description = "Demo";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
  };

  outputs = { self, nixpkgs, ... }:
    let
      system = "x86_64-linux";

      pkgs = import nixpkgs {
        inherit system;
      };

      stdenv = pkgs.llvmPackages_latest.stdenv;
    in
    {
      packages.${system} = {
        default = stdenv.mkDerivation {
          name = "llvm";
          src = pkgs.lib.cleanSource ./.;
          nativeBuildInputs = with pkgs; [
            cmake
            keepBuildTree
          ];
          buildInputs = with pkgs; [
            bashInteractive
            python3
            ninja
            cmake
            llvmPackages_latest.llvm
          ];
        };
      };

      devShells.${system} = {
        default = pkgs.mkShell.override
          {
            inherit stdenv;
          }
          {
            inputsFrom = [
              self.packages.${system}.default
            ];
            packages = with pkgs; [
              llvmPackages_17.clang-tools
            ];
            env = {
              CLANGD_FLAGS = "--query-driver=${pkgs.lib.getExe stdenv.cc}";
            };
            shellHook = ''
              ln -sfn ${self.packages.${system}.default}/.build/source/build/compile_commands.json .
            '';
          };
      };
    };
}
