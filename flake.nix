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
        marco = home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
          modules = [
            ./common.nix
            ./xenomorph.nix
            ./zsh.nix
            ./git.nix
          ];
        };
      };
    };
}
