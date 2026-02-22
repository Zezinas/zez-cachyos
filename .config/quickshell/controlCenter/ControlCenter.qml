// ControlCenter.qml
import Quickshell
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import ".."

PanelWindow {
    id: window

    anchors {
        top: true
        right: true
    }

    color: "transparent"
    width: 298
    height: base.height + 20  // bind to base

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

                height: 134
                Layout.preferredWidth: height

                ColumnLayout {
                    spacing: 0
                    anchors.margins: 10
                    anchors.fill: parent

                    WifiLogic {
                        id: wifiLogic
                    }

                    MiniItem {
                        mainTextStr: "Wi-Fi"
                        iconBaseName: "wifi"
                        optionalTextStr: wifiLogic.wifiSSID
                        state: wifiLogic.wifiState // Directly uses 0, 1, 2, 3, or 4

                        onIconClicked: wifiLogic.toggleWifi()
                    }

                    MiniItem {
                        mainTextStr: "Bluetooth"
                        optionalTextStr: "On"

                        iconBaseName: "bt"
                        state: 1

                        onIconClicked: {
                            console.log("Bluetooth icon clicked | state:", state);
                            toggleBt();
                        }

                        onItemClicked: {
                            console.log("Bluetooth item clicked");
                            openBtMenu();
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

        DdcLogic {
            id: ddcLogic
        }

        SliderItem {
            id: brightnessSlider
            // Display
            mainTextStr: "Display"
            iconText: "􀆮" //

            value: ddcLogic.brightness

            onValueUpdated: function (v) {
                ddcLogic.updateBrightness(v);
            }
        }

        SoundLogic {
            id: soundLogic
        }

        SliderItem {
            id: soundSlider
            // Sound
            mainTextStr: "Sound"
            iconText: "􀊡" // 􀑈 􀊣 􀊥􀊧􀊩 􀊡

            value: soundLogic.volume

            onValueUpdated: function (v) {
                console.log("Volume updated to: " + v);
                soundLogic.updateVolume(v);
            }
        }

        Rectangle { // media
            id: rec4
            radius: 10
            color: Theme.bgFig02

            height: 63
            Layout.fillWidth: true
        }
    }
}
