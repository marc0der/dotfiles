{
  description = "Home Manager flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.05";
    home-manager.url = "github:nix-community/home-manager/release-24.05";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { self,  nixpkgs, home-manager, ... }@attrs:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
    in {
      homeConfigurations = {
        "marco@xenomorph" = home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
          modules = [
            ./common.nix
            ./git.nix
            ./report.nix
            ./xenomorph.nix
            ./zsh.nix
          ];
        };
        "marco@osiris" = home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
          modules = [
            ./common.nix
            ./git.nix
            ./osiris.nix
            ./report.nix
            ./work.nix
            ./zsh.nix
          ];
        };
        "marco@tycho-station" = home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
          modules = [
            ./common.nix
            ./git.nix
            ./report.nix
            ./tycho-station.nix
            ./work.nix
            ./zsh.nix
          ];
        };
      };
    };
}
