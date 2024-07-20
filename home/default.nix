{ ... }:
{
	home = {
		username = "x";
		homeDirectory = "/home/x";
	};

    imports = [
        ./pkgs.nix
		./other
		./visual
		./shell
    ];

    home.stateVersion = "24.05";

    programs.home-manager.enable = true;
}
