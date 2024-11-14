{ lib, config, pkgs, ... }: {
    options = {
        server.minecraft.servers.main.enable = lib.mkEnableOption "main minecraft server";
    };
    imports = [
        ./frp.nix
    ];
    config = let cfg = config.server.minecraft.servers.main; in lib.mkIf cfg.enable {
        flux = {
            servers = {
                main = {
                    package = pkgs.mkMinecraftServer {
                        name = "main-minecraft-server";
                        src = ./config;
                        hash = "sha256-AE4I2FosOwphnzBltw8E3X502nHvW4Dzmm473YEd9PM=";
                    };
                    proxy.enable = false;
                };
            };
        };
    };
}
