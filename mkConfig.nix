{
  nixpkgs,
  home-manager,
  zirco-pkgs,
  ...
}:
system:
let
  zpkgs = zirco-pkgs.packages.${system};
in
nixpkgs.lib.nixosSystem {
  inherit system;
  modules = [
    ./configuration.nix
    home-manager.nixosModules.home-manager
    {
      home-manager.useGlobalPkgs = true;
      home-manager.useUserPackages = true;
      home-manager.users.logn = ./home.nix;
      home-manager.extraSpecialArgs = { inherit zpkgs; };
    }
  ];
}
