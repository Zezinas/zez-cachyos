// CircleGraph.qml
import QtQuick
import QtQuick.Shapes
import ".."

Item {
    id: root

    implicitHeight: 48
    implicitWidth: implicitHeight

    // === API ===
    property real value: 0.0            // 0.0 → 1.0
    property real thickness: 6
    property color fgColor: "#00ffcc"
    property color bgColor: "#2a2a2a"
    property bool rounded: true

    // clamp safety
    property real clampedValue: Math.max(0, Math.min(1, value))

    Shape {
        anchors.fill: parent

        // 🔲 Background ring
        ShapePath {
            strokeColor: bgColor
            strokeWidth: thickness
            fillColor: "transparent"
            capStyle: rounded ? ShapePath.RoundCap : ShapePath.FlatCap

            PathAngleArc {
                centerX: root.width / 2
                centerY: root.height / 2
                radiusX: root.width / 2 - thickness
                radiusY: root.height / 2 - thickness
                startAngle: 0
                sweepAngle: 360
            }
        }

        // 🔵 Foreground progress
        ShapePath {
            strokeColor: fgColor
            strokeWidth: thickness
            fillColor: "transparent"
            capStyle: rounded ? ShapePath.RoundCap : ShapePath.FlatCap

            PathAngleArc {
                centerX: root.width / 2
                centerY: root.height / 2
                radiusX: root.width / 2 - thickness
                radiusY: root.height / 2 - thickness
                startAngle: -90
                sweepAngle: 360 * root.clampedValue
            }
        }
    }

    // ✨ Smooth animation
    Behavior on value {
        NumberAnimation {
            duration: 250
            easing.type: Easing.InOutQuad
        }
    }
}
