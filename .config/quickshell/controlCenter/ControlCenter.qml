import Quickshell
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import ".."

PanelWindow {
  id: window

  anchors {
    top: true
    right: true
  }

  color: "cyan"
  width: 298
  height: base.height + 20  // bind to base

  ColumnLayout {
      id: base

      anchors.margins: 10
      spacing: 10
      anchors.top: parent.top
      anchors.left: parent.left
      anchors.right: parent.right

      RowLayout { // 1st ROW
          spacing: 10

          Rectangle { // Network Panel
              id: networkPanel
              color: "white"

              height: 134
              Layout.preferredWidth: height

              ColumnLayout {
                  spacing: 0
                  anchors.margins: 10
                  anchors.fill: parent

                  MiniItem { iconText: "W"; mainTextStr: "Wi-Fi"; optionalTextStr: "TP-Link_81A4"; isOn: true }
                  MiniItem { iconText: "B"; mainTextStr: "Bluetooth"; optionalTextStr: "On"; isOn: true }
                  MiniItem { iconText: "A"; mainTextStr: "AirDrop"; optionalTextStr: "Off"; isOn: false }

              }
          }

          ColumnLayout {
              spacing: 10

              Rectangle { // Do Not Disturb
                  id: rec12
                  color: "light yellow"

                  Layout.fillWidth: true
                  Layout.fillHeight: true

                  ColumnLayout {
                      spacing: 0
                      anchors.margins: 10
                      anchors.fill: parent

                      MiniItem { iconText: "F"; mainTextStr: "Focus"; isOn: false }

                  }
              }

              RowLayout {
                  spacing: 10

                  Rectangle {
                      id: rec13
                      color: "red"

                      Layout.fillWidth: true
                      Layout.fillHeight: true
                  }

                  Rectangle {
                      id: rec14
                      color: "pink"

                      Layout.fillWidth: true
                      Layout.fillHeight: true
                  }
              }
          }

      }

      SliderItem { mainTextStr: "Display"; iconText: "D" }

      Rectangle {
          id: rec3
          color: "blue"

          height: 63
          Layout.fillWidth: true
      }

      Rectangle {
          id: rec4
          color: "orange"

          height: 63
          Layout.fillWidth: true
      }
  }
}
