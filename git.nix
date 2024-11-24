{ config, pkgs, ... }:

{
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
  };
}

