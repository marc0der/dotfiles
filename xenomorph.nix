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
    mpv-unwrapped
    ncdu
    rclone
    rustup
    zsh-powerlevel10k

    # fonts
    font-awesome
    jetbrains-mono
    (pkgs.nerdfonts.override { fonts = [ "JetBrainsMono" "Noto" ]; })
  ];
}
