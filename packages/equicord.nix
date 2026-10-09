{ pkgs, ... }:

(pkgs.discord.override {
  withEquicord = true;
})