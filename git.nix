{ config, pkgs, ... }:

{
  programs = {
    git = {
      enable = true;
      userEmail = "vermeulen.mp@gmail.com";
      userName = "Marco Vermeulen";
      extraConfig = {
        init.defaultBranch = "main";
        commit.gpgSign = true;
        core.autocrlf = "input";
      };
      signing.key = "E1C2A16A9D3C07D3E75FA13847F7ABD6F9FBD428";
    };
  };
}

