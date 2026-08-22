{ inputs, ... }: {
  flake-file.inputs = {
    logn-nixpkgs-dcpomatic-init = {
      url = "github:thetayloredman/nixpkgs/dcpomatic/init";
    };
  };
}
