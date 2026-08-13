{ inputs, ... }:
let
  inherit (inputs) secrets;
in
{
  flake.modules.nixos.secrets = {
    imports = [ inputs.agenix.nixosModules.default ];

    age.secrets.wg-ether-privkey.file = "${secrets}/wg-ether-privkey.age";
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
