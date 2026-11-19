{ ... }: {
  withAlerting =
    x:
    x
    // {
      alerts = [
        { type = "matrix"; }
        { type = "discord"; }
      ];
    };
}
