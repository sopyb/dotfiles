{ config, ... }:

{
  programs.htop = {
    enable = true;
    settings = {
      show_cpu_temperature = 1;
      cpu_count_from_one = 1;
      highlight_threads = 1;
      highlight_base_name = 1;

      fields = with config.lib.htop.fields; [
        PID
        USER
        PRIORITY
        NICE
        # M_SIZE
        # M_RESIDENT
        # M_SHARE
        STATE
        PERCENT_CPU
        PERCENT_MEM
        TIME
        COMM
      ];
    } // (with config.lib.htop; leftMeters [
      (bar "AllCPUs4")
      (bar "CPU")
      (text "Blank")
      (bar "Memory")
      (bar "Swap")
    ]) // (with config.lib.htop; rightMeters [
      (text "Tasks")
      (text "LoadAverage")
      (text "Uptime")
      (text "Blank")
      (text "Battery")
      (text "Blank")
      (text "DiskIO")
      (text "NetworkIO")
    ]);
  };
}
