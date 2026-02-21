// SoundLogic.qml
import Quickshell
import Quickshell.Io
import QtQuick

QtObject {
    id: soundLogic
    property real volume: 0.5  // default fallback 0-1

    // Timer for debounced updates
    property Timer debounce: Timer {
        interval: 100
        repeat: false
        property real pendingValue: 0
        onTriggered: {
            console.log("Applying volume:", pendingValue)
            Quickshell.execDetached([
                "wpctl",
                "set-volume",
                "@DEFAULT_AUDIO_SINK@",
                Math.round(pendingValue * 100) + "%"
            ])
        }

    }

    function updateVolume(v) {
        debounce.pendingValue = v
        debounce.restart()
    }

    property Process fetchProcess: Process {
        command: ["wpctl", "get-volume", "@DEFAULT_AUDIO_SINK@"]
        running: true
        stdout: SplitParser {
            onRead: line => {
                let match = line.match(/([0-9]*\.?[0-9]+)/)
                if (match) {
                    let val = parseFloat(match[1])
                    soundLogic.volume = Math.max(0, Math.min(1, val))
                    soundSlider.setValueExternal(soundLogic.volume)
                    console.log("Initial volume read:", soundLogic.volume)
                } else {
                    console.log("Failed to parse volume line:", line)
                }
            }
        }
    }
}
