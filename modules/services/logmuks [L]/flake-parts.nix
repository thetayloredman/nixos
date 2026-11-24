{ ... }: {
  flake-file.inputs = {
    gomuks-src = {
      url = "github:gomuks/gomuks";
      flake = false;
    };

    twemoji-src = {
      url = "github:twitter/twemoji";
      flake = false;
    };
  };
}
