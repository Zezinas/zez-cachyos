import Quickshell
import Quickshell.Io
import QtQuick

QtObject {
    id: logic
    property real brightness: 0.5 // Default fallback

    // Timer for debounced updates (moved from ControlCenter)
    property Timer debounce: Timer {
        interval: 100
        repeat: false
        property real pendingValue: 0
        onTriggered: {
            Quickshell.execDetached(["ddcutil", "setvcp", "10", Math.round(pendingValue * 100)]);
        }
    }

    function updateBrightness(v) {
        debounce.pendingValue = v;
        debounce.restart();
    }

    // Process to fetch current brightness on startup
    property Process fetchProcess: Process {
        command: ["ddcutil", "getvcp", "10", "--terse"]
        running: true // Runs immediately on load

        stdout: SplitParser {
            onRead: line => {
                // Terse format: "VCP 10 C <current> <max>"
                // Example: "VCP 10 C 50 100"
                let parts = line.split(" ");
                if (parts.length >= 5 && parts[1] === "10") {
                    let current = parseInt(parts[3]);
                    let max = parseInt(parts[4]);
                    logic.brightness = current / max;
                }
            }
        }
    }
}
