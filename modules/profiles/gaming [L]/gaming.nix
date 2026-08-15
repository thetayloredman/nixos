{ inputs, ... }:
{
  flake.modules.nixos.profile-gaming = {
    imports = with inputs.self.modules.nixos; [ steam ];
  };

  flake.modules.homeManager.profile-gaming = { pkgs, ... }: {
    home.packages = with pkgs; [
      prismlauncher
    ];
  };
}
