{ inputs, ... }:
let
  stylixConfig = pkgs: {
    enable = true;
    base16Scheme = "${pkgs.base16-schemes}/share/themes/catppuccin-mocha.yaml";
  };
in
{
  flake.modules.nixos.theming = { pkgs, ... }: {
    imports = [ inputs.stylix.nixosModules.stylix ];
    stylix = stylixConfig pkgs;
  };

  flake.modules.homeManager.theming = { pkgs, ... }: {
    imports = [ inputs.stylix.homeModules.stylix ];
    stylix = stylixConfig pkgs;
  };
}
