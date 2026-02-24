// Global.qml
pragma Singleton
import QtQuick

import "scripts" as Scripts

QtObject {
    property string activeMenu: "" // "" = none, "controlCenter", "wifi", etc.
    property rect anchorRect: Qt.rect(0, 0, 0, 0)
    property var anchorWindow: null

    function handleBarClick(buttonId, buttonRect, buttonWindow) {
        // console.log("Global.qml | Click received:")
        // console.log("  buttonId:", buttonId)
        // console.log("  buttonRect:", buttonRect.x, buttonRect.y, buttonRect.width, buttonRect.height)
        // console.log("  buttonWindow:", buttonWindow)

        console.log("------ DEBUG SINGLETON ------");
        Scripts.NetworkLogic.debugNetworkStuff();

        if (activeMenu === buttonId) {
            // same menu clicked → close it
            activeMenu = "";
        } else {
            // open new menu
            anchorRect = buttonRect;
            anchorWindow = buttonWindow;
            activeMenu = buttonId;
        }
    }
}
