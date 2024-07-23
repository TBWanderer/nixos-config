{ inputs, ... }:
{
	imports = [
		inputs.turnip.nixosModules.turnip
		../home/shell/turnip
	];
	config = {
		turnip.enable = true;
	};
	
}
