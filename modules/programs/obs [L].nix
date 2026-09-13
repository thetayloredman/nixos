{ inputs, ... }: {
  flake.modules.nixos.obs = { pkgs, ... }: {
    programs.obs-studio = {
      enable = true;

      # NVIDIA hardware acceleration support
      package = pkgs.obs-studio.override { cudaSupport = true; };

      enableVirtualCamera = true;

      plugins = with pkgs.obs-studio-plugins; [ ];
    };
  };
}
