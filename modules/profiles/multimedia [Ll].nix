{ inputs, ... }: {
  flake.modules.homeManager.profile-multimedia = { pkgs, ... }: {
    imports = with inputs.self.modules.homeManager; [
      pipemix
    ];

    home.packages = with pkgs; [
      cider-2
      vlc
      dcpomatic
    ];
  };

  flake.modules.nixos.profile-multimedia = {
    imports = with inputs.self.modules.nixos; [
      obs
    ];
  };
}
