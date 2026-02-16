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

                MenuItem { id: label1; text: "TESTING"; color: "white" }

                MenuItem { id: label2; text: "TESTING menu" }

                MenuItem { id: label3; text: "TESTING menuItem2"; color: "blue" }

                Component.onCompleted: {
                    Qt.callLater(() => {
                        // var items = column.children.filter(function(c) { return c instanceof QtObject ? false : c.metaObject.className === "QQuickRectangle"; })
                        // Alternatively, just select MenuItems
                        var menuItems = column.children.filter(function(c) { return c.hasOwnProperty("implicitTextWidth") })

                        // compute max text width
                        maxTextWidth = Math.max.apply(null, menuItems.map(function(item) { return item.implicitTextWidth }))

                        console.log("Calculated maxTextWidth:", maxTextWidth)

                        // Apply overrideWidth to all menuItems
                        menuItems.forEach(function(item) { item.overrideWidth = maxTextWidth })
                    })
                }
            }
        }
    }

}
