// BarItem.qml
import QtQuick
import QtQuick.Controls
import ".."

Rectangle {
    id: root
    signal clicked(var self)

    property alias text: label.text
    property int fontSizeOverride: 0  // 0 = use Theme default
    property int fontWeightOverride: 0  // 0 = use Theme default

    property bool isActive: false

    height: Theme.barHeight
    radius: Theme.radius
    color: (mouseArea.pressed || isActive) ? Theme.bgActive :
               mouseArea.containsMouse ? Theme.bgHover :
               "transparent"

    implicitWidth: label.implicitWidth + Theme.paddingH * 2

    Text {
        id: label
        anchors.centerIn: parent

        font.family: Theme.fontFamily
        font.pixelSize: fontSizeOverride > 0 ? fontSizeOverride : Theme.fontSize
        font.weight: fontWeightOverride > 0 ? fontWeightOverride : Theme.fontWeight
        color: Theme.text
    }

    MouseArea {
        id: mouseArea
        anchors.fill: parent
        hoverEnabled: true

        onClicked: {
            // NEW: Calculate global coordinates relative to the Window
            // mapToItem(null, ...) converts local 0,0 to window-relative coordinates
            var coords = root.mapToItem(null, 0, 0);
            var itemRect = Qt.rect(coords.x, coords.y, root.width, root.height);

            // Send the item itself AND its calculated global rect
            root.clicked(itemRect);

            console.log("BarItem.qml | Position:", itemRect.x, itemRect.y);
        }
    }
}
