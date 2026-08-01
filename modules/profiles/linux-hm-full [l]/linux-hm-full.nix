{ inputs, ... }:
{
  flake.modules.homeManager.profile-linux-hm-full = {
    imports = with inputs.self.modules.homeManager; [
      profile-common-hm-full
    ];
  };
}
