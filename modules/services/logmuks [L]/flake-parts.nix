{ ... }: {
  flake-file.inputs = {
    gomuks-src = {
      url = "github:gomuks/gomuks";
      flake = false;
    };

    twemoji-src = {
      url = "github:jdecked/twemoji";
      flake = false;
    };
  };
}
