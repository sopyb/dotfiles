{ lib
, stdenv
, fetchFromGitHub
, pkg-config
, ncurses
, mpv
, yt-dlp
, chafa 
, makeWrapper
}:

stdenv.mkDerivation {
  pname = "ytcui";
  version = "3.0.0-unstable-2026-06-18";

  src = fetchFromGitHub {
    owner = "MilkmanAbi";
    repo = "ytcui";
    rev = "f1a8233565c25d51d8c0cb836eecd576ac544758";
    hash = "sha256-yHbel/zX2q15rHSm10gWANSiYCE/tsPzdEZlGp5ATbE=";
  };

  nativeBuildInputs = [
    pkg-config
    makeWrapper
  ];

  buildInputs = [
    ncurses
  ];

  makeFlags = [
    "BACKEND=ytdlp"
    "PREFIX=${placeholder "out"}"
  ];

  preBuild = ''
    export PKG_CONFIG_PATH="${ncurses}/lib/pkgconfig"
  '';

  postInstall = ''
    wrapProgram "$out/bin/ytcui" \
      --prefix PATH : ${lib.makeBinPath [ mpv yt-dlp chafa ]}
  '';

  meta = with lib; {
    description = "Lightweight terminal YouTube client built with ncurses and mpv";
    homepage = "https://github.com/MilkmanAbi/ytcui";
    license = licenses.mit;
    platforms = platforms.linux;
    maintainers = [ ];
    mainProgram = "ytcui";
  };
}
