{ inputs, ... }:
{
  flake.modules.homeManager.home-darwin = {
    imports = with inputs.self.modules.homeManager; [
      profile-home-base
      profile-devel
      mfc
      nix
    ];
  };
}
