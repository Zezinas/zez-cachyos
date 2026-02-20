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

                    MiniItem {
                        iconText: "W"
                        mainTextStr: "Wi-Fi"
                        optionalTextStr: "TP-Link_81A4"
                        isOn: true
                    }
                    MiniItem {
                        iconText: "B"
                        mainTextStr: "Bluetooth"
                        optionalTextStr: "On"
                        isOn: true
                    }
                    MiniItem {
                        iconText: "A"
                        mainTextStr: "AirDrop"
                        optionalTextStr: "Off"
                        isOn: false
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
                            iconText: "F"
                            mainTextStr: "Focus"
                            isOn: false
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

        SliderItem {
            // Display
            mainTextStr: "Display"
            iconText: "D"
        }

        SliderItem {
            // Sound
            mainTextStr: "Sound"
            iconText: "S"
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
