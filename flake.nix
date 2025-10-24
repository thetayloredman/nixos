{
  description = "LogN's NixOS Configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    zirco-pkgs.url = "github:zirco-lang/zrc";
    flake-utils.url = "github:numtide/flake-utils";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    inputs@{
      self,
      nixpkgs,
      zirco-pkgs,
      flake-utils,
      home-manager,
    }:

    flake-utils.lib.eachDefaultSystem (
      system:
      let
        pkgs = import nixpkgs { inherit system; };
        zpkgs = zirco-pkgs.packages.${system};
      in
      {
        # devShell for developing these very configs
        devShells.default = pkgs.mkShell {
          buildInputs = with pkgs; [ nixfmt-tree ];
        };

      }
    )
    // {
      nixosConfigurations =
        let
          mkConfig = import ./mkConfig.nix inputs;
        in
        nixpkgs.lib.genAttrs flake-utils.lib.defaultSystems (system: mkConfig system);

      # home-manager for systems without full NixOS
      homeConfigurations =
        let
          mkHome = import ./mkHome.nix inputs;
        in
        nixpkgs.lib.genAttrs flake-utils.lib.defaultSystems (system: mkHome system);
    };
}
