// ControlSection.qml
import QtQuick
import QtQuick.Layouts
import ".."

ColumnLayout {
    id: section

    property string title: ""
    property var model: []   // array of items

    spacing: 0

    // Label
    Rectangle {
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
            text: section.title

            anchors.left: parent.left
            anchors.verticalCenter: parent.verticalCenter
            anchors.leftMargin: 9

            color: Theme.textPrimary
            font.pixelSize: 13

            font.family: Theme.fontFamily
            font.weight: Theme.fontWeight
        }
    }

    // Items
    // Repeater {
    //     model: section.model

    //     delegate: ControlItem {
    //         iconSource: modelData.icon
    //         primaryTextStr: modelData.name
    //         state: modelData.state

    //         onItemClicked: {
    //             if (modelData.device) {
    //                 if (modelData.device.connected)
    //                     modelData.device.disconnect()
    //                 else if (modelData.device.paired)
    //                     modelData.device.connect()
    //                 else
    //                     modelData.device.pair()
    //             }
    //         }
    //     }
    // }

    Repeater {
        model: section.model

        delegate: ControlItem {
            iconSource: modelData.icon
            primaryTextStr: modelData.name
            state: modelData.state
        }
    }

    Separator {}
}
