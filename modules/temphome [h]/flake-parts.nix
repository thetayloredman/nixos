{ inputs, ... }: {
  flake-file.inputs = {

    pipemix-tools = {
      url = "git+https://git.char.systems/PipeMix/PipeMix-Rust-Tools";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    zirco-pkgs.url = "github:zirco-lang/zrc";
  };
}
