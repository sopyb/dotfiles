# Commet chat package (horrible btw)
# Keep track of https://github.com/NixOS/nixpkgs/pull/491888
# TODO: Replace when merged into nixpkgs

{ pkgs }:

pkgs.stdenv.mkDerivation rec {
  pname = "commet";
  version = "0.4.1";

  src = pkgs.fetchurl {
    url = "https://github.com/commetchat/commet/releases/download/v${version}/commet-ubuntu-24.04-x64.deb";
    hash = "sha256-ln67pEfoW8gqGo3uf1lGZ3a3vm3IyT4eFkEf7dwJNAU=";
  };

  nativeBuildInputs = with pkgs; [
    dpkg
    autoPatchelfHook
    makeWrapper
  ];

  buildInputs = with pkgs; [
    stdenv.cc.cc.lib
    libxkbcommon
    libxcb
    libX11
    libGL
    dbus
    gtk3
    pango
    cairo
    atk
    gdk-pixbuf
    harfbuzz
    zlib
    webkitgtk_4_1
    libsoup_3
    keybinder3
    mpv
    libgbm
    libdrm
    openssl
    libsodium
  ];

  unpackPhase = ''
    dpkg -x $src .
  '';

  installPhase = ''
    mkdir -p $out
    cp -r usr/* $out/

    mkdir -p $out/bin
    makeWrapper $out/lib/chat.commet.commetapp/commet $out/bin/commet \
      --prefix LD_LIBRARY_PATH : $out/lib/chat.commet.commetapp/lib

    sed -i 's|^Exec=.*|Exec=commet|' $out/share/applications/chat.commet.commetapp.desktop
  '';

  meta = with pkgs.lib; {
    description = "A comfortable chat client which respects your privacy. Powered by [Matrix]";
    homepage = "https://github.com/commetchat/commet";
    license = licenses.agpl3Only;
    platforms = platforms.linux;
    maintainers = [ ];
  };
}
