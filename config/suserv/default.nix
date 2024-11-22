{ pkgs, ... }: {
	imports = [ ./hardware-configuration.nix ./modules.nix ];
	nixpkgs.config.allowUnfree = true;
	nix.settings.experimental-features = ["nix-command" "flakes"];

	time.timeZone = "Europe/Moscow";

	virtualisation.docker.enable = true;

	users = {
		users.x = {
			isNormalUser = true;
			shell = pkgs.fish;

			openssh.authorizedKeys.keys = ["ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQC/92oici2so8a/1md5/SFr/SNhOLK/pCng3GfWAn635Xh6D+nT/VBF2AynCEvbNTvVXPu9Q5m5KMWVdmEHQbNGQ9+HN5XlDcK14RzeluNHYqzmWlTA4nJ2sUhyUchqgdeN0XGPiAShsrKhrPzHsai6S6Sv1U8U3G2kYuZXaoOa8Mh6bG5HPSB01sBP/ZpUA/2bw8oFtW/bOJtemI/xbTbpNkJyrl4WxeLKHmmarucPSxB2y/u+YMLDd/y6hoJE3cs72TrULaparGMWzMaRw7nmrbs8emtt5A/wMwVJECoHOYHvmImIJe95n8pnu2UxBsZG73wFautkLbiNPch6wnx6D3LxsthfvtlZGWNRX2XxMS4mdJgUcquJ8wlTIuqBZ7jfD0aDVFAQdn6Q5iCUrqs3PIKHImV7J4BOuHE2KlmQ9U9vE39LC3HQoYPPmf2rsZyT/VWKrwgVEML2+O1fx94fHa1vQg18nyU6ZiPivDLRxQrV7Qqscxecb3921aQlGQvs= proggerx@snd-tp"];
			extraGroups = [ "wheel" "docker" ];
			hashedPassword = "$y$j9T$mTVi.ZRsPqyFSL6av2AyU/$Wx1kNWLvDgNTvuD9Pj9DIla3SMiT1YwEmMPlqWg3sV.";
		};
		users.root = {
			shell = pkgs.fish;

			openssh.authorizedKeys.keys = ["ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQC/92oici2so8a/1md5/SFr/SNhOLK/pCng3GfWAn635Xh6D+nT/VBF2AynCEvbNTvVXPu9Q5m5KMWVdmEHQbNGQ9+HN5XlDcK14RzeluNHYqzmWlTA4nJ2sUhyUchqgdeN0XGPiAShsrKhrPzHsai6S6Sv1U8U3G2kYuZXaoOa8Mh6bG5HPSB01sBP/ZpUA/2bw8oFtW/bOJSmI/xbTbpNkJyrl4WxeLKHmmarucPSxB2y/u+YMLDd/y6hoJE3cs72TrULaparGMWzMaRw7nmrbs8emtt5A/wMwVJECoHOYHvmImIJe95n8pnu2UxBsZG73wFautkLbiNPch6wnx6D3LxsthfvtlZGWNRX2XxMS4mdJgUcquJ8wlTIuqBZ7jfD0aDVFAQdn6Q5iCUrqs3PIKHImV7J4BOuHE2KlmQ9U9vE39LC3HQoYPPmf2rsZyT/VWKrwgVEML2+O1fx94fHa1vQg18nyU6ZiPivDLRxQrV7Qqscxecb3921aQlGQvs= proggerx@snd-tp"];
		};
		mutableUsers = false;
	};

	boot = {
		loader = {
			efi.canTouchEfiVariables = false;
			grub = {
				efiSupport = true;
				efiInstallAsRemovable = true;
				device = "nodev";
				enable = true;
			};
			systemd-boot.enable = false;
		};
	};

	environment.systemPackages = with pkgs; [
		git
		btop
		neovim
		wget
		curl

		lazygit
		eza
		tree
		brightnessctl
		ripgrep
	];

	services = {
		physlock = {
			allowAnyUser = true;
			enable = true;
		};
		getty.autologinUser = "x";
		tailscale.enable = true;
		openssh = {
	        enable = true;
		};
		logind = {
			powerKey = "ignore";
			lidSwitch = "ignore";
		};
		frp = {
			enable = true;
			role = "client";
			settings = {
				serverAddr = "5.35.87.192";
				serverPort = 7000;
			};
		};
	};

	# systemd = {
	# 	services.reboot-service = {
    # 		description = "Reboot Service";
    #		serviceConfig = {
    #			Type = "oneshot";
    #			ExecStart = "${pkgs.systemd}/bin/systemctl reboot";
	#		};
    #		wantedBy = [ "multi-user.target" ];
	#	};
	
	#	timers.reboot-timer = {
    #		description = "Reboot the system every 6 hours";
    #		timerConfig = {
    #			OnCalendar = "every 6 hours";
    #			Persistent = false;
	#		};
	#		wantedBy = [ "timers.target" ];
	#	};
	# };

	programs = {
		starship.enable = true;
		fish = {
			enable = true;
			loginShellInit = "echo $(tty) | grep tty && physlock";
			interactiveShellInit = "set fish_greeting";
			shellAliases = {
				q = "exit";
				l = "ls -a -F";
				ls = "eza --icons";
				lg = "lazygit";
				cls = "clear";
				c = "clear";
				o = "nvim";
				light = "brightnessctl s";
			};
		};
	};

	networking = {
		hostName = "suserv";
		firewall.enable = false;
		networkmanager.enable = true;
	};

	system.stateVersion = "24.05";
}
