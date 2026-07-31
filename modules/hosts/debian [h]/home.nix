{ inputs, ... }:
{
  flake.modules.homeManager.debian = {
    imports = with inputs.self.modules.homeManager; [
      temphome
    ];
  };
}
