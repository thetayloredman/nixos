{ inputs, ... }:
let
  inherit (inputs) secrets;
in
{
  flake.modules.nixos.secrets = { lib, config, ... }: {
    imports = [ inputs.agenix.nixosModules.default ];

    age.secrets = lib.mkMerge [
      (lib.mkIf (config.networking.hostName == "redwood") {
        redwood-wg-ether-privkey.file = "${secrets}/redwood-wg-ether-privkey.age";
        redwood-wg-dn42-privkey.file = "${secrets}/redwood-wg-dn42-privkey.age";
      })
      (lib.mkIf (config.networking.hostName == "borealis") {
        ops-passwd.file = "${secrets}/ops-passwd.age";
        borealis-wg-dc-privkey.file = "${secrets}/borealis-wg-dc-privkey.age";
        borealis-cloudflare-acme.file = "${secrets}/borealis-cloudflare-acme.age";
        borealis-gatus-env.file = "${secrets}/borealis-gatus-env.age";
        synapse-db-wal-archiver-pgpass = {
          file = "${secrets}/synapse-db-wal-archiver-pgpass.age";
          owner = "postgres";
          group = "postgres";
          mode = "0400";
        };
      })
    ];

  };

  flake.modules.homeManager.secrets =
    { pkgs, ... }:
    let
      system = pkgs.stdenv.hostPlatform.system;
      agenix = inputs.agenix.packages.${system}.default;
    in
    {
      imports = [ inputs.agenix.homeManagerModules.default ];
      home.packages = [ agenix ];
    };
}
