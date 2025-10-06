{
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-25.05";
    home-manager = {
     url = "github:nix-community/home-manager?ref=release-25.05";
     inputs.nixpkgs.follows = "nixpkgs";
    };
    nvf.url = "github:notashelf/nvf";
  };

  outputs = { self, nixpkgs, nvf, ... }@inputs:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
    in
    {

    tims-neovim = (nvf.lib.neovimConfiguration {
        inherit pkgs;
        modules = [ ./nvf/configuration.nix ];
    }).neovim;

    nixosConfigurations = {
      tims-nixos-machine = nixpkgs.lib.nixosSystem {
        inherit system;
	
        specialArgs = { inherit inputs; };

        modules = [
          ./nixos/configuration.nix
                ./home
                inputs.home-manager.nixosModules.home-manager
                ({pkgs, ...}: {
                  environment.systemPackages = [self.tims-neovim];
                })
        ];
      };
    };
  };
}
