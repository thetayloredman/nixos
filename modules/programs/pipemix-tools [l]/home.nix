{ inputs, ... }: {
  flake.modules.homeManager.pipemix-tools =
    { pkgs, lib, ... }:
    let
      system = pkgs.stdenv.hostPlatform.system;
      pmtpkgs = inputs.pipemix-tools.packages.${system};
    in
    {
      home.packages = [
        pmtpkgs.pipemix-tools
      ];
    };
}
