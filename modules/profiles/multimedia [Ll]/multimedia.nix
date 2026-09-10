{ inputs, ... }: {
  flake.modules.homeManager.profile-multimedia = { pkgs, ... }: {
    home.packages = with pkgs; [
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
