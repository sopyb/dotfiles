{ config, pkgs, ... }:

{
  programs.htop = {
    enable = true;
    settings = {
      fields = with config.lib.htop.fields; [
        PID
        USER
        PRIORITY
        NICE
        M_SHARE
        M_VIRT
        STATE
        M_SWAP
        PERCENT_MEM
        M_RESIDENT
        PERCENT_CPU
        TIME
        COMM
      ];
      highlight_base_name = 1;
    } // (with config.lib.htop; leftMeters [
      (bar "AllCPUs4")
      (bar "CPU")
      (bar "Memory")
      (bar "Swap")
      (bar "HugePages")
    ]) // (with config.lib.htop; rightMeters [
      (text "Tasks")
      (text "LoadAverage")
      (text "Uptime")
      (text "Battery")
      (text "DiskIO")
      (text "NetworkIO")
      (text "MemorySwap")
    ]);
  };
}
