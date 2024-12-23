{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    ansible
    doctl
    rustup
  ];
  home.file = {
    ".config/sway/config".source = sway/config-xenomorph;
  };
}
