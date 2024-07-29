{ inputs, ... }: {
	imports = [
		inputs.stylix.nixosModules.stylix
		../stylix
		./rust.nix
		./turnip.nix
		./yandex-music.nix
	];
}
