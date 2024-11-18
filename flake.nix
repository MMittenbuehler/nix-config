{
  description = "My NixOS Config";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.05";

    home-manager = {
      url = "github:nix-community/home-manager/release-24.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    sops-nix = {
      url = "github:mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.nixpkgs-stable.follows = "nixpkgs";
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

    nixosConfigurations = {
      apq-121-mmit = lib.nixosSystem {
        specialArgs = {inherit inputs outputs;};
        modules = [
          ./hosts/apq-121-mmit
        ];
      };

      xps5960-mmit = lib.nixosSystem {
        specialArgs = {inherit inputs outputs;};
        modules = [
          ./hosts/xps5960-mmit
        ];
      };
    };

    homeConfigurations = {
      "marcel@apq-121-mmit" = home-manager.lib.homeManagerConfiguration {
        pkgs = pkgsFor.x86_64-linux;
	      extraSpecialArgs = {inherit inputs outputs;};
	      modules = [./home/marcel/apq-121-mmit.nix];
      };
      "marcel@xps5960-mmit" = home-manager.lib.homeManagerConfiguration {
        pkgs = pkgsFor.x86_64-linux;
	      extraSpecialArgs = {inherit inputs outputs;};
	      modules = [./home/marcel/xps5960-mmit.nix];
      };
    };
  };
}

