{ inputs, ... }:
{
  flake.modules.homeManager.home-linux = { pkgs, ... }: {
    imports = with inputs.self.modules.homeManager; [
      profile-home-base
      pipemix
    ];

    home.packages = with pkgs; [
      cider-2
      discord
      kdePackages.kate
    ];
  };
}
