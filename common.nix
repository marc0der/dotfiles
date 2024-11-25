{ config, pkgs, ... }:

{
  home.username = "marco";
  home.homeDirectory = "/var/home/marco";
  home.stateVersion = "24.05";

  home.file = {
    # sway
    ".config/sway/config".source = sway/config;
    ".config/sway/config.d/50-rules-browser.conf".source = sway/config.d/50-rules-browser.conf;
    ".config/sway/config.d/50-rules-pavucontrol.conf".source = sway/config.d/50-rules-pavucontrol.conf;
    ".config/sway/config.d/50-rules-policykit-agent.conf".source = sway/config.d/50-rules-policykit-agent.conf;
    ".config/sway/config.d/60-bindings-brightness.conf".source = sway/config.d/60-bindings-brightness.conf;
    ".config/sway/config.d/60-bindings-media.conf".source = sway/config.d/60-bindings-screenshot.conf;
    ".config/sway/config.d/60-bindings-screenshot.conf".source = sway/config.d/60-bindings-volume.conf;
    ".config/sway/config.d/60-bindings-volume.conf".source = sway/config.d/65-mode-passthrough.conf;
    ".config/sway/config.d/65-mode-passthrough.conf".source = sway/config.d/90-bar.conf;
    ".config/sway/config.d/90-bar.conf".source = sway/config.d/90-swayidle.conf;
    ".config/sway/config.d/90-swayidle.conf".source = sway/config.d/95-autostart-policykit-agent.conf;
    ".config/sway/config.d/95-autostart-policykit-agent.conf".source = sway/config.d/95-xdg-desktop-autostart.conf;
    ".config/sway/config.d/95-xdg-desktop-autostart.conf".source = sway/config.d/95-xdg-user-dirs.conf;
    ".config/sway/config.d/95-xdg-user-dirs.conf".source = sway/config.d/95-xdg-user-dirs.conf;
    ".gnupg/gpg-agent.conf".source = gnupg/gpg-agent.conf;
    ".gnupg/gpg.conf".source = gnupg/gpg.conf;

    # dunst
    ".config/dunst/dunstrc".source = dunst/dunstrc;
    ".config/dunst/open_link.sh".source = dunst/open_link.sh;
  };

  fonts.fontconfig.enable = true;

  home.sessionVariables = {
    EDITOR = "nvim";
    POWERLEVEL9K_DISABLE_CONFIGURATION_WIZARD = "true";
  };

  home.sessionPath = ["$HOME/bin"];

  programs.home-manager.enable = true;
}
