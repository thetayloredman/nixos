{ inputs, ... }:
{
  flake.modules.nixos.nix = {
    nix.settings = {
      experimental-features = [
        "nix-command"
        "flakes"
      ];
    };
  };

  flake.modules.homeManager.nix = { pkgs, ... }: {
    nix = {
      package = pkgs.nix;
      extraOptions = ''
        experimental-features = nix-command flakes
      '';
    };
  };
}
