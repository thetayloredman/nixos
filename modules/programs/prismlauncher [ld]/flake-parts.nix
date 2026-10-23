{ ... }: {
  flake-file.inputs = {
    prismix = {
      url = "git+https://codeberg.org/OliMoli/prismix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
}
