{ lib
, stdenvNoCC
, fetchFromGitHub
, makeWrapper
, python3
}:

let
  pythonEnv = python3.withPackages (ps: with ps; [
    distro
    psutil
    tkinter
  ]);
in
stdenvNoCC.mkDerivation (finalAttrs: {
  pname = "linver";
  version = "0-unstable-2021-08-13";

  src = fetchFromGitHub {
    owner = "BrenoMartinsDeOliveiraVasconcelos";
    repo = "linver";
    rev = "b06b078e4aeaa013b4b47ca987e0317576556bdb";
    hash = "sha256-7xg9MwAtSSEPt7oL4JYhND7oVcr38mINHkwBGYLFAo4=";
  };

  nativeBuildInputs = [ makeWrapper ];

  dontConfigure = true;
  dontBuild = true;

  installPhase = ''
    runHook preInstall

    mkdir -p $out/share/linver
    cp linver.py $out/share/linver/
    cp -r assets $out/share/linver/

    makeWrapper ${pythonEnv}/bin/python3 $out/bin/linver \
      --add-flags "$out/share/linver/linver.py"

    runHook postInstall
  '';

  meta = {
    description = "Winver recreation for Linux";
    homepage = "https://github.com/BrenoMartinsDeOliveiraVasconcelos/linver";
    license = lib.licenses.gpl2Only;
    platforms = lib.platforms.linux;
    mainProgram = "linver";
  };
})
