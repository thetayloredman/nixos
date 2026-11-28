{ ... }: {
  colmena.hesdc-gatus = {
    targetHost = "10.65.6.1";
    buildOnTarget = builtins.currentSystem != "x86_64-linux";
  };
}
