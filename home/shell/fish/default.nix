{ ... }:
{
	programs.fish = {
		enable = true;
		interactiveShellInit = ''
			set fish_greeting
			export PATH="/home/x/.local/bin:$PATH"
			export PATH="/home/x/.cargo/bin:$PATH"
		'';
		loginShellInit = ''
			set fish_greeting
			export PATH="/home/x/.local/bin:$PATH"
			export PATH="/home/x/.cargo/bin:$PATH"
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
		};
	};
}
