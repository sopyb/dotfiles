{ inputs, ... }:

{
  imports = [
    inputs.musnix.nixosModules.musnix
  ];

  # For remote ssh jetbrains to not slow down
  boot.kernel.sysctl = {
    "fs.inotify.max_user_instances" = 4096;
    "fs.inotify.max_user_watches" = 524288;
  };

  musnix.enable = true;
}
