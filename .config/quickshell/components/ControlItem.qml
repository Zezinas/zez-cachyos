// ControlItem.qml
import Quickshell
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import Quickshell.Widgets
import QtQuick.Effects
import ".."

Rectangle {
    id: root

    property string iconSource: ""
    property string primaryTextStr: ""
    property string secondaryTextStr: ""
    property bool state: false

    signal itemClicked()

    // Background Logic: Use the boolean directly
    property color iconBgColor: state ? Theme.fgBlue : Theme.plusDarker
    // Foreground Logic: "white" should usually be Theme.white or similar if defined
    property color iconFgColor: state ? "white" : Theme.textPrimary

    Layout.preferredHeight: 32
    Layout.fillWidth: true

    radius: 10
    // color: Theme.plusDarker
    color: mouseArea.containsMouse ? Theme.plusDarker : "transparent"

    MouseArea {
        id: mouseArea
        anchors.fill: parent
        hoverEnabled: true // <--- Required for hover detection
        onClicked: root.itemClicked()
    }

    RowLayout {
        id: base

        spacing: 8
        anchors.fill: parent
        anchors.leftMargin: 9
        anchors.rightMargin: 9
        anchors.topMargin: 3
        anchors.bottomMargin: 3

        Rectangle {
            id: circleIcon

            // 1. Set a base size that the layout can use as a reference
            implicitWidth: 26
            implicitHeight: 26

            // 2. Allow the layout to scale it up/down
            Layout.fillHeight: true

            // 3. FORCE it to stay square based on the actual height the layout gives it
            // This is the key to "auto adjustment"
            width: height

            // 4. Always stay circular regardless of size
            radius: height / 2
            color: root.iconBgColor

            Image {
                id: iconAsset
                anchors.fill: parent
                // Use a percentage margin so the icon scales with the circle
                anchors.margins: parent.height * 0.23
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

        ColumnLayout {
            spacing: -2
            Layout.fillWidth: true
            Layout.fillHeight: true
            Layout.alignment: Qt.AlignLeft | Qt.AlignVCenter

            Text {
                id: mainText
                text: root.primaryTextStr

                Layout.fillWidth: true
                color: Theme.textPrimary
                font.pixelSize: 13

                font.family: Theme.fontFamily
                font.weight: Theme.fontWeight
            }

            Text {
                id: optionalText
                text: root.secondaryTextStr
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
