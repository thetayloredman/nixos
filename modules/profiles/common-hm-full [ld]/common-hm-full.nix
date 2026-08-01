{ inputs, ... }:
{
  flake.modules.homeManager.profile-common-hm-full = {
    imports = with inputs.self.modules.homeManager; [
      temphome
      zirco
      neovim
      git
    ];
  };
}
