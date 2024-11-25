{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    # packages
    autojump
    bat
    borgbackup
    doctl
    fzf
    git
    htop
    lazygit
    mpv
    ncdu
    nixfmt-rfc-style
    pinentry
    rclone
    rustup
    speedtest-rs
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
}
