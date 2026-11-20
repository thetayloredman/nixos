{ self, ... }: {
  flake.modules.nixos.gatus =
    {
      pkgs,
      lib,
      config,
      ...
    }:
    let
      cfg = config.custom.services.gatus;
      gatus-config = self.packages.${pkgs.stdenv.hostPlatform.system}.gatus-config;
    in
    {
      options.custom.services.gatus.config-name = lib.mkOption {
        type = lib.types.str;
        description = "The name of the gatus config to use.";
      };

      config = {
        services.gatus = {
          enable = true;
          configFile = gatus-config.${cfg.config-name};
          environmentFile = config.age.secrets.gatus-env.path;
        };

        systemd.services.gatus.serviceConfig = {
          AmbientCapabilities = [ "CAP_NET_BIND_SERVICE" ];
          CapabilityBoundingSet = [ "CAP_NET_BIND_SERVICE" ];
        };

        networking.firewall.allowedTCPPorts = [ 80 ];
      };
    };
}
