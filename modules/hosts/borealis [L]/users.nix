{ inputs, ... }: {
  flake.modules.nixos.borealis = { pkgs, config, ... }: {
    users.users.root = {
      hashedPasswordFile = config.age.secrets.ops-passwd.path;
    };
    home-manager.users.root = {
      imports = [
        inputs.self.modules.homeManager.profile-server
      ];
    };

    users.users.logn = {
      isNormalUser = true;
      extraGroups = [
        "wheel"
        "networkmanager"
      ];
      hashedPasswordFile = config.age.secrets.ops-passwd.path;
      shell = pkgs.zsh;
    };
    home-manager.users.logn = {
      imports = [
        inputs.self.modules.homeManager.profile-server
      ];
    };
  };
}
