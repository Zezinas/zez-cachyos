// UtilGraph.qml
import QtQuick
import QtQuick.Shapes
import ".."

Item {
    id: root

    // === API ===
    property var coreData: [0, 0, 0, 0] // Pass your array here [12, 8, 22, 14, ...]
    property color barColor: "#3498db"
    property color bgColor: "#1a1a1a"
    property real spacing: 0
    property real barWidth: 8
    property real padding: 0

    property color borderColor: "transparent"
    property real borderWidth: 0

    // Calculate total width: (count * barWidth) + (spacings) + (left/right padding)
    implicitWidth: (coreData.length * barWidth) + ((coreData.length - 1) * spacing) + (padding * 2)
    implicitHeight: 60

    Rectangle {
        anchors.fill: parent
        color: root.bgColor
        radius: 2

        border.color: root.borderColor
        border.width: root.borderWidth

        Row {
            anchors.fill: parent
            // anchors.margins: 2
            spacing: root.spacing

            Repeater {
                model: root.coreData

                Rectangle {
                    width: root.barWidth
                    height: parent.height
                    color: "transparent"

                    // The actual "filling" bar
                    Rectangle {
                        anchors.bottom: parent.bottom
                        width: parent.width
                        // Map 0-100 to 0-parent.height
                        height: (modelData / 100) * parent.height
                        color: root.barColor

                        // Optional: subtle rounded tops
                        // radius: 1

                        // Smoothly transition height changes
                        Behavior on height {
                            NumberAnimation { duration: 200; easing.type: Easing.OutCubic }
                        }
                    }
                }
            }
        }
    }
}
