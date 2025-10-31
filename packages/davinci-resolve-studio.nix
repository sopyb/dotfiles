{ pkgs, perl, bash, writeText, xkeyboard-config }:

pkgs.davinci-resolve-studio.override (old: {
  buildFHSEnv =
    fhs:
    (
      let
        davinci = fhs.passthru.davinci.overrideAttrs (old: {
          postFixup = ''
            ${old.postFixup}
            ${perl}/bin/perl -pi -e 's/\x03\x00\x89\x45\xFC\x83\x7D\xFC\x00\x74\x11\x48\x8B\x45\xC8\x8B/\x03\x00\x89\x45\xFC\x83\x7D\xFC\x00\xEB\x11\x48\x8B\x45\xC8\x8B/' $out/bin/resolve
            ${perl}/bin/perl -pi -e 's/\x74\x11\x48\x8B\x45\xC8\x8B\x55\xFC\x89\x50\x58\xB8\x00\x00\x00/\xEB\x11\x48\x8B\x45\xC8\x8B\x55\xFC\x89\x50\x58\xB8\x00\x00\x00/' $out/bin/resolve
            ${perl}/bin/perl -pi -e 's/\x41\xb6\x01\x84\xc0\x0f\x84\xb0\x00\x00\x00\x48\x85\xdb\x74\x08\x45\x31\xf6\xe9\xa3\x00\x00\x00/\x41\xb6\x00\x84\xc0\x0f\x84\xb0\x00\x00\x00\x48\x85\xdb\x74\x08\x45\x31\xf6\xe9\xa3\x00\x00\x00/' $out/bin/resolve
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
          passthru = { inherit davinci; };
        }
      )
    );
})