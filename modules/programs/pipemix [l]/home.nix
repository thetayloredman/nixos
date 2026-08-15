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
                freq = 200.0;
                q = 5.0;
                gain = 20.0;
              }
            ];
          };
          trebleBoosted = {
            peqs = [
              {
                channels = [
                  "L"
                  "R"
                ];
                eqtype = "Highshelf";
                freq = 2000.0;
                q = 5.0;
                gain = 20.0;
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
