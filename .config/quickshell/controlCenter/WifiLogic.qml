import Quickshell
import Quickshell.Io
import QtQuick

Item {
    id: logic

    // global optimization
    property int fastRefreshCount: 0        // integer for fast polling count
    property bool busy: false               // busy safeguard

    // Public state (UI will read this)
    property bool wifiEnabled: false
    property string wifiSSID: "Unknown"
    property int wifiState: 0

    // process to check wifi status
    Process {
        id: wifiStatusProc

        // fetch wifi status / SSID / signal strength
        command: ["sh", "-c", "nmcli -t -f WIFI g; nmcli -t -f IN-USE,SSID,SIGNAL dev wifi"]

        stdout: StdioCollector {
            onStreamFinished: {
                const lines = text.trim().split("\n")

                // --- 1. Wi-Fi enabled/disabled ---
                logic.wifiEnabled = (lines[0] === "enabled")

                if (!logic.wifiEnabled) {
                    logic.wifiState = 0
                    logic.wifiSSID = "Off"
                    logic.busy = false
                    return
                }

                // --- 2. Find active connection ---
                const activeLine = lines.find(l => l.startsWith("*"))

                if (!activeLine) {
                    logic.wifiState = 1
                    logic.wifiSSID = "On"
                    logic.busy = false
                    return
                }

                // --- 3. Parse SSID + signal ---
                const parts = activeLine.split(":")

                const ssid = parts[1] || "Connected"
                const signal = parseInt(parts[2]) || 0

                logic.wifiSSID = ssid

                // --- 4. Map signal → state ---
                if (signal > 75) logic.wifiState = 4
                else if (signal > 50) logic.wifiState = 3
                else logic.wifiState = 2

                logic.busy = false
            }
        }
    }

    // trigger function to refresh status
    function refreshStatus() {
        if (busy) return
        busy = true
        wifiStatusProc.running = true
    }

    Process {
        id: wifiToggleProc
    }

    function toggleWifi() {
        const target = wifiEnabled ? "off" : "on"

        wifiToggleProc.command = ["nmcli", "radio", "wifi", target]
        wifiToggleProc.running = true

        // immediate refresh attempt
        refreshStatus()
        // fast updates for next ~2–3 seconds after click
        fastRefreshCount = 6
    }

    Timer {
        interval: fastRefreshCount > 0 ? 500 : 5000
        running: true
        repeat: true
        triggeredOnStart: true

        onTriggered: {
            refreshStatus()

            if (fastRefreshCount > 0) {
                fastRefreshCount--
            }
        }
    }
}
