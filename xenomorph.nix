{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    doctl
    rustup
  ];
  home.file = {
    ".config/sway/config".source = sway/config-xenomorph;
  };
}
