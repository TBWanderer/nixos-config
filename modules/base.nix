{ inputs, pkgs, ... }: {
	imports = [
		inputs.stylix.nixosModules.stylix
		../stylix
		./rust.nix
		./yandex-music.nix
		./spoofdpi.nix
	];
	config = {
		services.spoofdpi.enable = true;
		environment.systemPackages = [
			inputs.cwe-cli.packages.${pkgs.system}.default
			inputs.ayugram-desktop.packages.${pkgs.system}.default
			inputs.zen-browser.packages.${pkgs.system}.default
		];
	};
}
