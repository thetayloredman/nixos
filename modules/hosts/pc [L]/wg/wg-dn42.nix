{ inputs, ... }:
{
  flake.modules.nixos.pc = { config, ... }: {
    networking.wg-quick.interfaces.wg-dn42 = {
      autostart = false;

      address = [
        "172.22.154.100/32"
        "fd0e:2d66:b25a:53::ffff:20/128"
      ];
      dns = [
        "172.22.154.98"
        "ln.dn42"
      ];
      privateKeyFile = config.age.secrets.wg-dn42-privkey.path;

      peers = [
        {
          publicKey = "R1R19JOK9o2jiK2WaExtKe9iPu44LO8Gs3FNGQ2rD04=";
          allowedIPs = [
            "10.71.0.0/24"
            "172.20.0.0/14"
            "fd00::/8"
            "10.65.0.0/16"
          ];
          endpoint = "dc.zirco.dev:51821";
          persistentKeepalive = 25;
        }
      ];
    };
  };
}
