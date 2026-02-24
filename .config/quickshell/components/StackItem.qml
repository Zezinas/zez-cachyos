// StackItem.qml
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import ".."
import "."

Rectangle {
    id: root
    signal clicked(string id, rect geometry)
    property string itemId: ""
    property bool isActive: false

    property alias text1: label1.text
    property alias text2: label2.text

    radius: 6 * Theme.uiScale
    implicitHeight: 24 * Theme.uiScale

    color: (mouseArea.pressed || isActive) ? Theme.plusDarker :
               mouseArea.containsMouse ? Theme.plusDarker :
               "transparent"


    implicitWidth: label1.implicitWidth + 15 * Theme.uiScale * 2

    ColumnLayout {
        id: mainLayout
        anchors.centerIn: parent
        spacing: 0

        Text {
            id: label1
            Layout.fillHeight: true
            Layout.alignment: Qt.AlignRight

            font.family: Theme.fontFamily
            font.pixelSize: Theme.fontSize / 2 + 1
            font.weight: Font.Bold
            color: Theme.textPrimary
            lineHeight: 0.5
        }

        Text {
            id: label2
            Layout.fillHeight: true
            Layout.alignment: Qt.AlignRight

            font.family: Theme.fontFamily
            font.pixelSize: Theme.fontSize / 2 + 1
            font.weight: Font.Bold
            color: Theme.textPrimary
            lineHeight: 0.5
        }
    }


    MouseArea {
        id: mouseArea
        anchors.fill: parent
        hoverEnabled: true

        onClicked: {
            var coords = root.mapToItem(null, 0, 0);
            var itemRect = Qt.rect(coords.x, coords.y, root.width, root.height);

            root.clicked(root.itemId, itemRect);

            // console.log("BarItem.qml | Position:", itemRect.x, itemRect.y);
        }
    }
}
