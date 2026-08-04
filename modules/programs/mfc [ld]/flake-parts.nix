{ inputs, ... }: {
  flake-file.inputs = {
    mfc-pkgs = {
      url = "github:thetayloredman/mfc";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
}
