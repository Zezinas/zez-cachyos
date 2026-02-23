// ControlCenter.qml
import Quickshell
import Quickshell.Hyprland
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import ".."
import "../components"
import "../scripts" as Scripts

PopupWindow {
    id: window

    // 1. Define the missing properties and signals
    property var anchorWindow: null
    property rect anchorRect: Qt.rect(0, 0, 0, 0)

    implicitWidth: 298
    implicitHeight: base.implicitHeight + 20
    color: "transparent"

    HyprlandFocusGrab {
        // Since this is inside a LazyLoader, 'true' is fine,
        // or use window.visible to be safe.
        active: window.visible

        // This is the important part for Hyprland
        windows: [window]

        onCleared: {
            window.closed();
        }
    }

    // IMPORTANT: In LazyLoader, visible should stay true
    visible: true

    // 2. Map the properties to the internal anchor object
    anchor.window: anchorWindow
    anchor.rect: anchorRect

    anchor.edges: Edges.Bottom
    anchor.gravity: Edges.Bottom

    // 3. Add the 10px spacing
    anchor.margins {
        top: 30
    }

    Rectangle {
        id: root
        anchors.fill: parent
        radius: 15
        color: Theme.bgFig03
    }

    ColumnLayout {
        id: base

        anchors.margins: 10
        spacing: 10
        anchors.top: parent.top
        anchors.left: parent.left
        anchors.right: parent.right

        RowLayout {
            // 1st ROW
            spacing: 10

            Rectangle { // Network Panel
                id: networkPanel
                radius: 10
                color: Theme.bgFig02

                implicitHeight: 134
                Layout.preferredWidth: implicitHeight

                ColumnLayout {
                    spacing: 0
                    anchors.margins: 10
                    anchors.fill: parent

                    // WifiLogic {
                    //     id: wifiLogic
                    // }

                    MiniItem {
                        mainTextStr: "Wi-Fi"
                        iconBaseName: "wifi"
                        optionalTextStr: "SSID"
                        state: 4 // Directly uses 0, 1, 2, 3, or 4

                        onIconClicked: {
                            console.log("Bluetooth icon clicked | state:", state);
                        }

                        onItemClicked: {
                            console.log("Bluetooth item clicked");
                        }
                    }

                    MiniItem {
                        mainTextStr: "Bluetooth"
                        optionalTextStr: "On"

                        iconBaseName: "bt"
                        state: 1

                        onIconClicked: {
                            console.log("Bluetooth icon clicked | state:", state);
                        }

                        onItemClicked: {
                            console.log("Bluetooth item clicked");
                        }
                    }
                    MiniItem {
                        mainTextStr: "AirDrop"
                        optionalTextStr: "Off"

                        iconBaseName: "air"
                        state: 0
                    }
                }
            }

            ColumnLayout {
                spacing: 10

                Rectangle { // Do Not Disturb
                    id: rec12
                    radius: 10
                    color: Theme.bgFig02

                    Layout.fillWidth: true
                    Layout.fillHeight: true

                    ColumnLayout {
                        spacing: 0
                        anchors.margins: 10
                        anchors.fill: parent

                        MiniItem {
                            mainTextStr: "Focus"

                            iconBaseName: "focus"
                            state: 0
                        }
                    }
                }

                RowLayout {
                    // other 2 optional buttons TODO
                    spacing: 10

                    Rectangle {
                        id: rec13
                        radius: 10
                        color: Theme.bgFig02

                        Layout.fillWidth: true
                        Layout.fillHeight: true
                    }

                    Rectangle {
                        id: rec14
                        radius: 10
                        color: Theme.bgFig02

                        Layout.fillWidth: true
                        Layout.fillHeight: true
                    }
                }
            }
        }

        Scripts.DisplayLogic {
            id: displayLogic
        }

        SliderItem {
            id: brightnessSlider
            // Display
            mainTextStr: "Display"
            iconText: "􀆮" //

            value: displayLogic.brightness

            onValueUpdated: function (v) {
                console.log("Display Brightness updated to: " + v);
                displayLogic.updateBrightness(v)
            }
        }

        Scripts.SoundLogic {
            id: soundLogic
        }

        SliderItem {
            id: soundSlider
            // Sound
            mainTextStr: "Sound"
            iconText: "􀊡" // 􀑈 􀊣 􀊥􀊧􀊩 􀊡

            value: soundLogic.volume

            onValueUpdated: function (v) {
                console.log("Sound Volume updated to: " + v);
                soundLogic.updateVolume(v);
            }
        }

        Rectangle { // media
            id: rec4
            radius: 10
            color: Theme.bgFig02

            implicitHeight: 63
            Layout.fillWidth: true
        }
    }
}
