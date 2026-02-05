{
  nixpkgs,
  home-manager,
  zirco-pkgs,
  pipemix-tools,
  ...
}:
system:
let
  zpkgs = zirco-pkgs.packages.${system};
  pmtpkgs = pipemix-tools.packages.${system};
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
      home-manager.extraSpecialArgs = { inherit zpkgs pmtpkgs; };
    }
  ];
}
