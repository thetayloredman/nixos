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

  flake.modules.homeManager.nix = {
    nix.extraOptions = ''
      experimental-features = nix-command flakes
    '';
  };
}
