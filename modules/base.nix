{ inputs, ... }: {
	imports = [
		inputs.turnip.nixosModules.turnip
		inputs.stylix.nixosModules.stylix
		../stylix
		./rust.nix
	];
	config = {
		turnip.enable = true;
	};
}
