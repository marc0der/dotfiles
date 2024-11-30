{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    adrs
    awscli2
    dell-command-configure
    gcc
    go
    lazygit
    nodejs_22
    python312
    python312Packages.pip
    okta-aws-cli
    rclone
    vscode
    yt-dlp
  ];
}
