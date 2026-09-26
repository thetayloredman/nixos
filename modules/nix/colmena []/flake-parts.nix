{
  inputs,
  lib,
  config,
  ...
}:
{
  options = {
    colmena = lib.mkOption {
      default = { };
      type = lib.types.attrsOf lib.types.attrs;
    };
  };

  config = {
    flake-file.inputs = {
      colmena = {
        url = "github:nix-community/colmena";
        inputs.nixpkgs.follows = "nixpkgs";
      };
    };

    flake.colmena = {
      meta = {
        nixpkgs = import inputs.nixpkgs {
          system = "x86_64-linux";
          overlays = [ ];
        };
      };
    }
    // builtins.mapAttrs (name: value: {
      imports = value._module.args.modules ++ [
        {
          deployment = config.colmena.${name};
        }
      ];
    }) (lib.filterAttrs (k: _: lib.hasAttr k config.colmena) inputs.self.nixosConfigurations);

    flake.colmenaHive = inputs.colmena.lib.makeHive inputs.self.outputs.colmena;
  };
}
