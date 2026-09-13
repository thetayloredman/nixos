{ inputs, ... }: {
  flake.modules.nixos.gatus-borealis =
    { pkgs, config, ... }:
    let
      inherit (pkgs.stdenv) mkDerivation;

      statconGeneratedConfig = mkDerivation (finalAttrs: {
        pname = "statcon-config";
        version = "1.0.0";
        src = inputs.statcon-config-src;

        nativeBuildInputs = with pkgs; [
          nodejs
          pnpm
          pnpmConfigHook
          tsx
        ];

        pnpmDeps = pkgs.fetchPnpmDeps {
          inherit (finalAttrs) pname version src;
          fetcherVersion = 4;
          hash = "sha256-55hRoQl8nOGvzxzZdaLhM3gzW2WYLV+73YTfSk36tjk=";
        };

        buildPhase = ''
          mkdir -p $out
          pnpm run build
          for hostfile in ./config/hosts/*.conf.ts; do
            host=$(basename $hostfile .conf.ts)
            tsx "$hostfile" > $out/$host.yaml
          done
        '';
      });
    in
    {
      services.gatus = {
        enable = true;
        configFile = "${statconGeneratedConfig}/borealis.yaml";
        environmentFile = config.age.secrets.borealis-gatus-env.path;
      };

      systemd.services.gatus.serviceConfig = {
        AmbientCapabilities = [ "CAP_NET_BIND_SERVICE" ];
        CapabilityBoundingSet = [ "CAP_NET_BIND_SERVICE" ];
      };

      networking.firewall.allowedTCPPorts = [ 80 ];
    };
}
