{
  description = "My NixOS Config";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.05";

    home-manager = {
      url = "github:nix-community/home-manager/release-24.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, systems, ... }@inputs: let
    inherit (self) outputs;
    lib = nixpkgs.lib // home-manager.lib;
    pkgsFor = lib.genAttrs (import systems) (
      system:
        import nixpkgs {
          inherit system;
          config.allowUnfree = true;
        }
    );
  in {
    inherit lib;

    nixosConfigurations.apq-personal = lib.nixosSystem {
      specialArgs = {inherit inputs outputs;};
      modules = [
        ./hosts/apq-personal
      ];
    };

    homeConfigurations = {
      "mmittenbuehler@mmit-121-pc" = home-manager.lib.homeManagerConfiguration {
        pkgs = pkgsFor.x86_64-linux;
	extraSpecialArgs = {inherit inputs outputs;};
	modules = [./home-manager/home.nix];
      };
    };
  };
}

