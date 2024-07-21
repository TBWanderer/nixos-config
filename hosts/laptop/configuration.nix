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
		
		xserver = {
			desktopManager.cinnamon.enable = true;	
		};
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


	nixpkgs.config.allowUnfree = true;

	environment.systemPackages = with pkgs; [
		( import ../../home/visual/lockscreen { inherit pkgs; } )
		vim 
		wget
		neovim
		gitFull
		github-cli
		lynx
		fish
		unzip
		gcc
		zulu17
		exiftool
		cliphist
		lazygit
		kdePackages.breeze-icons
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
		starship.enable = true;
	};

	nix = {
		package = pkgs.nixFlakes;
		extraOptions = ''
			experimental-features = nix-command flakes
		'';
	};

	users.users.x = {
		isNormalUser = true;
		extraGroups = [ "wheel" ];
		shell = pkgs.fish;
	#	 packages = with pkgs; [
	#		 firefox
	#		 tree
	#	 ];
	};

	system.stateVersion = "24.11"; 
}

