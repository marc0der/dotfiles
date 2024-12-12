{ config, pkgs, ... }:

{
  home.file = {
    ".config/sway/config".source = sway/config-osiris;
  };
}
