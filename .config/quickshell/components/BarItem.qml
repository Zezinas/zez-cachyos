// BarItem.qml
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import ".."

Rectangle {
    id: root
    signal clicked(string id, rect geometry)
    property string itemId: ""

    property alias text: label.text
    property int fontSizeOverride: 0  // 0 = use Theme default
    property int fontWeightOverride: 0  // 0 = use Theme default
    property color fontColorOverride: Theme.textPrimary
    property bool isActive: false

    radius: 6 * Theme.uiScale
    implicitHeight: 24 * Theme.uiScale

    color: (mouseArea.pressed || isActive) ? Theme.plusDarker :
               mouseArea.containsMouse ? Theme.plusDarker :
               "transparent"

    implicitWidth: label.implicitWidth + 15 * Theme.uiScale * 2

    Text {
        id: label
        anchors.centerIn: parent

        font.family: Theme.fontFamily
        font.pixelSize: fontSizeOverride > 0 ? fontSizeOverride : Theme.fontSize
        font.weight: fontWeightOverride > 0 ? fontWeightOverride : Theme.fontWeight
        color: fontColorOverride
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
