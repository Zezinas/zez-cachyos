import Quickshell
import Quickshell.Io
import QtQuick

Scope {
  id: root

  PanelWindow {

    anchors {
      top: true
      left: true
    }

    // implicitHeight: 30

    Rectangle {
      anchors.fill: parent
      color: Theme.bg

      // LEFT
      Column {
        anchors.verticalCenter: parent

        BarItem { text: "Option_1" }
        BarItem { text: "Option_2" }
        BarItem { text: "Option_333333333" }
        BarItem { text: "Option_4" }
      }
    }
  }
}
