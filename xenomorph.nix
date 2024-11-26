{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    doctl
    rustup
  ];
}
