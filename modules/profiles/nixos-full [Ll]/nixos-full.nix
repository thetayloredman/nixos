{ inputs, ... }:
{
  flake.modules.nixos.profile-nixos-full = {
    imports = with inputs.self.modules.nixos; [
      home-manager
      nix
      zram
      profile-gaming
      profile-devel
      secrets
    ];
  };

  flake.modules.homeManager.profile-nixos-full = {
    imports = with inputs.self.modules.homeManager; [
      profile-linux-hm-full
      cider-2
      discord
      secrets
    ];
  };
}
