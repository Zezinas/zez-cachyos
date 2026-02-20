// Theme.qml
pragma Singleton
import QtQuick

QtObject {
    // GENERAL BAR THEMING

    // Colors
    property color bg: Qt.rgba(28 / 255, 28 / 255, 28 / 255, 0.75)
    // property color bg: Qt.rgba(255/255, 0/255, 0/255, 0.3)
    property color bgHover: Qt.rgba(255 / 255, 255 / 255, 255 / 255, 0.10)
    property color bgActive: Qt.rgba(255 / 255, 255 / 255, 255 / 255, 0.15)
    property color fgActive: Qt.rgba(10 / 255, 132 / 255, 255 / 255, 1)
    property color bgOutline: Qt.rgba(255 / 255, 255 / 255, 255 / 255, 0.08)

    // property color text: Qt.rgba(1, 1, 1, 0.9)
    property color text: Qt.rgba(35 / 255, 37 / 255, 38 / 255, 1.00) // black 90%

    // Typography: ;
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

    //
    //
    //

    // APPLE MENU STYLING
    property int appleMenuTextPaddingH: 9        // 18 // text horizontal padding
    property int appleMenuTextPaddingV: 2         //  4 // text vertical padding
    property int appleMenuRadius: 6              // 12 // border radius for menu container
    property int appleMenuOutline: 1              //  2 // inner outline width (like border thickness)
    property int appleMenuPadding: 5             // 10 // padding inside menu

    //
    //
    //

    // CONTROL CENTER STYLING (Light)
    property color bgFig03: Qt.rgba(245 / 255, 245 / 255, 245 / 255, 0.15) // Background #03
    property color bgFig02: Qt.rgba(245 / 255, 245 / 255, 245 / 255, 0.30) // Background #02
    property color bgFig01: Qt.rgba(245 / 255, 245 / 255, 245 / 255, 0.80) // Background #01

    property color plusDarker: Qt.rgba(0 / 255, 0 / 255, 0 / 255, 0.05)
    property color plusLigher: Qt.rgba(245 / 255, 245 / 255, 245 / 255, 0.15)

    property color fgBlue: Qt.rgba(1 / 255, 122 / 255, 255 / 255, 1.00) // black 90%

    // Typography (Light)
    property color textPrimary: Qt.rgba(35 / 255, 37 / 255, 38 / 255, 1.00) // black 90%
    property color textSecondary: Qt.rgba(121 / 255, 121 / 255, 121 / 255, 1.00) // grey 50%

    // Typography (Dark)
    // property color text: Qt.rgba(1, 1, 1, 0.9)
    // property color textSecondary: Qt.rgba(121 / 255, 121 / 255, 121 / 255, 1.00) // grey 50%

    // BAR (Light)
    property color bgBar: bgFig02

    // BAR (Dark)
    // property color bgBar: Qt.rgba(30 / 255, 30 / 255, 30 / 255, 0.35)
}

// colors
// main 3
// main 2
// main 1
//
// blue
//
// modifier
