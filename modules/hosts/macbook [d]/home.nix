{ inputs, ... }:
{
  flake.modules.homeManager.macbook = {
    imports = with inputs.self.modules.homeManager; [
      home-darwin
    ];
    home.username = "logandevine";
    home.homeDirectory = "/Users/logandevine";
  };
}
