{ inputs, pkgs, ... }: {
	imports = [
		inputs.stylix.nixosModules.stylix
		../stylix
		../yandex-music.nix
		../sys
		../dev
		./home.nix
	];
	config = {
		services.spoofdpi.enable = true;
		environment.systemPackages = [
#			inputs.ayugram-desktop.packages.${pkgs.system}.ayugram-desktop
		];
	};
}
