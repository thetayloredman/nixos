{
  nixpkgs,
  home-manager,
  zirco-pkgs,
  ...
}:
system:
let
  pkgs = import nixpkgs { inherit system; };
  zpkgs = zirco-pkgs.packages.${system};
in
home-manager.lib.homeManagerConfiguration {
  inherit pkgs;
  modules = [ ./home.nix ];
  extraSpecialArgs = { inherit zpkgs; };
}
