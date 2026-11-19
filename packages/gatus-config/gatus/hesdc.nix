{ lib }:
with import ./lib/default.nix { inherit lib; };
import ./base.nix { inherit lib; } "hesdc"
// {
  endpoints = map withAlerting (
    lib.flatten [

      (map (withGroup "Core") [
        (icmp.ping "DC-Borealis VPN Tunnel" "10.70.0.5")
        (icmp.ping "Router 1" "10.65.0.31")
        (icmp.ping "Router 2" "10.65.0.32")
        (icmp.ping "DHCP 1" "10.65.0.10")
        (icmp.ping "DHCP 2" "10.65.0.11")
        (icmp.ping "IPv6 Outbound" "2001:4860:4860::8888")
        (dns.a "DNS 1" "10.65.0.2" "google.com")
        (dns.a "DNS 2" "10.65.0.3" "google.com")
      ])

      (map (withGroup "Infra") [
        (icmp.ping "Prometheus" "prometheus.dc.zirco.dev")
        (http.getInsecure "Borealis PBS" "https://10.70.0.5:8007")
        (http.get "Zabbix" "http://zabbix.dc.zirco.dev:8080")
        (http.get "Grafana" "http://grafana.dc.zirco.dev:3000")
        (http.get "ACNG" "http://apt-cacher.dc.zirco.dev:3142/acng-report.html")
        (http.get "DHCP Control Plane" "http://isc-stork.dc.zirco.dev:8080")
        (http.probeHaproxy "HAProxy 1" "https://haproxy1.dc.zirco.dev")
        (http.probeHaproxy "HAProxy 2" "https://haproxy2.dc.zirco.dev")
      ])

      (map (withGroup "Services") [
        (icmp.ping "DN42 us-ky1" "dn42-us-ky1.dc.zirco.dev")
        (http.get "Pastebin" "https://paste.zirco.dev")
        (http.get "Playground" "https://play.zirco.dev")
        (http.get "zirco.dev" "https://zirco.dev")
        (http.get "Zirco Book" "https://book.zirco.dev")
        (http.get "ShareX" "https://x.zirco.dev/")
        (http.get "Hedgedoc" "https://hedgedoc.zirco.dev/")
        (http.options "Noyo API" "https://api.noyotheater.com/api/v1")
      ])

      (map (withGroup "Matrix") [
        (matrix "zirco.dev" true)
        (matrix "uwu.zirco.dev" true)
        (matrix "ispresencefixedyet.com" true)

        (http.options "Synapse Master" "https://matrix.zirco.dev/_matrix/client/v3/keys/query")
        (http.options "Synapse Media" "https://matrix.zirco.dev/_matrix/media/")
        (http.options "Synapse Synchrotrons" "https://matrix.zirco.dev/_matrix/client/v3/sync")
        (http.options "Synapse Client API" "https://matrix.zirco.dev/_matrix/client/versions")
        (http.options "Synapse Federation API" "https://matrix.zirco.dev/_matrix/federation/v1/version")

        (http.get "Ketesa" "http://synapse-admin.dc.zirco.dev")
        (http.get "Maubot" "https://matrix.zirco.dev/_matrix/maubot")
        (http.get "Element Call SPA" "https://call.zirco.dev/")

        (http.options "MatrixRTC SFU" "https://rtc.zirco.dev/livekit/sfu")
        (http.options "MatrixRTC Auth" "https://rtc.zirco.dev/sfu/get")

        (tcp.syn "Synapse DB Master" "synapse-db.dc.zirco.dev" 5432)
      ])

    ]
  );
}
