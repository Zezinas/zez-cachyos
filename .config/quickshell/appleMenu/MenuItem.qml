import QtQuick
import ".."

Rectangle {
    id: root
    signal clicked()   // <-- new signal

    // 🔹 Public API
    property alias text: label.text          // set text from parent
    property int overrideWidth: 0            // optional width override

    property int horizontalPadding: Theme.appleMenuTextPaddingH       // left + right padding
    property int verticalPadding: Theme.appleMenuTextPaddingV         // top + bottom padding

    // 🔹 expose natural width of text before any override
    readonly property int implicitTextWidth: label.implicitWidth

    radius: Theme.radius
    color: mouseArea.pressed ? Theme.fgActive :
           mouseArea.containsMouse ? Theme.fgActive :
           "transparent"

    // 🔹 Text inside
    Text {
        id: label

        font.family: Theme.fontFamily
        font.pixelSize: Theme.fontSize
        font.weight: Theme.fontWeight
        color: Theme.text

        anchors.fill: parent
        anchors.leftMargin: root.horizontalPadding
        anchors.rightMargin: root.horizontalPadding
        anchors.topMargin: root.verticalPadding
        anchors.bottomMargin: root.verticalPadding

        horizontalAlignment: Text.AlignLeft
        verticalAlignment: Text.AlignVCenter
    }

    // 🔹 Size of Rectangle depends on Text
    implicitWidth: (overrideWidth > 0 ? overrideWidth : label.implicitWidth) + horizontalPadding * 2
    implicitHeight: label.implicitHeight + verticalPadding * 2

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
