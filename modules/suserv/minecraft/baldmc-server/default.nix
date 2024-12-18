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
                main = {
                    package = pkgs.mkMinecraftServer {
                        name = "baldmc-server";
                        src = ./config;
                        hash = "sha256-GiNNrOLZsPFVGLRnkeqanCOESlTQSDyfWZijZjuLVz4=";
                    };
                    proxy.enable = false;
                };
            };
        };
    };
}

