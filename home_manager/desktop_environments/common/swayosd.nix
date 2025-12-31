{
  cmd = {
    server = "swayosd-server";
    volumeUp = "swayosd-client --output-volume raise --max-volume 175";
    volumeDown = "swayosd-client --output-volume lower --max-volume 175";
    volumeMute = "swayosd-client --output-volume mute-toggle";
    micMute = "swayosd-client --input-volume mute-toggle";
    brightnessUp = "swayosd-client --brightness +10";
    brightnessDown = "swayosd-client --brightness -10";
    capsLock = "swayosd-client --caps-lock";
    numLock = "swayosd-client --num-lock";
    scrollLock = "swayosd-client --scroll-lock";
  };

  module = { lib, ... }: {
    services.swayosd = {
      enable = lib.mkDefault true;
    };
  };
}
