{
    description = "Nixos flake";

    inputs = {
        nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
        home-manager = {
            url = "github:nix-community/home-manager/";
            inputs.nixpkgs.follows = "nixpkgs";
        };
		ags.url = "github:Aylur/ags";
    };

    outputs = { self, nixpkgs, home-manager, ags, ...}@inputs:
		let system = "x86_64-linux";
		in {
        nixosConfigurations = {
            nixos = nixpkgs.lib.nixosSystem {
                system = "${system}";
                
                modules = [
                    ./configuration.nix

					home-manager.nixosModules.home-manager
          			{
            			home-manager.useGlobalPkgs = true;
            			home-manager.useUserPackages = true;

            			home-manager.users.x = ./home-config/home.nix;
						
						home-manager.extraSpecialArgs = { inherit inputs; };
          			}
                ];
            };
		};
    };
}
