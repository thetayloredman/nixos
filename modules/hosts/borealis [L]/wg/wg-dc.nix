{ ... }: {
  flake.modules.nixos.borealis = { config, ... }: {
    networking.wg-quick.interfaces.wg-dc = {
      autostart = true;

      address = [ "10.70.0.5/32" ];
      dns = [
        "10.65.0.2"
        "dc.zirco.dev"
      ];
      privateKeyFile = config.age.secrets.borealis-wg-dc-privkey.path;

      peers = [
        {
          publicKey = "YEwRVsDA94ukNItNZWK2L1Sd+Ht/41Y3m8q2piORbW8=";
          allowedIPs = [
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
