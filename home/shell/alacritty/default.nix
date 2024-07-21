{ pkgs, lib, ... }:
{
	programs.alacritty = {
		enable = true;
		settings.font.normal.family = "JetBrainsMono Nerd Font";
	};
}
