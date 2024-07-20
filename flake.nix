{
	description = "Flake NixOS configuration";

	inputs = {
		nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    	stylix.url = "github:danth/stylix";	
		home-manager = {
			url = "github:nix-community/home-manager/";
			inputs.nixpkgs.follows = "nixpkgs";
		};
	};

	outputs = { nixpkgs, home-manager, ... }@inputs: {
		nixosConfigurations = {
			laptop = {
				system = "x86_64-linux";
				specialArgs = { inherit inputs; };
				modules = [
					./modules/home.nix
					./mosules/base.nix
					./modules/nvidia.nix
					./hosts/laptop/configuration.nix
					./hosts/laptop/hardware-configuration.nix
				];
			};
		};
	};
}
