{ ... }:
{
  flake.modules.nixos.nix = {
    nix.settings = {
      experimental-features = [
        "nix-command"
        "flakes"
      ];
      auto-optimise-store = true;
      trusted-users = [
        "root"
        "logn"
      ];
    };
    nixpkgs.config.allowUnfree = true;
  };

  flake.modules.homeManager.nix = { pkgs, ... }: {
    nix = {
      package = pkgs.nix;
      settings = {
        experimental-features = [
          "nix-command"
          "flakes"
        ];
        auto-optimise-store = true;
      };
    };
  };
}
