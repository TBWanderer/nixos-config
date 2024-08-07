{ inputs, pkgs, ... }: {
	imports = [
		inputs.stylix.nixosModules.stylix
		../stylix
		./rust.nix
		./turnip.nix
		./yandex-music.nix
	];
	config = {
		environment.systemPackages = [
			inputs.cwe-cli.packages.${pkgs.stdenv.hostPlatform.system}.default
		];
	};
}
