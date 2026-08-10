{ inputs, ... }: {
  flake.modules.homeManager.cider-2 = { pkgs, ... }: {
    home.packages = with pkgs; [ cider-2 ];
  };
}
