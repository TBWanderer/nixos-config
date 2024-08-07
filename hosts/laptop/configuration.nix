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
		kernelPackages = pkgs.linuxKernel.packages.linux_6_10;
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
			( import ../../home/visual/lockscreen { inherit pkgs; } )
			
			inputs.forkgram.packages.x86_64-linux.default
			
			(pkgs.wrapOBS {
    			plugins = with pkgs.obs-studio-plugins; [
    				wlrobs
    				obs-backgroundremoval
    				obs-pipewire-audio-capture
    			];
			})
			
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
		nerdfonts.override { 
			fonts = [ "JetBrainsMono" ];
		}
	)];
	
	virtualisation = {
		waydroid.enable = true;
		docker.enable = true;
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
		steam.enable = true;
		steam = {
			remotePlay.openFirewall = true;
			dedicatedServer.openFirewall = true;
		};
	};

	nix = {
		package = pkgs.nixFlakes;
		extraOptions = ''
			experimental-features = nix-command flakes
		'';
	};

	users.users.x = {
		isNormalUser = true;
		extraGroups = [ "wheel" "wireshark" "docker" ];
		shell = pkgs.fish;
	#	 packages = with pkgs; [
	#		 firefox
	#		 tree
	#	 ];
	};

	system.stateVersion = "24.11"; 
}

