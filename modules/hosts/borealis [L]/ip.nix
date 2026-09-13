{ inputs, ... }:
{
  flake.modules.nixos.borealis = {
    networking = {
      useDHCP = false;
      interfaces.enp1s0.ipv4.addresses = [
        {
          address = "10.0.0.2";
          prefixLength = 24;
        }
      ];
      defaultGateway = {
        address = "10.0.0.1";
        interface = "enp1s0";
      };
    };
    networking.nameservers = [
      "1.1.1.1"
      "1.0.0.1"
    ];
  };
}
