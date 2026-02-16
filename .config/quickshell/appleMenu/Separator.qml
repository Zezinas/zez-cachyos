import QtQuick
import QtQuick.Layouts
import ".."

Rectangle {
    id: root

    // 🔹 Custom properties for flexibility
    property int horizontalPadding: 20
    property int verticalPadding: 10
    property color separatorColor: "yellow"
    property int separatorHeight: 2

    // 🔹 Apply to Rectangle
    color: separatorColor
    height: separatorHeight

    Layout.fillWidth: true
    Layout.leftMargin: horizontalPadding
    Layout.rightMargin: horizontalPadding
    Layout.topMargin: verticalPadding
    Layout.bottomMargin: verticalPadding
}
