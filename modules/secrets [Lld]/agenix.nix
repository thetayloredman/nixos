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
