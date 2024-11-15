{ config, pkgs, ... }:

{
  home.username = "marco";
  home.homeDirectory = "/var/home/marco";
  home.stateVersion = "24.05";

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

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    "~/.config/sway/config".source = ./sway/config;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };

  home.sessionVariables = {
    EDITOR = "nvim";
    POWERLEVEL9K_DISABLE_CONFIGURATION_WIZARD = "true";
  };

  home.sessionPath = ["$HOME/bin"];

  # home.nix
  programs = {
    git = {
      enable = true;
      userEmail = "vermeulen.mp@gmail.com";
      userName = "Marco Vermeulen";
      extraConfig = {
        init.defaultBranch = "main";
        commit.gpgSign = false;
        core.autocrlf = "input";
      };
    };

    zsh = {
      enable = true;
      initExtra = "
source ${pkgs.zsh-powerlevel10k}/share/zsh-powerlevel10k/powerlevel10k.zsh-theme
source /var/home/marco/.sdkman/bin/sdkman-init.sh
source ${pkgs.autojump}/share/autojump/autojump.zsh
          ";
      shellAliases = {
        #nix
        nix-home = "home-manager";
        nix-switch-flake = "nix-home switch --flake $HOME/dotfiles";
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
        gpushof = "git push --force origin ";
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
        plugins = [ "fzf" "git" "docker" "sudo" "aws" "doctl" ];
        theme = "wezm+";
      };
    };

    home-manager.enable = true;
  };
}
