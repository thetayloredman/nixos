{ inputs, ... }:
{
  flake.modules.homeManager.profile-darwin-hm-full = {
    imports = with inputs.self.modules.homeManager; [
      profile-common-hm-full
      nix
    ];
  };
}
