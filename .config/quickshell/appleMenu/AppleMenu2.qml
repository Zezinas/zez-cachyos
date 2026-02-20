import Quickshell
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import ".."

PanelWindow {
    id: window

    anchors {
        top: true
        left: true
    }

    color: "transparent"
    width: 260
    height: base.height + 20  // bind to base

    Rectangle {
        id: root
        anchors.fill: parent
        radius: 6
        color: Theme.bgFig02
    }

    ColumnLayout {
        id: base

        anchors.topMargin: 10
        anchors.bottomMargin: 10
        anchors.rightMargin: 4
        anchors.leftMargin: 4

        spacing: 0
        anchors.top: parent.top
        anchors.left: parent.left
        anchors.right: parent.right

        MenuItem2 {
            text: "About This PC"
        }

        Separator {}

        MenuItem2 {
            text: "Software Updates..."
        }

        MenuItem2 {
            text: "App Store..."
        }

        Separator {}

        MenuItem2 {
            text: "Something"
        }

        Separator {}

        MenuItem2 {
            text: "Sleep"
        }

        MenuItem2 {
            text: "Restart..."
        }

        MenuItem2 {
            text: "Shut Down..."
        }

        Separator {}

        MenuItem2 {
            text: "Lock Screen"
        }
    }
}
