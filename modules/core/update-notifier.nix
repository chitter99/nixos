{ pkgs, username, ... }:
let
  updateCheckScript = pkgs.writeShellScript "nixos-update-check" ''
    set -euo pipefail

    STATUS=$(${pkgs.curl}/bin/curl -sf \
      "https://api.github.com/repos/chitter99/nixos/commits/main/status" 2>/dev/null) || exit 0

    STATE=$(echo "$STATUS" | ${pkgs.jq}/bin/jq -r '.state')
    REMOTE_REV=$(echo "$STATUS" | ${pkgs.jq}/bin/jq -r '.sha')

    if [ "$STATE" != "success" ]; then
      exit 0
    fi

    LOCAL_REV=$(nixos-version --configuration-revision 2>/dev/null || echo "")
    if [ -n "$LOCAL_REV" ] && [ "$REMOTE_REV" != "$LOCAL_REV" ]; then
      ${pkgs.libnotify}/bin/notify-send \
        "NixOS Update Available" \
        "New config (CI green) on main. Run: nh os switch"
    fi
  '';
in {
  systemd.user.services.nixos-update-check = {
    description = "Check for NixOS config updates";
    serviceConfig = {
      Type = "oneshot";
      ExecStart = updateCheckScript;
    };
  };

  systemd.user.timers.nixos-update-check = {
    description = "Periodically check for NixOS config updates";
    wantedBy = [ "timers.target" ];
    timerConfig = {
      OnBootSec = "5min";
      OnUnitActiveSec = "4h";
    };
  };
}
