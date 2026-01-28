#!/bin/bash
# ── vpn-toggle.sh ──────────────────────────────
# Toggle NordVPN on/off via CLI
# Output: none (Waybar will refresh vpnStatus.sh)
# ───────────────────────────────────────────────

status=$(nordvpn status)

if echo "$status" | grep -q "Status: Connected"; then
  # VPN active → disconnect
  nordvpn disconnect
else
  # VPN inactive → connect
  nordvpn connect
fi
