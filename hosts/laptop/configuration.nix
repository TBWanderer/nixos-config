{ config, lib, pkgs, ... }:
{
	imports = [
			./hardware-configuration.nix
	];

	boot = {
		loader = {
			systemd-boot.enable = false;
			efi = {
				canTouchEfiVariables = false;
			};
			grub = {
				enable = true;
				efiInstallAsRemovable = true;
				efiSupport = true;
				device = "nodev";
			};
		};
		supportedFilesystems = [
			"ntfs"
		];
	};

	hardware = {
		bluetooth = {
			enable = true;
			powerOnBoot = true;
		};
	};

	services = {
		pipewire = {
			enable = true;
			pulse.enable = true;
		};

		blueman.enable = true;
		libinput.enable = true;
		openssh.enable = true;
	};

	networking = {
		hostName = "nixos-lp";
		networkmanager.enable = true;
		proxy = {
		# 	default = "http://user:password@host.com:1234/";
		# 	noProxy = "127.0.0.1,localhost";
		};
		firewall = {
			enable = false;
		# 	allowedTCPPorts = [ ... ];
		# 	allowedUDPPorts = [ ... ];
		};
	};
	
	time.timeZone = "Europe/Moscow";

	# services.xserver.enable = true;

	# services.xserver.xkb.layout = "us";
	# services.xserver.xkb.options = "eurosign:e,caps:escape";

	users.users.x = {
		isNormalUser = true;
		extraGroups = [ "wheel" ];
	#	 packages = with pkgs; [
	#		 firefox
	#		 tree
	#	 ];
	};

	nixpkgs.config.allowUnfree = true;

	environment.systemPackages = with pkgs; [
		( import ../../home/visual/lockscreen { inherit pkgs; } )
		vim 
		wget
		neovim
		gitFull
		github-cli
		lynx
		hyprland
		alacritty
		fish
		brave
		unzip
		gcc
		waybar
		rofi-wayland
		audacity
		bluez
		blueman
		cinnamon.nemo
		zulu17
		exiftool
		swayimg
		cliphist
		swaylock-effects
		grim
		slurp
		wl-clipboard
		lazygit
		wine
		pamixer
	];

	fonts.packages = with pkgs; [(
		nerdfonts.override { 
			fonts = [ "JetBrainsMono" ];
		}
	)];

	programs = {
		git.enable = true;
		hyprland.enable = true;
		fish.enable = true;
	};

	nix = {
		package = pkgs.nixFlakes;
		extraOptions = ''
			experimental-features = nix-command flakes
		'';
	};

	system.stateVersion = "24.11"; 
}

