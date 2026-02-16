import Quickshell
import Quickshell.Io
import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import ".."
import "."

Scope {
    PanelWindow {
        anchors {
            top: true
            left: true
        }

        color: "cyan"

        implicitWidth: base.implicitWidth
        implicitHeight: base.implicitHeight

        Rectangle {
            id: base
            color: Qt.rgba(0, 0, 0, 0.5)

            implicitWidth: column.implicitWidth + 50 * 2
            implicitHeight: column.implicitHeight + 50 * 2

            ColumnLayout {
                id: column
                anchors.margins: 50
                anchors.fill: parent

                spacing: 10

                property int maxTextWidth: 0

                MenuItem { id: label1; text: "TESTING menuItem"; color: "white" }

                MenuItem { id: label2; text: "TESTING menuItem 1234567890 1234567890" }

                MenuItem { id: label3; text: "TESTING menuItem2"; color: "blue" }

                Component.onCompleted: {
                    Qt.callLater(() => {
                        maxTextWidth = Math.max(label1.implicitWidth,
                                                label2.implicitTextWidth,
                                                label3.implicitTextWidth)
                        console.log("Calculated maxTextWidth:", maxTextWidth)

                        // Apply override to match all widths
                        label1.overrideWidth = maxTextWidth
                        label2.overrideWidth = maxTextWidth
                        label3.overrideWidth = maxTextWidth
                    })
                }
            }
        }
    }

}
