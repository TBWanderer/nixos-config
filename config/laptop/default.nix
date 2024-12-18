{ lib, pkgs, inputs, ... }:
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
		kernelPackages = pkgs.linuxKernel.packages.linux_6_11;
	};

	hardware = {
		bluetooth = {
			enable = true;
			powerOnBoot = true;
		};
		pulseaudio.enable = lib.mkForce false;
	};

	services = {
		pipewire = {
			enable = true;
			pulse.enable = true;
		};
		
		tailscale.enable = true;
		blueman.enable = true;
		libinput.enable = true;
		openssh.enable = true;
		getty.autologinUser = "x";
		resolved.enable = true;

		xserver = {
			desktopManager.cinnamon.enable = true;	
		};
	};

	networking = {
		hostName = "laptop";
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
	
	xdg.portal.enable = true;

	time.timeZone = "Europe/Moscow";

	nixpkgs.config.allowUnfree = true;

	environment = {
		sessionVariables = {
			PATH = [
				"/usr/bin"
				"/home/x/.local/bin"
				"/home/x/.cargo/bin"
			];
			EDITOR = "vim";
			DIRENV_LOG_FORMAT = "";
		};
		systemPackages = with pkgs; [
			( import ../../modules/laptop/home/visual/lockscreen { inherit pkgs; } )
			
			(pkgs.wrapOBS {
    			plugins = with pkgs.obs-studio-plugins; [
    				wlrobs
    				obs-backgroundremoval
    				obs-pipewire-audio-capture
    			];
			})

			inputs.pabc-nix

			xdg-desktop-portal-hyprland
			wireguard-tools
			openssl
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
			steamcmd
			steam-tui
			wl-clipboard
		];
	};

	fonts.packages = with pkgs; [(
		(pkgs.nerdfonts.override { fonts = [ "JetBrainsMono" ]; })
	)];
	
	virtualisation = {
		waydroid.enable = true;
		docker.enable = true;
		virtualbox.host = {
			enable = true;
			enableExtensionPack = true;
		};
		libvirtd.enable = true;
	};

	programs = {
		git.enable = true;
		hyprland.enable = true;
		fish.enable = true;
		wireshark.enable = true;
		nix-ld.enable = true;
		starship.enable = true;
		yandex-music = {
			enable = true;
			tray.enable = true;
		};
		steam = {
			enable = true;
			remotePlay.openFirewall = true;
			dedicatedServer.openFirewall = true;
		};
		virt-manager.enable = true;
	};

	nix = {
		package = pkgs.nixVersions.stable;
		extraOptions = ''
			experimental-features = nix-command flakes
		'';
		settings = {
			substituters = [
				"https://cache.garnix.io"
			];
			trusted-public-keys = [
				"cache.garnix.io:CTFPyKSLcx5RMJKfLo5EEPUObbA78b0YQ2DTCJXqr9g="
			];
		};
	};

	users.users = {
		x = {
			isNormalUser = true;
			extraGroups = [ "wheel" "wireshark" "docker" "vboxusers" ];
			shell = pkgs.fish;
		#	 packages = with pkgs; [
		#		 firefox
		#		 tree
		#	 ];
		};
		root.shell = pkgs.fish;
	};

	system.stateVersion = "24.11"; 
}

