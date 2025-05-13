#!/bin/bash

# Path to the Cisco Secure Client binary
VPN_CMD="/opt/cisco/secureclient/bin/vpn"

# Check the first argument
case "$1" in
  off)
    echo "Disconnecting VPN..."
    sudo "$VPN_CMD" disconnect
    exit $?
    ;;
  status)
    echo "Checking VPN status..."
    sudo "$VPN_CMD" status
    exit $?
    ;;
  "" | on)
    # Ensure required environment variables are set
    : "${VPN_URL:?Environment variable VPN_URL not set}"
    : "${VPN_USER:?Environment variable VPN_USER not set}"
    : "${VPN_PASS:?Environment variable VPN_PASS not set}"

    echo "Connecting to VPN at $VPN_URL..."
    sudo "$VPN_CMD" -s <<EOF
connect $VPN_URL
$VPN_USER
$VPN_PASS
y
EOF
    ;;
  *)
    echo "Usage: $0 [on|off|status]"
    exit 1
    ;;
esac
