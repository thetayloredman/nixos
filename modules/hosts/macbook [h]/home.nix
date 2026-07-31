{ inputs, ... }:
{
  flake.modules.homeManager.macbook = {
    imports = with inputs.self.modules.homeManager; [
      temphome
    ];
  };
}
