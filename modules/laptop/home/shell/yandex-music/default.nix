{ pkgs, ... }:
pkgs.writeShellScriptBin "yandex_music_now_playing" ''
	while true
	do
		player_status=''$(${pkgs.playerctl}/bin/playerctl status -p chromium 2> /dev/null)
	
		if [ "$player_status" = "Playing" ]; then
			echo "''$(${pkgs.playerctl}/bin/playerctl metadata artist -p chromium) - ''$(${pkgs.playerctl}/bin/playerctl metadata title -p chromium)"
		else
			echo ""
		fi
		sleep 1
	done
''
