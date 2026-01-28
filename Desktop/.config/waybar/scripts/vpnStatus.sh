#!/bin/bash
# ── nordvpn-status.sh ──────────────────────────────────────
# Description: Checks if VPN interface is active via IP range
# Usage: Called by Waybar `custom/vpn` every 5s
# Dependencies: ip, curl (optional, for country lookup)
# Output: Pango markup → [ФАНТОМ]: Country or KAPUTT
# Example: <span foreground='#fab387'>[ФАНТОМ]: Japan</span>
#          <span foreground='#bf616a'>[ФАНТОМ]: KAPUTT</span>
# ───────────────────────────────────────────────────────────

status=$(nordvpn status)

if echo "$status" | grep -q "Status: Connected"; then
  country=$(echo "$status" | grep "Country:" | awk -F': ' '{print $2}' | tr '[:lower:]' '[:upper:]')
  echo "<span foreground='#a6da95'>$country</span>"
else
  echo "<span foreground='#ed8796'>DISCONNECTED</span>"
fi