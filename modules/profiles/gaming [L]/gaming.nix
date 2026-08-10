{ inputs, ... }:
{
  flake.modules.nixos.profile-gaming = {
    imports = with inputs.self.modules.nixos; [ steam ];
  };
}
