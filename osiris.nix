{ config, pkgs, ... }:

{
  home.file = {
    ".config/sway/config".source = sway/config-osiris;
    ".config/kanshi/config".source = kanshi/config-osiris;
  };
}
