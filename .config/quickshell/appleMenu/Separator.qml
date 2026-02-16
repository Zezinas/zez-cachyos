import QtQuick
import QtQuick.Layouts
import ".."

Rectangle {
    id: root

    // 🔹 Custom properties for flexibility
    property int horizontalPadding: Theme.appleMenuTextPaddingH
    property int verticalPadding: Theme.appleMenuTextPaddingV
    property color separatorColor: Theme.bgOutline
    property int separatorHeight: Theme.appleMenuOutline

    // 🔹 Apply to Rectangle
    color: separatorColor
    height: separatorHeight

    Layout.fillWidth: true
    Layout.leftMargin: horizontalPadding
    Layout.rightMargin: horizontalPadding
    Layout.topMargin: verticalPadding
    Layout.bottomMargin: verticalPadding
}
