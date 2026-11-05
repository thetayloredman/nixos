{ ... }: {
  flake-file.inputs = {
    gomuks-src = {
      url = "github:gomuks/gomuks";
      flake = false;
    };
  };
}
