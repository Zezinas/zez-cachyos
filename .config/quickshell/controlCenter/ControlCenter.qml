import Quickshell
import QtQuick
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

      RowLayout {
          spacing: 10

          Rectangle {
              id: rec11
              color: "white"

              height: 134
              Layout.preferredWidth: height
              // Layout.fillWidth: true
          }

          ColumnLayout {
              spacing: 10

              Rectangle {
                  id: rec12
                  color: "dark red"

                  Layout.fillWidth: true
                  Layout.fillHeight: true
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

      Rectangle {
          id: rec2
          color: "green"

          height: 134
          Layout.fillWidth: true
      }
      Rectangle {
          id: rec3
          color: "blue"

          height: 134
          Layout.fillWidth: true
      }
  }
}
