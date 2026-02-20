import QtQuick
import QtQuick.Layouts
import ".."

Rectangle {
    id: root

    property alias text: label.text          // set text from parent

    property int horizontalPadding: 10       // left + right padding

    radius: 4

    Layout.preferredHeight: 22
    Layout.fillWidth: parent.width
    color: mouseArea.pressed ? Theme.fgBlue : mouseArea.containsMouse ? Theme.fgBlue : "transparent"

    // 🔹 Text inside
    Text {
        id: label

        anchors.left: parent.left
        anchors.verticalCenter: parent.verticalCenter

        anchors.leftMargin: root.horizontalPadding
        anchors.rightMargin: root.horizontalPadding

        font.family: Theme.fontFamily
        font.pixelSize: Theme.fontSize
        font.weight: Theme.fontWeight
        color: Theme.textPrimary

        horizontalAlignment: Text.AlignLeft
        verticalAlignment: Text.AlignVCenter
    }

    MouseArea {
        id: mouseArea
        anchors.fill: parent
        hoverEnabled: true
    }
}
