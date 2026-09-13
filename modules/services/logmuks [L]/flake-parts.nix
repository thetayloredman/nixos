{ ... }: {
  flake-file.inputs = {
    logmuks-src = {
      url = "github:thetayloredman/logmuks";
      flake = false;
    };
  };
}
