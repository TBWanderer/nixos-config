{ pkgs, ... }:
let bridge1 = "obfs4 162.19.71.193:36008 48018773C90C12DE938BDAC479050941199D3C07 cert=ABjvf9HdytJ1gzVyY2faM8j97PS5iVwV+hGQ1UVVJL/XVlaHhvP/pU+kPSY+ukW2fGnLXw iat-mode=0";
bridge2 = "obfs4 152.228.212.166:17125 2FC21061C9A08A8C92C7231A0B1450CC3AAFB64C cert=rAEsjIrp1dlvGP805ajUXZ8XTsD2G3Jgb7y24lTthOhcidPomEKJGHJype2Qgh0JDN2UVQ iat-mode=0";
torrc = pkgs.writeText "torrc" ''
	UseBridges 1
	ClientTransportPlugin obfs4 exec ${pkgs.obfs4}/bin/lyrebird
	Bridge ${bridge1}
	Bridge ${bridge2}
''; in {
	systemd.user.services.tor-proxy = {
		Service = {
			ExecStart = "${pkgs.tor}/bin/tor -f ${torrc}";
		};
		Install = {
			WantedBy = [ "graphical-session.target" ];
		};
	};
}
