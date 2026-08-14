{ inputs, ... }: {
  flake.modules.homeManager.comma = {
    imports = with inputs.self.modules.homeManager; [
      inputs.nix-index-database.homeModules.default
    ];

    programs.nix-index-database.comma.enable = true;
  };
}
