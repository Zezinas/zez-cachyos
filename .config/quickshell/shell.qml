// shell.qml
import Quickshell
import "bar"
import "controlCenter"

Scope {
    Bar {
        id: mainBar
    }

    LazyLoader {
        active: Global.activeMenu === "controlCenter"
        ControlCenter {
            anchorWindow: Global.anchorWindow
            anchorRect: Global.anchorRect
            onClosed: Global.activeMenu = ""
        }
    }

    // UiTest {
    //     id: uiTest
    // }

    // LazyLoader {
    //     active: Global.activeMenu === "wifi"
    //     WifiMenu {
    //         anchorWindow: Global.anchorWindow
    //         anchorRect: Global.anchorRect
    //         onClosed: Global.activeMenu = ""
    //     }
    // }

    // LazyLoader {
    //     active: Global.activeMenu === "bluetooth"
    //     BluetoothMenu {
    //         anchorWindow: Global.anchorWindow
    //         anchorRect: Global.anchorRect
    //         onClosed: Global.activeMenu = ""
    //     }
    // }
}
