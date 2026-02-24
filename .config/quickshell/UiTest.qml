// UiTest.qml
import Quickshell
import QtQuick
import QtQuick.Layouts
import QtQuick.Shapes
import "."
import "./components"

PanelWindow {
    id: root

    anchors {
        bottom: true
        right: true
    }

    implicitWidth: 500
    implicitHeight: 500
    color: "transparent"

    Rectangle {
        id: base
        anchors.centerIn: parent
        color: Theme.bgBar

        implicitWidth: 200
        implicitHeight: 24

        // UtilGraph {
        //     coreData: [45, 22, 89, 12, 12, 20, 60, 50, 30, 100, 10, 100]
        //     // coreData: [40]
        //     barColor: Theme.textPrimary
        //     bgColor: "transparent"

        //     barWidth: 5
        //     implicitHeight: 18

        //     borderColor: Theme.textPrimary
        //     borderWidth: 1

        //     anchors.centerIn: parent
        // }

        StackItem {
            itemId: "tempreture"
            text1: "100"
            text2: "57"
        }
    }

}
