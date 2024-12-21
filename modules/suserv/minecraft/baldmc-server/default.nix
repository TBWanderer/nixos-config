{ lib, config, pkgs, ... }: {
    options = {
        server.minecraft.baldmc-server.enable = lib.mkEnableOption "baldmc server";
    };
    imports = [
        ./frp.nix
    ];
    config = let cfg = config.server.minecraft.baldmc-server; in lib.mkIf cfg.enable {
        flux = {
            servers = {
                baldmc-server = {
                    package = pkgs.mkMinecraftServer {
                        name = "baldmc-server";
                        src = ./config;
                        hash = "sha256-C5Li6PctW2lPsGhsLQn8YlGKJ+VL3kq/fr3vMR6pxpg=";
                    };
                    proxy.enable = false;
                };
            };
        };
    };
}

