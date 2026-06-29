{
  lib,
  buildNpmPackage,
  fetchFromGitHub,
  mpv,
  yt-dlp,
  nodejs,
  bun,
  makeWrapper,
}:

buildNpmPackage {
  pname = "youtube-music-cli";
  version = "0.0.87";

  src = fetchFromGitHub {
    owner = "involvex";
    repo = "youtube-music-cli";
    rev = "v0.0.87";
    hash = "sha256-gaxpKMkM3QgkshZ52JtExwcoxdRAurQWCGANA5P4AQ4=";
  };

  npmDepsHash = "sha256-PmBfgDxkc1YzKhAnIRj+lrII2grkWnX6UjZwCF2Od9o=";
  npmFlags = [ "--ignore-scripts" "--legacy-peer-deps" ];
  forceGitDeps = true;

  postPatch = ''
    cp ${./youtube-music-cli-package-lock.json} package-lock.json
    sed -i '/"prebuild"/d' package.json
  '';

  buildPhase = ''
    npm run build
  '';

  nativeBuildInputs = [ makeWrapper bun ];

  postInstall = ''
    rm -f $out/lib/node_modules/@involvex/youtube-music-cli/node_modules/youtube-music-cli-web

    wrapProgram $out/bin/youtube-music-cli \
      --prefix PATH : ${lib.makeBinPath [ mpv yt-dlp ]}
  '';

  meta = {
    description = "A powerful Terminal User Interface (TUI) music player for YouTube Music ";
    homepage = "https://github.com/involvex/youtube-music-cli";
    license = lib.licenses.mit;
    mainProgram = "youtube-music-cli";
  };
}