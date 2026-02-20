// MiniItem.qml
import Quickshell
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import ".."

Rectangle {
    id: root

    property string iconText: ""
    property string mainTextStr: ""
    property string optionalTextStr: ""
    property bool isOn: false

    Layout.fillWidth: true
    Layout.fillHeight: true
    Layout.alignment: Qt.AlignLeft | Qt.AlignVCenter

    color: "transparent"

    RowLayout {
        id: base

        anchors.fill: parent

        spacing: 8
        height: 38

        Rectangle {
            id: circle

            Layout.alignment: Qt.AlignLeft | Qt.AlignVCenter

            radius: 13
            Layout.preferredWidth: radius * 2
            Layout.preferredHeight: radius * 2
            color: root.isOn ? "blue" : "gray"

            Text {
                id: icon
                text: root.iconText
                color: root.isOn ? "white" : "black"
                font.pixelSize: 13
                anchors.centerIn: parent
            }
        }

        ColumnLayout {
            spacing: -2
            Layout.fillWidth: true
            Layout.fillHeight: true
            Layout.alignment: Qt.AlignLeft | Qt.AlignVCenter

            Text {
                id: mainText
                text: root.mainTextStr

                Layout.fillWidth: true
                color: "black"
                font.pixelSize: 13
            }

            Text {
                id: optionalText
                text: root.optionalTextStr
                visible: text.length > 0
                elide: Text.ElideRight   // <-- this cuts off with "..."

                Layout.fillWidth: true
                color: "black"
                font.pixelSize: 11
            }
        }
    }
}
