{ ... }: {
  colmena.borealis = {
    targetHost = "10.70.0.5";
    buildOnTarget = builtins.currentSystem != "x86_64-linux";
  };
}
