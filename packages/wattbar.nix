{ pkgs }:

pkgs.rustPlatform.buildRustPackage {
  pname = "wattbar";
  version = "unstable-2024-05-18";

  src = pkgs.fetchFromGitHub {
    "owner" = "thequux";
    "repo" = "wattbar";
    "rev" = "b1875ac4721d451ce3b2c620b8a2bc068056c96f";
    "hash" = "sha256-57N2Cd6HcU8Vm6RhjIU7b4ZB2L4AHQbatDmf6wqQZH0=";
  };

  cargoHash = "sha256-cELL4B4x2FZpQXdX+iraUiR1V8XO+H8jqlkTTmXDyGU=";

  nativeBuildInputs = with pkgs; [
    pkg-config
  ];

  buildInputs = with pkgs; [
    wayland
    wayland-protocols
  ];

  meta = with pkgs.lib; {
    description = "Wayland implementation of xbattbar";
    homepage = "https://github.com/thequux/wattbar";
    license = licenses.mit;
    platforms = platforms.linux;
    maintainers = [ ];
  };
}
