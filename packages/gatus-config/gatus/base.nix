{ ... }:
hostname: {
  metrics = true;

  storage = {
    type = "sqlite";
    path = "/var/lib/gatus/gatus.db";
  };

  web.port = 80;

  ui = {
    title = "LogN Status (${hostname})";
    description = "Status page for LogN's services";
    dashboard-subheading = "Monitor the status of LogN's services";
    default-sort-by = "group";
  };

  alerting =
    let
      default-alert = {
        enabled = true;
        failure-threshold = 3;
        success-threshold = 2;
        send-on-resolved = true;
        description = "Health check from ${hostname} failed";
      };
    in
    {
      discord = {
        webhook-url = "\${DISCORD_WEBHOOK_URL}";
        message-content = "<@302878998692757514>";
        inherit default-alert;
      };
      matrix = {
        server-url = "\${MATRIX_BASEURL}";
        access-token = "\${MATRIX_ACCESS_TOKEN}";
        room-id = "\${MATRIX_ROOM_ID}";
        inherit default-alert;
      };
    };
}
