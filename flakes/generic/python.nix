{
  description = "Python development environment";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
  };

  outputs = { self, nixpkgs, ... }:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs { inherit system; };
    in
    {
      devShells.${system} = {
        default = pkgs.mkShell {
          buildInputs = with pkgs; [
            python312
            poetry
            stdenv.cc.cc.lib
          ];

          shellHook = ''
            # Load environment variables from .env
            if [ -f .env ]; then
              source .env
              echo "Loaded environment from .env"
            fi

            # Poetry venv setup
            if [ ! -d .venv ]; then
              echo "Creating virtual environment..."
              poetry config virtualenvs.in-project true
              poetry install
            fi

            source .venv/bin/activate

            # Show environment info
            echo "Poetry version: $(poetry --version)"
            echo "Python version: $(python --version)"
          '';
        };
      };
    };
}
