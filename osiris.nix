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
    okta-aws-cli
    rclone
    vscode
    yt-dlp
  ];
}
