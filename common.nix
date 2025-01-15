{ config, pkgs, ... }:

{
  home.username = "marco";
  home.homeDirectory = "/var/home/marco";
  home.stateVersion = "24.05";

  nixpkgs.config.allowUnfree = true;

  home.packages = with pkgs; [
    # packages
    autojump
    bat
    borgbackup
    brave
    fzf
    gh
    git
    htop
    httpie
    nodePackages.jsonlint
    lazygit
    mpv
    ncdu
    nmap
    nixfmt-rfc-style
    pinentry
    rclone
    speedtest-rs
    vscode
    wmctrl
    yamllint
    zsh-powerlevel10k

    # fonts
    font-awesome
    noto-fonts
    noto-fonts-emoji
    jetbrains-mono
    (pkgs.nerdfonts.override { fonts = [ "JetBrainsMono" "Noto" ]; })
  ];

  home.file = {
    # sway
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

    # waybar
    ".config/waybar/config.jsonc".source = waybar/config.jsonc;
    ".config/waybar/style.css".source = waybar/style.css;

    # foot
    ".config/foot/foot.ini".source = foot/foot.ini;
  };

  fonts.fontconfig.enable = true;

  home.sessionVariables = {
    EDITOR = "nvim";
    POWERLEVEL9K_DISABLE_CONFIGURATION_WIZARD = "true";
  };

  home.sessionPath = ["$HOME/bin"];

  home.changes-report.enable = true;

  home.file = {
    ".local/share/applications/discord.desktop".source = desktop/discord.desktop;
  };

  programs.home-manager.enable = true;
}
