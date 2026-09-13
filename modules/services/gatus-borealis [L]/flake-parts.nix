{ ... }: {
  flake-file.inputs = {
    statcon-config-src = {
      url = "git+file:./statcon-config";
      flake = false;
    };
  };
}
