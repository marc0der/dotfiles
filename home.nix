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

  home.file = {
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
