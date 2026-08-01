{ inputs, ... }:
{
  flake.modules.homeManager.macbook = {
    imports = with inputs.self.modules.homeManager; [
      profile-darwin-hm-full
    ];
    home.username = "logandevine";
    home.homeDirectory = "/Users/logandevine";
  };
}
