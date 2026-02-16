// Bar.qml
import Quickshell
import QtQuick
import ".."
import "modules"


Scope {
  signal toggleAppleMenu()   // <-- apple menu toggle signal

  Variants {
    model: Quickshell.screens

    PanelWindow {
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
        color: Theme.bg

        // LEFT
        Row {
          anchors.left: parent.left
          anchors.verticalCenter: parent.verticalCenter
          spacing: Theme.spacing
          anchors.leftMargin: Theme.edgeMargin

          BarItem { text: ""; fontSizeOverride: 22; onClicked: toggleAppleMenu() }

          BarItem { text: "Alacritty"; fontWeightOverride: 700 }
          BarItem { text: "File" }
          BarItem { text: "Edit" }
          BarItem { text: "View" }
          BarItem { text: "History" }
        }

        // CENTER

        // RIGHT
        Row {
          anchors.right: parent.right
          anchors.verticalCenter: parent.verticalCenter
          spacing: Theme.spacing
          anchors.rightMargin: Theme.edgeMargin

          BarItem { text: "􀴞" }
          BarItem { text: "􀜊" }
          BarItem { text: Time.time }
        }
      }

    }
  }
}
