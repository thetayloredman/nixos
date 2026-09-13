{ inputs, ... }: {
  colmena-flake.deployment.borealis = {
    targetHost = "10.0.0.2";
  };
}
