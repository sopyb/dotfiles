{
  cmd = {
    start = "wattbar -b l --theme catppuccin";
  };

  module = { pkgs, lib, ... }: {
    home.packages = with pkgs; [
      custom.wattbar
    ];

    home.file.".config/wattbar/catppuccin.theme".text = ''
      [charging]
      0%	  #f5bde6	#363a4f  # Pink / Surface0
      15%	  #eed49f	#363a4f  # Yellow / Surface0
      40%   #a6da95	#363a4f  # Green / Surface0
      90%	  #8aadf4	#363a4f  # Blue / Surface0
      100%  #8aadf4	#363a4f  # Blue / Surface0

      [discharging]
      0%	  #f5bde6	#363a4f  # Pink / Surface0
      15%	  #eed49f	#363a4f  # Yellow / Surface0
      40%   #a6da95	#363a4f  # Green / Surface0
      90%	  #8aadf4	#363a4f  # Blue / Surface0
      100%  #8aadf4	#363a4f  # Blue / Surface0

      [nocharge]
      0%		#939ab7	#181926  # Overlay2 / Crust
    '';
  };
}