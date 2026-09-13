{ inputs, ... }: {
  flake-file.inputs = {
    colmena = {
      url = "github:nix-community/colmena";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    colmena-flake.url = "github:juspay/colmena-flake";
  };

  imports = [
    inputs.colmena-flake.flakeModules.default
  ];
}
