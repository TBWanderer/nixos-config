{ pkgs, ... }: {
	imports = [ ./hardware-configuration.nix ];
	nixpkgs.config.allowUnfree = true;
	nix.settings.experimental-features = ["nix-command" "flakes"];

	time.timeZone = "Europe/Moscow";

	virtualisation.docker.enable = true;

	users = {
		users.x = {
			isNormalUser = true;
			openssh.authorizedKeys.keys = ["ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQC/92oici2so8a/1md5/SFr/SNhOLK/pCng3GfWAn635Xh6D+nT/VBF2AynCEvbNTvVXPu9Q5m5KMWVdmEHQbNGQ9+HN5XlDcK14RzeluNHYqzmWlTA4nJ2sUhyUchqgdeN0XGPiAShsrKhrPzHsai6S6Sv1U8U3G2kYuZXaoOa8Mh6bG5HPSB01sBP/ZpUA/2bw8oFtW/bOJSmI/xbTbpNkJyrl4WxeLKHmmarucPSxB2y/u+YMLDd/y6hoJE3cs72TrULaparGMWzMaRw7nmrbs8emtt5A/wMwVJECoHOYHvmImIJe95n8pnu2UxBsZG73wFautkLbiNPch6wnx6D3LxsthfvtlZGWNRX2XxMS4mdJgUcquJ8wlTIuqBZ7jfD0aDVFAQdn6Q5iCUrqs3PIKHImV7J4BOuHE2KlmQ9U9vE39LC3HQoYPPmf2rsZyT/VWKrwgVEML2+O1fx94fHa1vQg18nyU6ZiPivDLRxQrV7Qqscxecb3921aQlGQvs= proggerx@snd-tp"];
			extraGroups = [ "wheel" "docker" ];
			password = null;
		};
		users.root.openssh.authorizedKeys.keys = ["ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQC/92oici2so8a/1md5/SFr/SNhOLK/pCng3GfWAn635Xh6D+nT/VBF2AynCEvbNTvVXPu9Q5m5KMWVdmEHQbNGQ9+HN5XlDcK14RzeluNHYqzmWlTA4nJ2sUhyUchqgdeN0XGPiAShsrKhrPzHsai6S6Sv1U8U3G2kYuZXaoOa8Mh6bG5HPSB01sBP/ZpUA/2bw8oFtW/bOJSmI/xbTbpNkJyrl4WxeLKHmmarucPSxB2y/u+YMLDd/y6hoJE3cs72TrULaparGMWzMaRw7nmrbs8emtt5A/wMwVJECoHOYHvmImIJe95n8pnu2UxBsZG73wFautkLbiNPch6wnx6D3LxsthfvtlZGWNRX2XxMS4mdJgUcquJ8wlTIuqBZ7jfD0aDVFAQdn6Q5iCUrqs3PIKHImV7J4BOuHE2KlmQ9U9vE39LC3HQoYPPmf2rsZyT/VWKrwgVEML2+O1fx94fHa1vQg18nyU6ZiPivDLRxQrV7Qqscxecb3921aQlGQvs= proggerx@snd-tp"];
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

	programs.bash.interactiveShellInit = "(echo $(tty) | grep 'tty') && physlock";

	networking = {
		hostName = "suserv";
		firewall.enable = false;
		networkmanager.enable = true;
	};

	system.stateVersion = "24.05";
}
