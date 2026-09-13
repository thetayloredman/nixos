{ inputs, ... }:
{
  flake.modules.nixos.profile-workstation = {
    imports = with inputs.self.modules.nixos; [
      profile-gaming
      profile-devel
      profile-multimedia
      home-manager
      nix
      zram
      secrets
    ];
  };

  flake.modules.homeManager.profile-workstation = {
    imports = with inputs.self.modules.homeManager; [
      home-linux
      profile-gaming
      profile-multimedia
      secrets
    ];
  };
}
