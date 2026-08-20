{ inputs, ... }:
{
  flake.modules.homeManager.profile-linux-hm-full = { pkgs, ... }: {
    imports = with inputs.self.modules.homeManager; [
      profile-common-hm-full
      pipemix
    ];

    home.packages = with pkgs; [
      cider-2
      discord
    ];
  };
}
