{
  nixpkgs,
  home-manager,
  zirco-pkgs,
  pipemix-tools,
  ...
}:
system:
let
  pkgs = import nixpkgs { inherit system; };
  zpkgs = zirco-pkgs.packages.${system};
  pmtpkgs = pipemix-tools.packages.${system};
in
home-manager.lib.homeManagerConfiguration {
  inherit pkgs;
  modules = [ ./home.nix ];
  extraSpecialArgs = { inherit zpkgs pmtpkgs; };
}
