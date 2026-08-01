{ inputs, ... }: {
  flake-file.inputs = {
    zirco-pkgs = {
      url = "github:zirco-lang/zrc";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
}
