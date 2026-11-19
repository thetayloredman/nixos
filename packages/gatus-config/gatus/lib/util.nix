{ ... }: {
  withGroup =
    group: x:
    x
    // {
      inherit group;
    };
}
