{ inputs, ... }:
{
  flake.modules.nixos.pc = { config, ... }: {
    networking.wg-quick.interfaces.wg-ether = {
      autostart = false;

      address = [ "10.70.0.2/32" ];
      dns = [
        "10.65.0.2"
        "dc.zirco.dev"
      ];
      privateKeyFile = config.age.secrets.wg-ether-privkey.path;

      peers = [
        {
          publicKey = "YEwRVsDA94ukNItNZWK2L1Sd+Ht/41Y3m8q2piORbW8=";
          allowedIPs = [
            "10.15.0.0/16"
            "10.65.0.0/16"
            "10.70.0.3/24"
          ];
          endpoint = "dc.zirco.dev:51820";
          persistentKeepalive = 25;
        }
      ];
    };
  };
}
