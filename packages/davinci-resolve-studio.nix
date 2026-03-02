{ pkgs, lib, bash, writeText, xkeyboard-config }:

pkgs.davinci-resolve-studio.override (old: {
  buildFHSEnv =
    fhs:
    (
      let
        ffmpeg-encoder-plugin = pkgs.stdenv.mkDerivation (finalAttrs: {
          pname = "ffmpeg-encoder-plugin";
          version = "1.1.0";

          src = pkgs.fetchFromGitHub {
            owner = "EdvinNilsson";
            repo = "ffmpeg_encoder_plugin";
            tag = "v${finalAttrs.version}";
            hash = "sha256-orghLIzz9rUnUwka9C71Z2nj+qxHuggrKNlYjLKswQw=";
          };

          nativeBuildInputs = with pkgs; [
            cmake
            ffmpeg-full
          ];

          buildInputs = with pkgs; [ ffmpeg ];

          installPhase = ''
            runHook preInstall
            mkdir -p $out
            cp ffmpeg_encoder_plugin.dvcp $out/
            runHook postInstall
          '';
        });

        davinci = fhs.passthru.davinci.overrideAttrs (old: {
          postInstall = (old.postInstall or "") + ''
            ${lib.getExe pkgs.perl} -pi -e 's/\x74\x11\xe8\x21\x23\x00\x00/\xeb\x11\xe8\x21\x23\x00\x00/g' $out/bin/resolve
            ${lib.getExe pkgs.perl} -pi -e 's/\x03\x00\x89\x45\xFC\x83\x7D\xFC\x00\x74\x11\x48\x8B\x45\xC8\x8B/\x03\x00\x89\x45\xFC\x83\x7D\xFC\x00\xEB\x11\x48\x8B\x45\xC8\x8B/' $out/bin/resolve
            ${lib.getExe pkgs.perl} -pi -e 's/\x74\x11\x48\x8B\x45\xC8\x8B\x55\xFC\x89\x50\x58\xB8\x00\x00\x00/\xEB\x11\x48\x8B\x45\xC8\x8B\x55\xFC\x89\x50\x58\xB8\x00\x00\x00/' $out/bin/resolve
            ${lib.getExe pkgs.perl} -pi -e 's/\x41\xb6\x01\x84\xc0\x0f\x84\xb0\x00\x00\x00\x48\x85\xdb\x74\x08\x45\x31\xf6\xe9\xa3\x00\x00\x00/\x41\xb6\x00\x84\xc0\x0f\x84\xb0\x00\x00\x00\x48\x85\xdb\x74\x08\x45\x31\xf6\xe9\xa3\x00\x00\x00/' $out/bin/resolve
            mkdir -p $out/IOPlugins/ffmpeg_encoder_plugin.dvcp.bundle/Contents/Linux-x86-64/
            cp ${ffmpeg-encoder-plugin}/ffmpeg_encoder_plugin.dvcp $out/IOPlugins/ffmpeg_encoder_plugin.dvcp.bundle/Contents/Linux-x86-64/
          '';
        });
      in
      old.buildFHSEnv (
        fhs
        // {
          extraBwrapArgs = [
            "--bind \"$HOME\"/.local/share/DaVinciResolve/license ${davinci}/.license"
            "--bind /run/opengl-driver/etc/OpenCL /etc/OpenCL"
          ];
          runScript = "${bash}/bin/bash ${writeText "davinci-wrapper" ''
            export QT_XKB_CONFIG_ROOT="${xkeyboard-config}/share/X11/xkb"
            export QT_PLUGIN_PATH="${davinci}/libs/plugins:$QT_PLUGIN_PATH"
            export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/usr/lib:/usr/lib32:${davinci}/libs
            unset QT_QPA_PLATFORM # Having this set to wayland causes issues
            ${davinci}/bin/resolve
          ''}";
          extraInstallCommands = ''
            mkdir -p $out/share/applications $out/share/icons/hicolor/128x128/apps
            ln -s ${davinci}/share/applications/*.desktop $out/share/applications/
            ln -s ${davinci}/graphics/DV_Resolve.png $out/share/icons/hicolor/128x128/apps/davinci-resolve-studio.png
          '';
          passthru = { inherit davinci ffmpeg-encoder-plugin; };
        }
      )
    );
})
