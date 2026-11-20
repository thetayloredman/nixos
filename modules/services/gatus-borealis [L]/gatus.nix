{ self, ... }: {
  flake.modules.nixos.gatus-borealis =
    { pkgs, config, ... }:
    let
      gatus-config = self.packages.${pkgs.stdenv.hostPlatform.system}.gatus-config;
    in
    {
      services.gatus = {
        enable = true;
        configFile = gatus-config.borealis;
        environmentFile = config.age.secrets.borealis-gatus-env.path;
      };

      systemd.services.gatus.serviceConfig = {
        AmbientCapabilities = [ "CAP_NET_BIND_SERVICE" ];
        CapabilityBoundingSet = [ "CAP_NET_BIND_SERVICE" ];
      };

      networking.firewall.allowedTCPPorts = [ 80 ];
    };
}
