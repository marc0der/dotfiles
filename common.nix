{ config, pkgs, ... }:

{
  home.username = "marco";
  home.homeDirectory = "/home/marco";
  home.stateVersion = "24.11";

  nixpkgs.config.allowUnfree = true;

  home.packages = with pkgs; [
    # packages
    autojump
    bat
    borgbackup
    fzf
    gh
    htop
    httpie
    nodePackages.jsonlint
    lazygit
    mpv
    ncdu
    nmap
    nixfmt-rfc-style
    rclone
    ripgrep
    speedtest-rs
    vscode
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
    ".gnupg/gpg-agent.conf".source = gnupg/gpg-agent.conf;
    ".gnupg/gpg.conf".source = gnupg/gpg.conf;

    # hyprland
    # ".config/hypr/hyprland.conf".source = hypr/hyprland.conf;

    # kitty
    # ".config/kitty/kitty.conf".source = kitty/kitty.conf;

    # dunst
    # ".config/dunst/dunstrc".source = dunst/dunstrc;

    # waybar
    # ".config/waybar/config.jsonc".source = waybar/config.jsonc;
    # ".config/waybar/style.css".source = waybar/style.css;

    # kanshi
    # ".config/systemd/user/kanshi.service".source = systemd/kanshi.service;

    # foot
    # ".config/foot/foot.ini".source = foot/foot.ini;

    # bin scripts
    # "bin/next-wallpaper.sh".source = bin/next-wallpaper.sh;
    # "bin/previous-wallpaper.sh".source = bin/previous-wallpaper.sh;

    ".local/share/applications/discord.desktop".source = desktop/discord.desktop;
    ".local/share/applications/todoist.desktop".source = desktop/todoist.desktop;
  };

  fonts.fontconfig.enable = true;

  home.sessionVariables = {
    EDITOR = "nvim";
    POWERLEVEL9K_DISABLE_CONFIGURATION_WIZARD = "true";
  };

  home.sessionPath = ["$HOME/bin"];

  home.changes-report.enable = true;

  programs.home-manager.enable = true;
}
