{ inputs, ... }:
{
  flake.modules.homeManager.home-linux = {
    imports = with inputs.self.modules.homeManager; [
      profile-home-base
      secrets
    ];
  };
}
