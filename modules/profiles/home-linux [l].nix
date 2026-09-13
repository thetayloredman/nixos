{ inputs, ... }:
{
  flake.modules.homeManager.home-linux = { pkgs, ... }: {
    imports = with inputs.self.modules.homeManager; [
      profile-home-base
      secrets
    ];
  };
}
