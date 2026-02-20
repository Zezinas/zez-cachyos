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
    property real value: 0.3   // 0.0 - 1.0

    Layout.alignment: Qt.AlignLeft | Qt.AlignVCenter
    Layout.fillWidth: true
    Layout.preferredHeight: 63

    color: Theme.bgFig02
    radius: 10

    ColumnLayout {
        id: base

        anchors.fill: parent
        anchors.margins: 10

        spacing: 0
        height: 38

        Text {
            text: root.mainTextStr
            font.pixelSize: 12
            color: "black"
            Layout.alignment: Qt.AlignLeft | Qt.AlignVCenter
        }

        Rectangle {
            id: bgSlider

            Layout.alignment: Qt.AlignLeft | Qt.AlignVCenter

            radius: 11
            Layout.preferredHeight: radius * 2
            Layout.fillWidth: true

            color: Theme.plusDarker

            Rectangle {
                id: fgSlider

                anchors {
                    left: parent.left
                    top: parent.top
                    bottom: parent.bottom
                }

                radius: parent.radius
                width: ((parent.width - 2 * radius) * root.value + 2 * radius)

                color: "white"

                Behavior on width {
                    NumberAnimation {
                        duration: 100
                    }
                }
            }

            MouseArea {
                anchors.fill: parent
                hoverEnabled: true

                function updateValue(xPos) {
                    let v = xPos / width;
                    v = Math.max(0, Math.min(1, v));   // clamp 0–1
                    root.value = v;
                }

                onPressed: updateValue(mouse.x)
                onPositionChanged: if (pressed)
                    updateValue(mouse.x)

                onWheel: wheel => {
                    let step = 0.05;
                    if (wheel.angleDelta.y > 0)
                        root.value = Math.min(1, root.value + step);
                    else
                        root.value = Math.max(0, root.value - step);
                }
            }
        }
    }
}
