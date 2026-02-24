// HardwareMonitorLogic.qml
pragma Singleton

import Quickshell
import Quickshell.Io
import QtQuick

Singleton {
    id: hwMonitor

    property var cpuLoadPerCore: []
    property int ramUsagePercent: 0
    property int gpuLoadPercent: 0
    property int vramUsagePercent: 0
    property var temperatureSensors: [0, 0] // [cpu, gpu]

    Timer {
        interval: 1200
        running: true
        repeat: true
        onTriggered: hwMonitor.updateStats()
    }

    Process {
        id: cpuProcess
        command: ["sh", "-c", "~/.config/quickshell/scripts/hardwareMonitorScripts/CPU_util_per_core.sh"]

        running: false

        stdout: StdioCollector {
            id: cpuOut
        }

        onExited: {
            const output = cpuOut.text.trim()
            // console.log("output:", output);
            if (!output) return

            hwMonitor.cpuLoadPerCore =
                output.split(/\s+/).map(v => Number(v) || 0)

            // console.log("CPU:", JSON.stringify(hwMonitor.cpuLoadPerCore))
        }
    }

    Process {
        id: ramProcess
        command: ["sh", "-c", "~/.config/quickshell/scripts/hardwareMonitorScripts/RAM_util.sh"]
        running: false

        stdout: StdioCollector {
            id: ramOut
            onTextChanged: {
                const output = text.trim();
                // console.log("output:", output);
                hwMonitor.ramUsagePercent = parseInt(output) || 0;
                // console.log("RAM:", hwMonitor.ramUsagePercent);
            }
        }
    }

    Process {
        id: gpuProcess
        command: ["sh", "-c", "~/.config/quickshell/scripts/hardwareMonitorScripts/GPU_util.sh"]
        running: false

        stdout: StdioCollector {
            id: gpuOut
            onTextChanged: {
                const output = text.trim();
                // console.log("output:", output);
                hwMonitor.gpuLoadPercent = parseInt(output) || 0;
                // console.log("GPU:", hwMonitor.gpuLoadPercent);
            }
        }
    }

    Process {
        id: vramProcess
        command: ["sh", "-c", "~/.config/quickshell/scripts/hardwareMonitorScripts/VRAM_util.sh"]
        running: false

        stdout: StdioCollector {
            id: vramOut
            onTextChanged: {
                const output = text.trim();
                // console.log("output:", output);
                hwMonitor.vramUsagePercent = parseInt(output) || 0;
                // console.log("VRAM:", hwMonitor.vramUsagePercent);
            }
        }
    }

    Process {
        id: tempretureProcess
        command: ["sh", "-c", "~/.config/quickshell/scripts/hardwareMonitorScripts/Temperature_sensors.sh"]
        running: false

        stdout: StdioCollector {
            id: temperatureOut
        }

        onExited: {
            const output = temperatureOut.text.trim()
            // console.log("output:", output);
            if (!output) return

            const parts = output.split(/\s+/)

            hwMonitor.temperatureSensors = [
                Number(parts[0]) || 0,
                Number(parts[1]) || 0
            ]
            // console.log("TEMPS:", JSON.stringify(hwMonitor.temperatureSensors))
        }
    }

    function updateStats() {
        cpuProcess.running = false;
        cpuProcess.running = true;

        ramProcess.running = false;
        ramProcess.running = true;

        gpuProcess.running = false;
        gpuProcess.running = true;

        vramProcess.running = false;
        vramProcess.running = true;

        tempretureProcess.running = false;
        tempretureProcess.running = true;
    }
}
