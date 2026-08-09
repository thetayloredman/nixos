{ inputs, ... }:
{
  flake.modules.nixos.profile-nixos-full = {
    imports = with inputs.self.modules.nixos; [
      home-manager
      nix
    ];
  };

  flake.modules.homeManager.profile-nixos-full = {
    imports = with inputs.self.modules.homeManager; [
      profile-linux-hm-full
    ];
  };
}
