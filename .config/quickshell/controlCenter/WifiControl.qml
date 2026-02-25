// WifiControl.qml
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

    property string mainName: "Wi-Fi"
    property string mainName2: "Ethernet"
    property string mainName3: "Known Network"
    property string mainName4: "Unknown Networks"

    implicitWidth: 298
    implicitHeight: base.implicitHeight + 20
    // implicitHeight: 1000

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
        color: Theme.bgFig02
    }

    ColumnLayout {
        id: base

        anchors.margins: 10
        spacing: 0
        anchors.top: parent.top
        anchors.left: parent.left
        anchors.right: parent.right

        Rectangle {
            id: label1

            Layout.preferredHeight: 22
            Layout.fillWidth: true

            radius: 10
            color: "transparent"

            Text {
                id: mainText1
                text: window.mainName

                anchors.left: parent.left
                anchors.verticalCenter: parent.verticalCenter
                anchors.leftMargin: 9

                color: Theme.textPrimary
                font.pixelSize: 13

                font.family: Theme.fontFamily
                font.weight: Theme.fontWeight
            }
        }

        Separator {}

        Rectangle {
            id: label2

            Layout.preferredHeight: 22
            Layout.fillWidth: true

            radius: 10
            color: "transparent"

            Text {
                id: mainText2
                text: window.mainName2

                anchors.left: parent.left
                anchors.verticalCenter: parent.verticalCenter
                anchors.leftMargin: 9

                color: Theme.textPrimary
                font.pixelSize: 13

                font.family: Theme.fontFamily
                font.weight: Theme.fontWeight
            }
        }

        ControlItem {
            iconSource: "../assets/eth1.svg"
            primaryTextStr: "Ethernet"
            state: true
        }

        Separator {}

        Rectangle {
            id: label3

            Layout.preferredHeight: 22
            Layout.fillWidth: true

            radius: 10
            color: "transparent"

            Text {
                id: mainText3
                text: window.mainName3

                anchors.left: parent.left
                anchors.verticalCenter: parent.verticalCenter
                anchors.leftMargin: 9

                color: Theme.textPrimary
                font.pixelSize: 13

                font.family: Theme.fontFamily
                font.weight: Theme.fontWeight
            }
        }

        ControlItem {
            iconSource: "../assets/wifi3.svg"
            primaryTextStr: "TP-Link_81A4"
            state: true
        }

        Separator {}

        Rectangle {
            id: label4

            Layout.preferredHeight: 22
            Layout.fillWidth: true

            radius: 10
            color: mouseAreaUnknown.containsMouse ? Theme.plusDarker : "transparent"

            MouseArea {
                id: mouseAreaUnknown
                anchors.fill: parent
                hoverEnabled: true // <--- Required for hover detection
            }

            Text {
                id: mainText4
                text: window.mainName4

                anchors.left: parent.left
                anchors.verticalCenter: parent.verticalCenter
                anchors.leftMargin: 9

                color: Theme.textPrimary
                font.pixelSize: 13

                font.family: Theme.fontFamily
                font.weight: Theme.fontWeight
            }
        }

        ControlItem {
            iconSource: "../assets/wifi1.svg"
            primaryTextStr: "TP-Link_81A4"
            state: false
        }

        ControlItem {
            iconSource: "../assets/wifi3.svg"
            primaryTextStr: "TP-Link_81A4"
            state: false
        }

        ControlItem {
            iconSource: "../assets/wifi4.svg"
            primaryTextStr: "TP-Link_81A4"
            state: false
        }

        ControlItem {
            iconSource: "../assets/wifi4.svg"
            primaryTextStr: "TP-Link_81A4"
            state: false
        }

        ControlItem {
            iconSource: "../assets/wifi2.svg"
            primaryTextStr: "TP-Link_81A4"
            state: false
        }

        ControlItem {
            iconSource: "../assets/wifi4.svg"
            primaryTextStr: "TP-Link_81A4"
            state: false
        }

        Separator {}

    }
}
