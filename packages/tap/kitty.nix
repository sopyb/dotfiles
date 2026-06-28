{ pkgs ? import <nixpkgs> { } }:

let
  src = pkgs.fetchFromGitHub {
    "owner" = "sopyb";
    "repo" = "kitty";
    "rev" = "tap";
    "hash" = "sha256-2O4m1NW+q2E+HM9TaHdrJLvNf14PIvg68YZM84/46A4=";
  };

  goModules = (pkgs.buildGo126Module {
    pname = "kitty-go-modules";
    inherit src;
    version = pkgs.kitty.version;
    vendorHash = "sha256-zZZDrWzl2q/o4f52diE0YDV/MdYfsdKWWjQ0ej2bBTM=";
  }).goModules;
in
pkgs.kitty.overrideAttrs (old: {
  inherit src goModules;

  env.GOTOOLCHAIN = "local";

  nativeBuildInputs = (old.nativeBuildInputs or [ ]) ++ [ pkgs.pkg-config ];
  buildInputs = (old.buildInputs or [ ]) ++ [ pkgs.alsa-lib pkgs.libpulseaudio ];

  phases = [ "unpackPhase" "patchPhase" "configurePhase" "buildPhase" "installPhase" ];

  preBuild = ''
    rm -rf fonts
  '';
})
