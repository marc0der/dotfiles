{ config, pkgs, ... }:

{
  home.file = {
    ".p10k.zsh".source = powerline/p10k;
  };

  programs.zsh = {
    enable = true;
    initExtra = "
      source ${pkgs.zsh-powerlevel10k}/share/zsh-powerlevel10k/powerlevel10k.zsh-theme
      source /home/marco/.sdkman/bin/sdkman-init.sh
      source ${pkgs.autojump}/share/autojump/autojump.zsh
      [ -f ${config.home.homeDirectory}/.sdkman/bin/sdkman-init.sh ] && source ${config.home.homeDirectory}/.sdkman/bin/sdkman-init.sh
      [ -f ${config.home.homeDirectory}/.sde/profile/profile.sh ] && source ${config.home.homeDirectory}/.sde/profile/profile.sh
    ";
    shellAliases = {
      #nix
      nix-home = "home-manager --flake $HOME/dotfiles";
      nix-gc = "nix-collect-garbage";

      # general
      gco = "git checkout";
      gcob = "git checkout -b";
      ga = "git add";
      gaa = "git add .";
      gap = "git add -p";
      gs = "git status";
      gd = "git diff";
      gdt = "git difftool";
      gl = "git log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit --date=relative";
      gc = "git commit --verbose";
      gcm = "git commit --message --verbose";
      gca = "git commit --amend --verbose";
      gpusho = "git push origin";
      gpushob = "git push --set-upstream origin";
      gpushof = "git push --force origin";
      gpullo = "git pull --rebase origin";
      gfo = "git fetch origin";
      gr = "git rebase";
      gst = "git stash";
      gsta = "git stash apply";
      gstp = "git stash pop";
      gstl = "git stash list";

      swaycfg = "nvim ~/.config/sway/config";
      open = "xdg-open";
      vi = "nvim";
      vim = "nvim";
      suvi = "pkexec nvim";
      ll = "ls -lah";
    };
    history = {
      size = 100000;
    };
    oh-my-zsh = {
      enable = true;
      plugins = [ "fzf" "gh" "git" "docker" "sudo" "aws" "doctl" ];
      theme = "wezm+";
    };
  };
}
