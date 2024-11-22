{ pkgs, lib, ... }:
let pkg = pkgs.telegram-desktop.overrideAttrs (old: rec {
	name = "forkgram";
	version = "5.2.1";
	src = pkgs.fetchFromGitHub {
		owner = "forkgram";
		fetchSubmodules = true;
		repo = "tdesktop";
		rev = "v${version}";
		hash = "sha256-DZx3HwFePDE9sVHnji8N+347yxHE8o9IlPgCtG3k6Lw=";
	};
});
in {
	home.packages = lib.mkIf true [
		pkg
	];
}
