// Bar.qml
import Quickshell
import QtQuick
import "modules"
import ".."
import "../components"
import "../scripts" as Scripts

Scope {
    id: barScope

    Variants {
        model: Quickshell.screens

        PanelWindow {
            id: barWindow

            required property var modelData
            screen: modelData

            anchors {
                top: true
                left: true
                right: true
            }

            implicitHeight: 24 * Theme.uiScale
            color: "transparent"

            Rectangle {
                anchors.fill: parent
                color: Theme.bgBar

                // LEFT
                Row {
                    anchors.left: parent.left
                    anchors.verticalCenter: parent.verticalCenter
                    spacing: -10 * Theme.uiScale
                    anchors.leftMargin: 5 * Theme.uiScale

                    BarItem {
                        id: appleButton
                        text: ""
                        fontSizeOverride: 22
                    }

                    BarItem {
                        text: "Alacritty"
                        fontWeightOverride: 700
                    }
                    BarItem {
                        text: "File"
                    }
                    BarItem {
                        text: "Edit"
                    }
                    BarItem {
                        text: "View"
                    }
                    BarItem {
                        text: "History"
                    }
                }

                // CENTER

                // RIGHT
                Row {
                    anchors.right: parent.right
                    anchors.verticalCenter: parent.verticalCenter
                    spacing: -10 * Theme.uiScale
                    anchors.rightMargin: 5 * Theme.uiScale

                    StackItem {
                        itemId: "tempreture_sensors"

                        text1: Scripts.HardwareMonitorLogic.temperatureSensors[0] + "°" // CPU
                        text2: Scripts.HardwareMonitorLogic.temperatureSensors[1] + "°" // GPU
                    }

                    GraphItem {
                        itemId: "cpu_util"
                        labelText: "CPU"
                        coreData: Scripts.HardwareMonitorLogic.cpuLoadPerCore
                        barColor: Theme.textPrimary
                        bgColor: "transparent"
                        barWidth: 5
                        borderColor: Theme.textPrimary
                        borderWidth: 1
                    }

                    GraphItem {
                        itemId: "ram_util"
                        labelText: "RAM"
                        coreData: [Scripts.HardwareMonitorLogic.ramUsagePercent]
                        barColor: Theme.textPrimary
                        bgColor: "transparent"
                        barWidth: 15
                        borderColor: Theme.textPrimary
                        borderWidth: 1
                    }

                    GraphItem {
                        itemId: "gpu_util"
                        labelText: "GPU"
                        coreData: [Scripts.HardwareMonitorLogic.gpuLoadPercent]
                        barColor: Theme.textPrimary
                        bgColor: "transparent"
                        barWidth: 15
                        borderColor: Theme.textPrimary
                        borderWidth: 1
                    }

                    GraphItem {
                        itemId: "vram_util"
                        labelText: "VRAM"
                        coreData: [Scripts.HardwareMonitorLogic.vramUsagePercent]
                        barColor: Theme.textPrimary
                        bgColor: "transparent"
                        barWidth: 15
                        borderColor: Theme.textPrimary
                        borderWidth: 1
                    }

                    BarItem {
                        // text: "􀴞"
                        itemId: "network"
                        text: {
                            switch (Scripts.NetworkLogic.primaryConnection) {
                            case "ethernet":
                                return "􀴞";   // ethernet glyph
                            case "wifi":
                                return "􀙇";       // wifi connected glyph
                            case "wifi-idle":
                                return "􀙇";  // wifi on but not connected
                            case "none":
                                return "􀙈";       // wifi off / none
                            default:
                                return "􀙈";
                            }
                        }
                        // "wifi-idle" fontColorOverride: Theme.plusDarker
                        // "none" fontColorOverride: Theme.plusDarker
                        fontColorOverride: (Scripts.NetworkLogic.primaryConnection === "wifi-idle" || Scripts.NetworkLogic.primaryConnection === "none") ? Theme.textSecondary : Theme.textPrimary

                        onClicked: (buttonId, buttonRect) => {
                            Global.handleBarClick(buttonId, buttonRect, barWindow);
                        }
                    }
                    BarItem {
                        itemId: "controlCenter"
                        text: "􀜊"

                        onClicked: (buttonId, buttonRect) => {
                            Global.handleBarClick(buttonId, buttonRect, barWindow);
                        }
                    }
                    BarItem {
                        text: Time.time
                    }
                }
            }
        }
    }
}
