{ pkgs, ... }:
{
	programs.fish = {
		enable = true;
		interactiveShellInit = ''
			set fish_greeting
			export PATH="/home/x/.local/bin:$PATH"
		'';
		shellAliases = {
			q = "exit";
			l = "ls -a -F";
			ls = "eza --icons";
			lg = "lazygit";
			cls = "clear";
			c = "clear";
			o = "nvim";
			vim = "nvim";
			light = "brightnessctl s";
			update = "nh os switch /home/x/nixos-config";
		};
	};
}
