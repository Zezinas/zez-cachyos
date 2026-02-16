// BarItem.qml
import QtQuick
import QtQuick.Controls
import ".."

Rectangle {
    id: root

    property alias text: label.text
    property int fontSizeOverride: 0  // 0 = use Theme default
    property int fontWeightOverride: 0  // 0 = use Theme default

    signal clicked()   // <-- new signal

    height: Theme.barHeight
    radius: Theme.radius
    color: mouseArea.pressed ? Theme.bgActive :
           mouseArea.containsMouse ? Theme.bgHover :
           "transparent"

    implicitWidth: label.implicitWidth + Theme.paddingH * 2

    Text {
        id: label
        anchors.centerIn: parent

        font.family: Theme.fontFamily
        font.pixelSize: fontSizeOverride > 0 ? fontSizeOverride : Theme.fontSize
        font.weight: fontWeightOverride > 0 ? fontWeightOverride : Theme.fontWeight
        color: Theme.text
    }

    MouseArea {
        id: mouseArea
        anchors.fill: parent
        hoverEnabled: true

        onClicked: {
            root.clicked()                    // emit the signal
            console.log(root.text + " clicked")  // debug log
        }
    }
}
