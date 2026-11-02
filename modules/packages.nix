{ inputs, ... }: {
  perSystem = { pkgs, ... }: {
    packages.logmuks = pkgs.callPackage ../packages/logmuks/package.nix {
      logmuks-src = inputs.logmuks-src;
    };
  };
}
