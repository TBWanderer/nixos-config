{ lib, config, ... }: let cfg = config.server.minecraft.baldmc-server; in lib.mkIf cfg.enable {
    services.frp.settings.proxies = [
        {
            name = "baldmc-java";
            type = "tcp";
            localIP = "127.0.0.1";
            localPort = 25565;
            remotePort = 25565;
        }
        {
            name = "baldmc-bluemap";
            type = "tcp";
            localIP = "127.0.0.1";
            localPort = 8100;
            remotePort = 8100;
        }
    ];
}
