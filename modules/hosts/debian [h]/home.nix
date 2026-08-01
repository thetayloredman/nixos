{ inputs, ... }:
{
  flake.modules.homeManager.debian = {
    imports = with inputs.self.modules.homeManager; [
      profile-linux-hm-full
    ];
    home.username = "logn";
    home.homeDirectory = "/home/logn";
  };
}
