{ pkgs }:
pkgs.writeShellScriptBin "lockscreen" ''
	swaylock \
	--screenshots \
	--indicator \
	--clock \
	--indicator-radius 160 \
	--effect-blur 10x10 \
	-K \
	-e \
	--fade-in 0.2 \
	-f \
	--datestr '%a, %d.%m.%Y' \
	--inside-color 00fcff4a \
	--inside-clear-color ffba004a \
	--inside-ver-color 20ff003f \
	--inside-wrong-color ff00003f \
	--layout-border-color ffffff00 \
	--line-color ffffff00 \
	--line-clear-color ffffff00 \
	--line-ver-color ffffff00 \
	--line-wrong-color ffffff00 \
	--ring-color 00fcff00 \
	--ring-clear-color ffba004a \
	--ring-ver-color 20ff003f \
	--ring-wrong-color ff00003f \
	--separator-color 00bfffb3 \
	--text-color ffffff \
	--text-clear 'Cleared' \
	--text-clear-color ffffffff \
	--key-hl-color ffffffb3 \
	-n
''
