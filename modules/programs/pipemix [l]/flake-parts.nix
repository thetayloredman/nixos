{ inputs, ... }: {
  flake-file.inputs = {
    pipemix-tools = {
      url = "git+https://git.char.systems/ln/PipeMix-Rust-Tools?ref=ln/nix-v2";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    pipemix-pipeette = {
      url = "git+https://git.char.systems/ln/pipeMix-rust-pipeette?ref=ln/nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
}
