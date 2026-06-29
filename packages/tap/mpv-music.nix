{
  pkgs
}:

let
  mpv = pkgs.callPackage ./mpv.nix { };
in
pkgs.rustPlatform.buildRustPackage rec {
  pname = "mpv-music";
  version = "0.27.0";

  src = pkgs.fetchFromGitHub {
    owner = "FurqanHun";
    repo = "mpv-music";
    rev = "v${version}";
    hash = "sha256-l7e2AVg3LTYzV7TiA/PdPnioe9Uq4rZHfRG3CGeZmE8=";
  };

  cargoHash = "sha256-AxOgcTfmJoImQZu4H6z1MTo02NAA1QtHOd2jW8Bi+gk=";

  buildFeatures = [];

  nativeBuildInputs = with pkgs; [ pkg-config makeWrapper ];

  buildInputs = [];

  postInstall = ''
    wrapProgram $out/bin/mpv-music \
      --prefix PATH : ${pkgs.lib.makeBinPath [ mpv pkgs.yt-dlp pkgs.nodejs ]}
  '';


  meta = {
    description = "Music for your terminal.";
    homepage = "https://github.com/FurqanHun/mpv-music";
    license = pkgs.lib.licenses.mit;
    mainProgram = "mpv-music";
  };
}
