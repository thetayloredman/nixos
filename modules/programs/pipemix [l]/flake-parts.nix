{ inputs, ... }: {
  flake-file.inputs = {
    pipemix-tools = {
      url = "git+https://git.char.systems/PipeMix/PipeMix-Rust-Tools";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    pipemix-pipeette = {
      url = "git+https://git.char.systems/PipeMix/pipemix-rust-pipeette";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
}
