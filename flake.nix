{
	description = "Flake NixOS configuration";

	inputs = {
		nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.11";
    	stylix.url = "github:danth/stylix/release-24.11";	
		home-manager = {
			url = "github:nix-community/home-manager/release-24.11";
			inputs.nixpkgs.follows = "nixpkgs";
		};
		rust-overlay.url = "github:oxalica/rust-overlay";
		ayugram-desktop.url = "github:kaeeraa/ayugram-desktop/release?submodules=1";
		zen-browser.url = "github:MarceColl/zen-browser-flake";
		yandex-music.url = "github:cucumber-sp/yandex-music-linux";
		cwe-cli = {
			url = "github:NotBalds/cwe-rust-cli";
			inputs.nixpkgs.follows = "nixpkgs";
		};
		deploy-rs.url = "github:serokell/deploy-rs";
		flux.url = "github:Bananad3v/flux";
		pabc-nix = {
			url = "github:ProggerX/pabc-nix";
			inputs.nixpkgs.follows = "nixpkgs";
		};
	};

	outputs = { nixpkgs, home-manager, ... }@inputs: {
		nixosConfigurations = {
			laptop = nixpkgs.lib.nixosSystem {
				system = "x86_64-linux";
				specialArgs = { inherit inputs; };
				modules = [
					./modules/laptop
					./config/laptop
				];
			};
			suserv = nixpkgs.lib.nixosSystem {
				system = "x86_64-linux";
				specialArgs = { inherit inputs; };
				modules = [
					./config/suserv
					./modules/suserv
				];
			};
		};
		deploy.nodes.suserv = {
            hostname = "suserv";
            profiles.system = {
                user = "root";
                sshUser = "root";
                path = inputs.deploy-rs.lib.x86_64-linux.activate.nixos inputs.self.nixosConfigurations.suserv;
            };
        };
	};
}
