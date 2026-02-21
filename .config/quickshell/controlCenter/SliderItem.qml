// SliderItem.qml
import Quickshell
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import ".."

Rectangle {
    id: root
    signal valueUpdated(real v)

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

            color: Theme.textPrimary
            font.pixelSize: 12

            font.family: Theme.fontFamily
            font.weight: Theme.fontWeight

            Layout.alignment: Qt.AlignLeft | Qt.AlignTop
        }

        Rectangle {
            id: bgSlider

            Layout.alignment: Qt.AlignLeft | Qt.AlignBottom

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

                color: Theme.bgFig01

                Text {
                    id: sliderIcon
                    text: root.iconText

                    anchors {
                        left: parent.left
                        top: parent.top
                        bottom: parent.bottom
                    }

                    width: height

                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter

                    color: Theme.textPrimary
                    font {
                        pixelSize: 8
                        family: Theme.fontFamily
                        weight: 700
                    }
                }

                Rectangle {
                    id: handle

                    visible: fgSlider.width > (bgSlider.radius * 4)

                    anchors {
                        right: parent.right
                        top: parent.top
                        bottom: parent.bottom
                    }

                    radius: bgSlider.radius
                    width: height

                    color: Theme.bgFig01
                }

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
                    root.valueUpdated(root.value)
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

                    root.valueUpdated(root.value)
                }
            }
        }
    }
}
