// Bar.qml
import Quickshell
import QtQuick
import ".."
import "modules"

Scope {
    id: barScope

    // EXPOSED PROPERTIES for shell.qml
    property var activeWindow: null
    property rect activeButtonRect: Qt.rect(0, 0, 0, 0)

    Variants {
        model: Quickshell.screens

        PanelWindow {
            id: barWindow

            required property var modelData
            screen: modelData

            anchors {
                top: true
                left: true
                right: true
            }

            implicitHeight: Theme.barHeight
            color: "transparent"

            Rectangle {
                anchors.fill: parent
                color: Theme.bgBar

                // LEFT
                Row {
                    anchors.left: parent.left
                    anchors.verticalCenter: parent.verticalCenter
                    spacing: Theme.spacing
                    anchors.leftMargin: Theme.edgeMargin

                    BarItem {
                        id: appleButton
                        text: ""
                        fontSizeOverride: 22
                    }

                    BarItem {
                        text: "Alacritty"
                        fontWeightOverride: 700
                    }
                    BarItem {
                        text: "File"
                    }
                    BarItem {
                        text: "Edit"
                    }
                    BarItem {
                        text: "View"
                    }
                    BarItem {
                        text: "History"
                    }
                }

                // CENTER

                // RIGHT
                Row {
                    anchors.right: parent.right
                    anchors.verticalCenter: parent.verticalCenter
                    spacing: Theme.spacing
                    anchors.rightMargin: Theme.edgeMargin

                    BarItem {
                        text: "􀴞"
                    }
                    BarItem {
                        id: controlCenterButton
                        text: "􀜊"

                        // Sync highlight global with the global toggle
                        isActive: Global.controlCenterVisible && barScope.activeWindow === barWindow

                        onClicked: {
                            var coords = controlCenterButton.mapToItem(null, 0, 0);

                            // 1. UPDATE DATA FIRST
                            barScope.activeButtonRect = Qt.rect(coords.x, coords.y, width, height);
                            barScope.activeWindow = barWindow;

                            // 2. TRIGGER VISIBILITY SECOND
                            Global.controlCenterVisible = !Global.controlCenterVisible;
                        }
                    }
                    BarItem {
                        text: Time.time
                    }
                }
            }
        }
    }
}
