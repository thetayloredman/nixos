{ ... }: {
  flake.modules.nixos.synapse-db-wal-archiver =
    { pkgs, config, ... }:
    {
      systemd.tmpfiles.rules = [
        "d /hdd/synapse-archive 0750 postgres postgres -"
        "d /hdd/synapse-archive/wal 0750 postgres postgres -"
        "d /hdd/synapse-archive/base 0750 postgres postgres -"
      ];

      services.postgresqlWalReceiver.receivers.synapse-db = {
        postgresqlPackage = pkgs.postgresql_16;
        directory = /hdd/synapse-archive/wal;
        slot = "archive_slot";
        compress = 4;
        connection = "postgresql://walcollector@synapse-db.dc.zirco.dev";
        environment.PGPASSFILE = config.age.secrets.synapse-db-wal-archiver-pgpass.path;
      };
      systemd.services.postgresql-wal-receiver-synapse-db = {
        after = [ "wg-quick-wg-dc.service" ];
      };

      systemd.services.synapse-db-basebackup = {
        description = "Daily Synapse PostgreSQL base backup";

        serviceConfig = {
          Type = "oneshot";
          User = "postgres";
          Group = "postgres";
          Environment = [
            "PGPASSFILE=${config.age.secrets.synapse-db-wal-archiver-pgpass.path}"
          ];
        };

        script = ''
          set -euo pipefail

          timestamp="$(date -u +%Y-%m-%dT%H-%M-%SZ)"
          target="/hdd/synapse-archive/base/$timestamp"

          mkdir -p "$target"

          ${pkgs.postgresql_16}/bin/pg_basebackup \
            --dbname='postgresql://walcollector@synapse-db.dc.zirco.dev' \
            --format=tar \
            --gzip \
            --wal-method=stream \
            --pgdata="$target"

          echo "Created base backup: $target"
        '';
      };

      systemd.timers.synapse-db-basebackup = {
        wantedBy = [ "timers.target" ];

        timerConfig = {
          OnCalendar = "*-*-* 04:00:00";
          Persistent = true;
        };
      };

      systemd.services.synapse-db-backup-retention = {
        description = "Prune old Synapse PostgreSQL backups";

        serviceConfig = {
          Type = "oneshot";
          User = "postgres";
          Group = "postgres";
        };

        script = ''
          set -euo pipefail

          # Keep the newest 7 daily base backups.
          find /hdd/synapse-archive/base \
            -mindepth 1 -maxdepth 1 -type d \
            -printf '%T@ %p\n' |
            sort -rn |
            tail -n +8 |
            cut -d' ' -f2- |
            while IFS= read -r backup; do
              echo "Removing old base backup: $backup"
              rm -rf -- "$backup"
            done

          # Keep approximately 7 days of WAL.
          find /hdd/synapse-archive/wal \
            -type f \
            -mtime +7 \
            -delete
        '';
      };

      systemd.timers.synapse-db-backup-retention = {
        wantedBy = [ "timers.target" ];

        timerConfig = {
          OnCalendar = "*-*-* 05:00:00";
          Persistent = true;
        };
      };
    };
}
