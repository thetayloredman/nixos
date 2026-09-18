{ inputs, ... }:
let
  stylixConfig =
    pkgs:
    let
      inherit (pkgs) lib;
    in
    {
      enable = true;
      base16Scheme = "${pkgs.base16-schemes}/share/themes/catppuccin-mocha.yaml";
      polarity = "dark";
      image = pkgs.fetchurl {
        url = "https://images.unsplash.com/photo-1485470733090-0aae1788d5af";
        hash = "sha256-rL2N/NE/Eum9lLZvkTf2SNriBg2kvPXFCiY8L2EeVMY=";
      };
      fonts.sizes.applications = 10;
    };
in
{
  flake.modules.nixos.theming = { pkgs, ... }: {
    imports = [ inputs.stylix.nixosModules.stylix ];
    stylix = stylixConfig pkgs // {
      homeManagerIntegration = {
        followSystem = false;
        autoImport = false;
      };
    };
  };

  flake.modules.homeManager.theming = { pkgs, ... }: {
    imports = [ inputs.stylix.homeModules.stylix ];
    stylix = stylixConfig pkgs;
  };
}
