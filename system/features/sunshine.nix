{ pkgs, ... }:

let
  krfb = pkgs.kdePackages.krfb;
  ksd = "${pkgs.kdePackages.libkscreen}/bin/kscreen-doctor";

  vdUp = pkgs.writeShellScript "vd-up" ''
    W="''${SUNSHINE_CLIENT_WIDTH:-1920}"
    H="''${SUNSHINE_CLIENT_HEIGHT:-1080}"
    FPS="''${SUNSHINE_CLIENT_FPS:-60}"
    FPS="''${FPS%.*}" # strip decimals if a client sends e.g. 59.94
  
    ${pkgs.systemd}/bin/systemd-run --user --collect --unit=sunshine-vd \
      ${krfb}/bin/krfb-virtualmonitor \
        --name sunshine \
        --resolution "''${W}x''${H}" \
        --scale 1 --password unused --port 5999

    for i in $(seq 1 20); do
      ${ksd} -o 2>/dev/null | grep -q 'Virtual-sunshine' && break
      sleep 0.5
    done

    if [ "$FPS" -ne 60 ]; then
      FPS_MHZ=$(( FPS * 1000 ))
      ${ksd} "output.Virtual-sunshine.addCustomMode.''${W}.''${H}.''${FPS_MHZ}.full"
      ${ksd} "output.Virtual-sunshine.mode.''${W}x''${H}@''${FPS}"
    fi
  '';

  vdDown = pkgs.writeShellScript "vd-down" ''
    ${pkgs.systemd}/bin/systemctl --user stop sunshine-vd.service || true
  '';

  mkApp = app: app // {
    prep-cmd = [{ do = "${vdUp}"; undo = "${vdDown}"; }];
  };
in
{
  services = {
    sunshine = {
      enable = true;
      autoStart = true;
      capSysAdmin = true;
      openFirewall = true;

      package = pkgs.sunshine.override {
        cudaSupport = true;
        cudaPackages = pkgs.cudaPackages;
      };

      settings = {
        capture = "kwin";
        output_name = "Virtual-sunshine";
      };

      applications.apps = map mkApp [
        { name = "Desktop"; }
      ];
    };
  };

  hardware.uinput.enable = true;
}
