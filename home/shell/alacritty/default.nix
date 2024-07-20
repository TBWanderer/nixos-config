{ pkgs, lib, ... }:
{
	programs.alacritty = {
		enable = true;
		font = {
			package = lib.mkForce (pkgs.nerdfonts.override { fonts = [ "JetBrainsMono" ]; });
			name = lib.mkForce "JetBrainsMono Nerd Font";
		};
	};
}
