// SliderItem.qml
import Quickshell
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import ".."

Rectangle {
    id: root

    property string mainTextStr: ""
    property string iconText: ""
    property double percentage: 0.5      // 0.00

    Layout.alignment: Qt.AlignLeft | Qt.AlignVCenter
    Layout.fillWidth: true
    Layout.preferredHeight: 63

    color: "green"
    radius: 10

    ColumnLayout {
        id:base

        anchors.fill: parent
        anchors.margins: 10

        spacing: 8
        height: 38

        Text {
            text: root.mainTextStr
            font.pixelSize: 12
            color: "white"
            Layout.alignment: Qt.AlignLeft | Qt.AlignVCenter
        }


        Rectangle {
            id: bgSlider

            Layout.alignment: Qt.AlignLeft | Qt.AlignVCenter

            radius: 11
            Layout.preferredHeight: radius * 2
            Layout.fillWidth: true

            color: "grey"


            Rectangle {
                id: fgSlider

                anchors {
                    left: parent.left
                    top: parent.top
                    bottom: parent.bottom
                }

                radius: parent.radius
                width: ((parent.width - 2 * radius) * percentage + 2 * radius)

                color: "white"
            }
        }
    }
}
