{ config, pkgs, lib, ... }: 
{
	services.xserver.videoDrivers = lib.mkForce ["nvidia"];
	
	hardware = {
		opengl.enable = true;
		nvidia = {
			modesettings.enable = true;
			powerManagment = {
				enable = false;
				finegrained = false;
			};
			open = false;
			nvidiaSettings = true;
			package = config.boot.kernelPackages.nvidiaPackages.stable;
		};
	};
}
