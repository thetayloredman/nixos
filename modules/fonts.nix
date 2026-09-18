{ ... }: {
  flake.modules.nixos.fonts = { pkgs, lib, ... }: {

    fonts.packages =
      with pkgs;
      [ powerline-fonts ]
      ++ builtins.filter lib.attrsets.isDerivation (builtins.attrValues pkgs.nerd-fonts);
  };
}
