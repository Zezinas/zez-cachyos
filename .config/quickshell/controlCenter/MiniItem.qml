// MiniItem.qml
import Quickshell
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import Quickshell.Widgets
import QtQuick.Effects
import ".."

Rectangle {
    id: root

    property string iconBaseName: ""
    property string mainTextStr: ""
    property string optionalTextStr: ""
    property int state: 0

    signal iconClicked()
    signal itemClicked()

    // Background Logic
    property color iconBgColor: state <= 0 ? Theme.plusDarker : Theme.fgBlue

    // Foreground (SVG) Logic
    property color iconFgColor: state <= 0 ? Theme.textPrimary : "white"

    property string iconSource: {
        if (iconBaseName === "") return "icons/default.svg"
        return "icons/" + iconBaseName + state + ".svg"
    }


    Layout.fillWidth: true
    Layout.fillHeight: true
    Layout.alignment: Qt.AlignLeft | Qt.AlignVCenter

    color: "transparent"

    MouseArea {
        anchors.fill: parent
        onClicked: root.itemClicked()
    }

    RowLayout {
        id: base

        anchors.fill: parent

        spacing: 8
        height: 38

        Button {
            id: circleIcon

            Layout.alignment: Qt.AlignLeft | Qt.AlignVCenter
            implicitWidth: 26
            implicitHeight: 26

            contentItem: Item {
                Image {
                    id: iconAsset
                    anchors.centerIn: parent
                    width: 14
                    height: 14
                    source: root.iconSource
                    fillMode: Image.PreserveAspectFit
                    visible: false
                }

                MultiEffect {
                    source: iconAsset
                    anchors.fill: iconAsset
                    colorization: 1.0
                    colorizationColor: root.iconFgColor
                }
            }

            background: Rectangle {
                radius: circleIcon.width / 2
                color: root.iconBgColor
            }

            onClicked: root.iconClicked()
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
                color: Theme.textPrimary
                font.pixelSize: 13

                font.family: Theme.fontFamily
                font.weight: Theme.fontWeight
            }

            Text {
                id: optionalText
                text: root.optionalTextStr
                visible: text.length > 0
                elide: Text.ElideRight   // <-- this cuts off with "..."

                Layout.fillWidth: true
                color: Theme.textSecondary
                font.pixelSize: 11

                font.family: Theme.fontFamily
                font.weight: Theme.fontWeight
            }
        }
    }
}
