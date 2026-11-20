{ inputs, ... }: {
  flake.modules.nixos.hesdc-gatus = {
    imports = with inputs.self.modules.nixos; [
      gatus
    ];

    custom.services.gatus.config-name = "hesdc";
  };
}
