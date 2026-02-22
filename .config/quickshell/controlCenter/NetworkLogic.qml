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
        command: ["nmcli", "-t", "-f", "WIFI", "g"]

        stdout: StdioCollector {
            onStreamFinished: {
                const result = text.trim()
                logic.wifiEnabled = (result === "enabled")
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

    onWifiEnabledChanged: {
        if (!wifiEnabled) {
            wifiState = 0
            wifiSSID = "Off"
        } else {
            wifiState = 1
            wifiSSID = "On"
        }
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
