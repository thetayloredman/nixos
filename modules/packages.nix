{ inputs, ... }: {
  perSystem = { pkgs, ... }: {
    packages.logmuks = pkgs.callPackage ../packages/logmuks/package.nix {
      gomuks-src = inputs.gomuks-src;
    };
  };
}
