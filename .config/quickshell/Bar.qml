import Quickshell
import QtQuick
import "."

Scope {

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
          //anchors.leftMargin: 5

          BarItem { text: ""; fontSizeOverride: 22 }
          BarItem { text: "Alacritty"; fontWeightOverride: 700 }
          BarItem { text: "File" }
          BarItem { text: "Edit" }
          BarItem { text: "View" }
          BarItem { text: "History" }
        }

        // RIGHT
        Row {
          anchors.right: parent.right
          anchors.verticalCenter: parent.verticalCenter
          spacing: Theme.spacing
          anchors.rightMargin: Theme.edgeMargin
          //anchors.rightMargin: 5

          BarItem { text: "􀴞" }
          BarItem { text: "􀜊" }
          BarItem { text: Time.time }
        }
      }
    }
  }
}
