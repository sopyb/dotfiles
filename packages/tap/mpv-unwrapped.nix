{ pkgs ? import <nixpkgs> { } }:

let
  src = pkgs.fetchFromGitHub {
    "owner" = "sopyb";
    "repo" = "mpv";
    "rev" = "tap";
    "hash" = "sha256-fLgSbaj8WNea+Bj9boTtEy988GOI/+yK2QsSNf9kXRc=";
  };
in
pkgs.mpv-unwrapped.overrideAttrs (old: {
  inherit src;

  postPatch = pkgs.lib.concatStringsSep "\n" [
    # Don't reference compile time dependencies or create a build outputs cycle
    # between out and dev
    ''
      substituteInPlace meson.build \
        --replace-fail "conf_data.set_quoted('CONFIGURATION', meson.build_options().strip().replace('\\\\', '\\\\\\\\'))" \
                       "conf_data.set_quoted('CONFIGURATION', '<omitted>')"
    ''
    # A trick to patchShebang everything except mpv_identify.sh
    ''
      pushd TOOLS
      mv mpv_identify.sh mpv_identify
      patchShebangs *.py *.sh
      mv mpv_identify mpv_identify.sh
      popd
    ''
  ];
})