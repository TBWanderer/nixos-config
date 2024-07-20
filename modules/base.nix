{ inputs, ... }: {
	imports = [
		inputs.stylix.nixosModules.stylix
		../stylix
		../modules/rust.nix
	];
}
