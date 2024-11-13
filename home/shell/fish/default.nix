{ ... }:
{
	programs.fish = {
		enable = true;
		interactiveShellInit = ''
			set fish_greeting
		'';
		loginShellInit = ''
			Hyprland
		'';
		shellAliases = {
			q = "exit";
			l = "ls -a -F";
			ls = "eza --icons";
			lg = "lazygit";
			cls = "clear";
			c = "clear";
			o = "nvim";
			og = "neovide";
			vim = "nvim";
			light = "brightnessctl s";
			update = "nh os switch /home/x/nixos-config";
			deploy = "nix run github:serokell/deploy-rs -- -s /home/x/server-config#suserv";
		};
	};
}
