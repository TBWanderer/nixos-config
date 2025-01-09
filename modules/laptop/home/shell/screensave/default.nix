{ pkgs }:
pkgs.writeShellScriptBin "screensave" ''
	function info {
		if [ $# = 1 ]; then
			hyprctl notify 1 3000 "rgba(af00ff88)" $1
		fi
	}
	
	if [ $# = 1 ]; then
		year="$(date +%Y)"
		month="$(date +%m)"
		day="$(date +%d)"
		id="$(date +%s%N)"
	
		screenshots_dir="$HOME/Pictures/screenshots"
	
		mkdir "$screenshots_dir" &> /dev/null
		mkdir "$screenshots_dir/$year" &> /dev/null
		mkdir "$screenshots_dir/$year/$month" &> /dev/null
		mkdir "$screenshots_dir/$year/$month/$day" &> /dev/null
	
		savepath="$screenshots_dir/$year/$month/$day/$id.png"
	
		if [ "$1" = "full-auto" ]; then
			grim -l 0 $savepath && info "Screenshot (full) saved to: $screenshots_dir"
		fi
		if [ "$1" = "full-manual" ]; then
			grim -g "$(slurp)" -l 0 $savepath && info "Screenshot (full) saved to: $screenshots_dir"
		fi
		if [ "$1" = "full-copy" ]; then
			grim -g "$(slurp)" -l 0 - | wl-copy && info "Screenshot (full) copied to clipboard"
		fi
	
		if [ "$1" = "fast-auto" ]; then
			grim $savepath && info "Screenshot (fast) saved to: $screenshots_dir"
		fi
		if [ "$1" = "fast-manual" ]; then
			grim -g "$(slurp)" $savepath && info "Screenshot (fast) saved to: $screenshots_dir"
		fi
		if [ "$1" = "fast-copy" ]; then
			grim -g "$(slurp)" - | wl-copy && info "Screenshot (fast) copied to clipboard"
		fi
	fi
''
