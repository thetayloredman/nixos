{ inputs, ... }: {
  flake.modules.homeManager.prismlauncher = { pkgs, ... }: {
    imports = [ inputs.prismix.homeModules.default ];

    programs.prismlauncher = {
      enable = true;

      config.java = {
        path = "${pkgs.jdk25}/bin/java";
        mem = {
          min = 4096;
          max = 8192;
        };
      };

      instances =
        let
          servers = [
            {
              name = "ZircoMC";
              ip = "mc.zirco.dev";
            }
          ];
        in
        {
          "1.21.11" = {
            minecraft.version = "1.21.11";
            mod = {
              loader.name = "fabric";
              loader.version = "0.20.1";
            };
            servers = servers;
          };
        };
    };
  };
}
