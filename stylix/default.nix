{ pkgs, ... }:
{
	stylix = {
		enable = true;
		image = ./wallpaper.jpeg;
		opacity = {
			terminal = 0.8;
			desktop = 0.8;
			applications = 0.8;
		};
		fonts = rec {
			sizes = {
				terminal = 14;
			};
			serif = {
				package = (pkgs.nerdfonts.override { fonts = [ "JetBrainsMono" ]; });
				name = "JetBrainsMono Nerd Font";
			};
			sansSerif = serif;
			monospace = serif;
			emoji = {
				package = pkgs.noto-fonts-emoji;
				name = "Noto Color Emoji";
			};
		};
		cursor = {
			name = "Fuchsia-Pop";
			size = 24;
			package = (pkgs.fuchsia-cursor.override { themeVariants = ["Fuchsia-Pop"]; sizeVariants = ["24"]; platformVariants = ["x11"];});
		};
		base16Scheme = "${pkgs.base16-schemes}/share/themes/catppuccin-macchiato.yaml";
		
		polarity = "dark";
	};
}
