{ inputs, ... }:
{
  flake.modules.nixos.profile-nixos-full = {
    imports = with inputs.self.modules.nixos; [
      profile-gaming
      profile-devel
      home-manager
      nix
      zram
      secrets
    ];
  };

  flake.modules.homeManager.profile-nixos-full = {
    imports = with inputs.self.modules.homeManager; [
      profile-linux-hm-full
      profile-gaming
      discord
      secrets
    ];
  };
}
