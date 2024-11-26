{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    adrs
    autojump
    awscli2
    bat
    borgbackup
    dell-command-configure
    fzf
    git
    gcc
    go
    htop
    lazygit
    mpv
    ncdu
    nixfmt-rfc-style
    nodejs_22
    okta-aws-cli
    pinentry
    rclone
    speedtest-rs
    vscode
    wmctrl
    yamllint
    yt-dlp

    font-awesome
    noto-fonts
    noto-fonts-emoji
    jetbrains-mono
    (pkgs.nerdfonts.override { fonts = [ "JetBrainsMono" "Noto" ]; })
  ];
}
