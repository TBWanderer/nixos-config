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
#			inputs.ayugram-desktop.packages.${pkgs.system}.ayugram-desktop
		];
	};
}
