// Theme.qml
pragma Singleton
import QtQuick

QtObject {
    // GENERAL BAR THEMING

    // Colors
    // property color bg: Qt.rgba(28/255, 28/255, 28/255, 0.75)
    property color bg: Qt.rgba(255/255, 0/255, 0/255, 0.3)
    property color bgHover: Qt.rgba(255/255, 255/255, 255/255, 0.10)
    property color bgActive: Qt.rgba(255/255, 255/255, 255/255, 0.15)

    property color text: Qt.rgba(1, 1, 1, 0.9)

    // Typography
    property string fontFamily: "SF Pro Text"
    property int fontSize: 14
    property int fontWeight: 500

    // Layout
    property int radius: 6
    property int paddingH: 15
    property int barHeight: 24
    property int spacing: -10

    // horizontal margin for edge spacing
    property int edgeMargin: 5

    // APPLE MENU STYLING
    property color appleMenuBg: bg
    property color appleMenuBgActive: bgActive

    property color appleMenuTextColor: text
    property string appleMenuFontFamily: fontFamily
    property int appleMenuFontSize: fontSize
    property int appleMenuFontWeight: fontWeight
    property int appleMenuTextAlign: Qt.AlignLeft

    property color appleMenuOutlineColor: Qt.rgba(88/255, 88/255, 88/255, 0.75) // outline color
    property int appleMenuTextPaddingH: 18        // text horizontal padding
    property int appleMenuTextPaddingV: 4         // text vertical padding
    property int appleMenuRadius: 12          // border radius for menu container
    property int appleMenuOutline: 2     // inner outline width (like border thickness)
    property int appleMenuPadding: 10     // padding inside menu



}
