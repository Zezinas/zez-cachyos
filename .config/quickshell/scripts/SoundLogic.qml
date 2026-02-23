// SoundLogic.qml
import Quickshell
import Quickshell.Io
import QtQuick

QtObject {
    id: logic
    property real volume: 0.5  // default fallback 0.00-1.00

    // Timer for debounced updates
    property Timer debounce: Timer {
        interval: 100
        repeat: false
        property real pendingValue: 0
        onTriggered: {
            Quickshell.execDetached(["wpctl", "set-volume", "@DEFAULT_AUDIO_SINK@", Math.round(pendingValue * 100) + "%"])
        }
    }

    function updateVolume(v) {
        debounce.pendingValue = v
        debounce.restart()
        volume = v; // Optional: keep UI instantly in sync
    }

    // Process to fetch current volume on startup
    property Process fetchProcess: Process {
        command: ["wpctl", "get-volume", "@DEFAULT_AUDIO_SINK@"]
        running: true // Runs immediately on load

        stdout: SplitParser {
            onRead: line => {
                let match = line.match(/([0-9]*\.?[0-9]+)/)
                if (match) {
                    let val = parseFloat(match[1])
                    logic.volume = Math.max(0, Math.min(1, val))
                    soundSlider.setValueExternal(logic.volume)
                    console.log("Initial volume read:", logic.volume)
                } else {
                    console.log("Failed to parse volume line:", line)
                }
            }
        }
    }
}
