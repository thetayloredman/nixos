{ inputs, lib, ... }:
{
  flake.modules.nixos.logmuks =
    { pkgs, config, ... }:
    let
      logmuks = import ../../../packages/logmuks/package.nix {
        inherit pkgs;
        inherit (inputs) logmuks-src;
      };

      instances = {
        main = {
          port = 29320;
          domain = "main.muks.zirco.dev";
        };
        star = {
          port = 29321;
          domain = "star.muks.zirco.dev";
        };
        urd = {
          port = 29322;
          domain = "urd.muks.zirco.dev";
        };
        uwu = {
          port = 29323;
          domain = "uwu.muks.zirco.dev";
        };
        morg = {
          port = 29324;
          domain = "morg.muks.zirco.dev";
        };
        ipfy = {
          port = 29325;
          domain = "ipfy.muks.zirco.dev";
        };
        venator = {
          port = 29326;
          domain = "venator.muks.zirco.dev";
        };
      };

      frontendRules = lib.concatStringsSep "\n" (
        lib.mapAttrsToList (
          name: instance: "  use_backend gomuks_${name} if { hdr(host) -i ${instance.domain} }"
        ) instances
      );

      backends = lib.concatStringsSep "\n" (
        lib.mapAttrsToList (name: instance: ''
          backend gomuks_${name}
              server muks 127.0.0.1:${toString instance.port}
        '') instances
      );

      systemdUnit = name: instance: {
        description = "gomuks ${name}";
        after = [ "network.target" ];
        wantedBy = [ "multi-user.target" ];

        serviceConfig = {
          Type = "simple";

          User = "gomuks";
          Group = "gomuks";

          WorkingDirectory = "/var/lib/gomuks/${name}";

          ExecStart = "${logmuks}/bin/gomuks-web";
          Environment = "GOMUKS_ROOT=/var/lib/gomuks/${name}";

          Restart = "always";
          RestartSec = "5s";

          ReadWritePaths = [
            "/var/lib/gomuks/${name}"
          ];
          ProtectSystem = "strict";
          ProtectHome = true;
          PrivateTmp = true;
          PrivateDevices = true;
          NoNewPrivileges = true;
          ProtectKernelTunables = true;
          ProtectKernelModules = true;
          ProtectControlGroups = true;
          LockPersonality = true;
          RestrictRealtime = true;
          RestrictSUIDSGID = true;
          SystemCallArchitectures = "native";
        };
      };
    in
    {
      users.groups.gomuks = { };
      users.users.gomuks = {
        isSystemUser = true;
        group = "gomuks";
        description = "gomuks user";
        home = "/var/lib/gomuks";
        createHome = true;
      };

      systemd.services = lib.mapAttrs' (name: instance: {
        name = "gomuks-${name}";
        value = systemdUnit name instance;
      }) instances;

      systemd.tmpfiles.rules = [
        "d /var/lib/haproxy 0750 root haproxy -"
      ]
      ++ lib.mapAttrsToList (name: _: "d /var/lib/gomuks/${name} 0750 gomuks gomuks -") instances;

      services.haproxy = {
        enable = true;
        config = ''
          global
            log /dev/log local0
            log /dev/log local1 notice

          defaults
            mode http
            log global
            option httplog
            timeout connect 5s
            timeout client 30s
            timeout server 30s

          frontend gomuks_https
            bind :443 accept-proxy ssl crt /var/lib/haproxy/muks.pem
          ${frontendRules}

          ${backends}
        '';
      };
      networking.firewall.allowedTCPPorts = [ 443 ];

      security.acme = {
        acceptTerms = true;
        email = "infrastructure@zirco.dev";
        certs."muks.zirco.dev" = {
          extraDomainNames = [ "*.muks.zirco.dev" ];
          dnsProvider = "cloudflare";
          environmentFile = config.age.secrets.borealis-cloudflare-acme.path;
          group = "haproxy";
          reloadServices = [ "haproxy" ];
          postRun = ''
            cat fullchain.pem key.pem > /var/lib/haproxy/muks.pem
            chown root:haproxy /var/lib/haproxy/muks.pem
            chmod 0640 /var/lib/haproxy/muks.pem
          '';
        };
      };
    };
}
