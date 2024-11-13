{
	description = "Flake NixOS configuration";

	inputs = {
		nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    	stylix.url = "github:danth/stylix/04afcfc0684d9bbb24bb1dc77afda7c1843ec93b";	
		home-manager = {
			url = "github:nix-community/home-manager/";
			inputs.nixpkgs.follows = "nixpkgs";
		};
		rust-overlay = {
			url = "github:oxalica/rust-overlay";
		};
		# forkgram.url = "github:proggerx/forkgram-flake/main";
		# ayugram-desktop.url = "github:kaeeraa/ayugram-desktop/fe9d7b06e2d03cc8e8ab13290794882d11aff1d7";
		# zen-browser.url = "github:MarceColl/zen-browser-flake";
		yandex-music.url = "github:cucumber-sp/yandex-music-linux";
		cwe-cli = {
			url = "github:NotBalds/cwe-client-cli";
			inputs.nixpkgs.follows = "nixpkgs";
		};
	};

	outputs = { nixpkgs, home-manager, ... }@inputs: {
		nixosConfigurations = {
			laptop = nixpkgs.lib.nixosSystem {
				system = "x86_64-linux";
				specialArgs = { inherit inputs; };
				modules = [
					./modules/home.nix
					./modules/base.nix
					./modules/nvidia.nix
					./hosts/laptop/configuration.nix
					./hosts/laptop/hardware-configuration.nix
				];
			};
		};
	};
}
