// shell.qml
import Quickshell
import "bar"
import "appleMenu"
import "controlCenter"

// shell.qml
Scope {
    Bar {
        id: mainBar
    }

    LazyLoader {
        id: controlCenterLoader
        active: Global.controlCenterVisible // Only loads when true

        ControlCenter {
            // Pass the anchor data to the loaded component
            anchorWindow: mainBar.activeWindow
            anchorRect: mainBar.activeButtonRect

            // Handle the "click outside" logic via a signal or global
            onClosed: Global.controlCenterVisible = false
        }
    }
}
