#!/bin/bash

# 1. CHECK ETHERNET (Highest Priority)
if nmcli -t -f TYPE,STATE device | grep "ethernet:connected" &>/dev/null; then
    echo "{\"text\": \"􀴞\", \"tooltip\": \"Ethernet Connected\", \"class\": \"ethernet\"}"
    exit 0
fi

# 2. CHECK WIFI RADIO STATE
if [[ "$(nmcli radio wifi)" == "disabled" ]]; then
    echo "{\"text\": \"􀙈\", \"tooltip\": \"WiFi Disabled\", \"class\": \"wifi-off\"}"
    exit 0
fi

# 3. CHECK WIFI CONNECTION
if nmcli -t -f TYPE,STATE device | grep "wifi:connected" &>/dev/null; then
    SIGNAL=$(nmcli -t -f ACTIVE,SIGNAL dev wifi | awk -F: '{print $2}')
    SSID=$(nmcli -t -f active,ssid dev wifi | grep '^yes' | cut -d: -f2)
    [[ -z "$SSID" ]] && SSID="WiFi"

    # Determine Icon based on signal placeholders
    if [[ "$SIGNAL" -gt 75 ]]; then
        ICON="􀙇"
    elif [[ "$SIGNAL" -gt 50 ]]; then
        ICON="2"
    elif [[ "$SIGNAL" -gt 25 ]]; then
        ICON="1"
    else
        ICON="0"
    fi

    echo "{\"text\": \"$ICON\", \"tooltip\": \"$SSID ($SIGNAL%)\", \"class\": \"wifi\"}"
    exit 0
fi

# 4. FALLBACK (Disconnected)
echo "{\"text\": \"􀙈\", \"tooltip\": \"Disconnected\", \"class\": \"disconnected\"}"
