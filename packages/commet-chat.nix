# Commet chat package (horrible btw)
# Keep track of https://github.com/NixOS/nixpkgs/pull/491888
# TODO: Replace when merged into nixpkgs

{ pkgs }:

let
  mpvCompat = pkgs.runCommand "mpv-compat" { } ''
    mkdir -p $out/lib
    ln -s ${pkgs.mpv}/lib/libmpv.so $out/lib/libmpv.so.1
  '';
in
pkgs.stdenv.mkDerivation rec {
  pname = "commet";
  version = "0.4.2+hotfix.2";

  src = pkgs.fetchurl {
    url = "https://github.com/commetchat/commet/releases/download/v${version}/commet-ubuntu-22.04-x64.deb";
    hash = "sha256-g8bjxPoTt2ML+ayJTLYf2yzzfncZDl43p9XpmTRsXY0=";
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
    mpvCompat
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
      --prefix LD_LIBRARY_PATH : $out/lib/chat.commet.commetapp/lib \
      --prefix GIO_EXTRA_MODULES : ${pkgs.dconf.lib}/lib/gio/modules \
      --prefix XDG_DATA_DIRS : ${pkgs.gtk3}/share/gsettings-schemas/${pkgs.gtk3.name} \
      --prefix XDG_DATA_DIRS : ${pkgs.gsettings-desktop-schemas}/share/gsettings-schemas/${pkgs.gsettings-desktop-schemas.name}

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
