{ inputs, ... }: {
  flake.modules.homeManager.pipemix =
    { pkgs, lib, ... }:
    let
      system = pkgs.stdenv.hostPlatform.system;
      pmtpkgs = inputs.pipemix-tools.packages.${system};
    in
    {
      imports = [
        inputs.pipemix-pipeette.homeManagerModules.pipeette
      ];
      services.pipeette = {
        enable = true;
        instances = {};
      };

      home.packages = [
        pmtpkgs.pipemix-rust-tools
      ];
    };
}
