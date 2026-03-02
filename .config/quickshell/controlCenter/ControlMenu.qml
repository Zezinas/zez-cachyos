// ControlMenu.qml
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

    property string mainName: ""
    property var sectionsModel: []

    // property var sectionsModel: [
    //     {
    //         title: "Ethernet",
    //         items: [
    //             { icon: "../assets/eth1.svg", name: "Ethernet", state: true }
    //         ]
    //     },
    //     {
    //         title: "Known Networks",
    //         items: [
    //             { icon: "../assets/wifi3.svg", name: "TP-Link_81A4", state: true }
    //         ]
    //     },
    //     {
    //         title: "Unknown Networks",
    //         items: [
    //             { icon: "../assets/wifi2.svg", name: "TP-Link_81A4", state: false },
    //             { icon: "../assets/wifi1.svg", name: "Another WiFi", state: false }
    //         ]
    //     }
    // ]

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


        // MAIN HEADER
         Rectangle {
            Layout.preferredHeight: 22
            Layout.fillWidth: true
            color: "transparent"

            Text {
                text: window.mainName
                anchors.left: parent.left
                anchors.verticalCenter: parent.verticalCenter
                anchors.leftMargin: 9

                color: Theme.textPrimary
            }
        }

        Separator {}

        // SECTIONS
        Repeater {
            model: sectionsModel

            delegate: ControlSection {
                title: modelData.title
                model: modelData.items
            }
        }
    }
}
