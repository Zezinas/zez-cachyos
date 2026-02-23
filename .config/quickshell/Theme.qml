// Theme.qml
pragma Singleton
import QtQuick

QtObject {

    // Global Theme + Scale
    property bool darkMode: false // property int valueName: darkMode ? valueDark : valueLight
    property real uiScale: 1.00

    // Typography:
    property string fontFamily: "SF Pro Text"
    property int fontSize: 14
    property int fontWeight: 500


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
