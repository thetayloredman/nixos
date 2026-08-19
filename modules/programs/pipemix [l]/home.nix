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
        instances = {
          bassBoosted = {
            peqs = [
              {
                channels = [
                  "L"
                  "R"
                ];
                eqtype = "Lowshelf";
                freq = 130.0;
                q = 5.0;
                gain = 13.0;
              }
            ];
          };
        };
      };

      home.packages = [
        pmtpkgs.pipemix-rust-tools
      ];
    };
}
