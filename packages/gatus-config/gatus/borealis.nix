{ lib }:
with import ./lib/default.nix { inherit lib; };
import ./base.nix { inherit lib; } "borealis"
// {
  endpoints = map withAlerting (
    lib.flatten [

      (map (withGroup "Core") [
        (icmp.ping "Borealis-DC VPN Tunnel" "10.70.0.1")
      ])

      (map (withGroup "Infra") [
        (icmp.ping "HESDC v4" "web-ingress.zirco.dev")
        (http.get "HESDC Gatus" "https://status.zirco.dev")
      ])

      (map (withGroup "Services") [
        (http.get "Pastebin" "https://paste.zirco.dev")
        (http.get "Playground" "https://play.zirco.dev")
        (http.get "zirco.dev" "https://zirco.dev")
      ])

      (map (withGroup "Matrix") [
        (matrix "zirco.dev" true)
        (http.get "Synapse" "https://matrix.zirco.dev/_matrix/client/versions")
        (http.get "Ketesa" "https://matrix.zirco.dev")
      ])

    ]
  );
}
