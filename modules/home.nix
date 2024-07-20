{ inputs, config, ... }:
{
	imports = [ inputs.home-manager.nixosModules.home-manager ];

	home-manager = {
		useGlobalPkgs = true;
		useUserPackages = true;
		backupFileExtention = "old";
		
		users = {
			x = ../home;
		};

		extraSpecialArgs = {
			inherit inputs;
			sys = config;
		};
	};
	programs.home-manager.enable = true;
}
