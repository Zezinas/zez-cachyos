import QtQuick

Rectangle {
    id: root

    // 🔹 Public API
    property alias text: label.text          // set text from parent
    property int overrideWidth: 0            // optional width override

    property int horizontalPadding: 20       // left + right padding
    property int verticalPadding: 10         // top + bottom padding

    // 🔹 expose natural width of text before any override
    readonly property int implicitTextWidth: label.implicitWidth

    color: "brown"                           // default background
    radius: 6                                // same as before

    // 🔹 Text inside
    Text {
        id: label

        anchors.fill: parent
        anchors.leftMargin: root.horizontalPadding
        anchors.rightMargin: root.horizontalPadding
        anchors.topMargin: root.verticalPadding
        anchors.bottomMargin: root.verticalPadding

        horizontalAlignment: Text.AlignLeft
        verticalAlignment: Text.AlignVCenter
    }

    // 🔹 Size of Rectangle depends on Text
    implicitWidth: (overrideWidth > 0 ? overrideWidth : label.implicitWidth) + horizontalPadding * 2
    implicitHeight: label.implicitHeight + verticalPadding * 2
}
