// GraphItem.qml
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


    // === API ===
    property string labelText: ""
    //
    property var coreData: [0, 0, 0, 0] // Pass your array here [12, 8, 22, 14, ...]
    property color barColor: Theme.textPrimary
    property color bgColor: "transparent"
    property real barWidth: 1

    property color borderColor: Theme.textPrimary
    property real borderWidth: 1

    radius: 6 * Theme.uiScale
    implicitHeight: 24 * Theme.uiScale

    color: (mouseArea.pressed || isActive) ? Theme.plusDarker :
               mouseArea.containsMouse ? Theme.plusDarker :
               "transparent"


    // implicitWidth: label.implicitWidth + mainLayout.spacing + graph.implicitWidth + 15 * Theme.uiScale * 2
    implicitWidth: label.implicitWidth + mainLayout.spacing + graph.implicitWidth + 10 * Theme.uiScale * 2

    RowLayout {
        id: mainLayout
        anchors.centerIn: parent
        spacing: 2 * Theme.uiScale

        Text {
            id: label
            // Take first 3 chars, split with spaces to help wrapping if needed,
            // or just rely on the narrow width.
            text: root.labelText.substring(0, 3).toUpperCase()

            font.pixelSize: 7 * Theme.uiScale
            font.family: Theme.fontFamily
            font.weight: Font.Bold
            color: Theme.textPrimary
            lineHeight: 0.7 // Tightens the vertical space between letters

            // The "Chop" and "Stack" logic:
            wrapMode: Text.WrapAnywhere
            maximumLineCount: 3
            horizontalAlignment: Text.AlignHCenter // maybe left???

            // Layout.preferredWidth: implicitWidth
            Layout.preferredWidth: font.pixelSize
            Layout.alignment: Qt.AlignVCenter
        }

        UtilGraph {
            id: graph
            // anchors.centerIn: parent
            Layout.alignment: Qt.AlignVCenter

            coreData: root.coreData
            barColor: Theme.textPrimary
            bgColor: "transparent"

            barWidth: root.barWidth
            implicitHeight: 18 * Theme.uiScale

            borderColor: Theme.textPrimary
            borderWidth: root.borderWidth
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
