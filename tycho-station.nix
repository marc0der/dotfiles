{ config, pkgs, ... }:

{
  home.file = {
    ".config/sway/config".source = sway/config-tycho-station;
    ".config/kanshi/config".source = kanshi/config-tycho-station;
  };
}
