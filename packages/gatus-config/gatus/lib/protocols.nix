{ lib }:
rec {
  dns = {
    any = rrtype: name: url: domain: {
      inherit name url;
      dns.query-name = domain;
      dns.query-type = rrtype;
      conditions = [ "[DNS_RCODE] == NOERROR" ];
    };

    a = dns.any "A";
    aaaa = dns.any "AAAA";
  };

  http = rec {
    base =
      method: name: url:
      let
        checkCert = lib.strings.hasPrefix "https://" url;
      in
      {
        inherit name url method;
        conditions = [
          "[STATUS] < 300"
          "[CONNECTED] == true"
        ]
        ++ lib.optional checkCert "[CERTIFICATE_EXPIRATION] > 168h";
      };

    withInsecure = x: x // { insecure = true; };

    get = base "GET";
    getInsecure = name: url: withInsecure (get name url);
    options = base "OPTIONS";
    optionsInsecure = name: url: withInsecure (options name url);

    probeHaproxy =
      name: url:
      withInsecure (get name url)
      // {
        conditions = [
          "[STATUS] == 503"
          "[CONNECTED] == true"
          "[CERTIFICATE_EXPIRATION] > 168h"
        ];
      };
  };

  icmp = {
    ping = name: ip: {
      inherit name;
      url = "icmp://${ip}";
      conditions = [
        "[CONNECTED] == true"
      ];
    };
  };

  tcp = {
    syn = name: ip: port: {
      inherit name;
      url = "tcp://${ip}:${toString port}";
      conditions = [
        "[CONNECTED] == true"
      ];
    };
  };

  matrix =
    serverName: checkOutgoingFederation:
    let
      old = http.get serverName "https://api.connectivity-tester.mtrnord.blog/api/federation/federation-ok?server_name=${serverName}&stats_opt_in=true&check_outgoing_federation=${toString checkOutgoingFederation}";
    in
    old
    // {
      conditions = old.conditions ++ [ "[BODY] == GOOD" ];
      interval = "5m";
      client.timeout = "60s";
    };
}
