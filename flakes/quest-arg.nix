{
  description = "Node.js and Go development environment";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    devenv.url = "github:cachix/devenv";
  };

  nixConfig = {
    extra-trusted-public-keys = "devenv.cachix.org-1:w1cLUi8dv3hnoSPGAuibQv+f9TZLr6cv/Hm9XgU50cw=";
    extra-substituters = "https://devenv.cachix.org";
  };

  outputs = { self, nixpkgs, devenv, ... }:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs { inherit system; };
    in
    {
      devShells.${system} = {
        default = pkgs.mkShell {
          buildInputs = with pkgs; [
            # Node.js Development
            nodejs_20
            nodePackages.npm

            # Go Development
            go
            go-tools

            # Development tools
            git
            curl
            wget
          ];

          shellHook = ''
            echo "Node.js version: $(node --version)"
            echo "Go version: $(go version)"
            echo "NPM version: $(npm --version)"
          '';

          services.nginx = {
            enable = true;

            eventsConfig = ''
              worker_connections 1024;
            '';

            httpConfig = ''
              # Upstream definitions
              upstream frontend {
                server localhost:4321;
              }

              upstream backend {
                server localhost:3000;
              }

              map $http_upgrade $connection_upgrade {
                default upgrade;
                close;
              }

              server {
                listen 8080;
                server_name localhost;

                add_header X-Frame-Options SAMEORIGIN;
                add_header X-Content-Type-Options nosniff;
                add_header X-XSS-Protection "1; mode=block";

                error_log stderr;
                access_log stderr;

                location / {
                  proxy_pass http://frontend;
                  include ${pkgs.nginx}/conf/proxy_params;
                  proxy_http_version 1.1;
                  proxy_set_header Upgrade $http_upgrade;
                  proxy_set_header Connection $connection_upgrade;
                }

                location /api {
                  proxy_pass http://backend;
                  include ${pkgs.nginx}/conf/proxy_params;
                  proxy_http_version 1.1;
                  proxy_set_header Upgrade $http_upgrade;
                  proxy_set_header Connection $connection_upgrade;
                }
              }
            '';
          };
        };
      };
    };
}
