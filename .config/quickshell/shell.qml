// shell.qml
import Quickshell
import "bar"
import "appleMenu"

Scope {
    property var appleAnchorButton: null
    property var appleBarWindow: bar    // the PanelWindow inside Bar.qml

    // LazyLoader {
    //     id: appleMenuLoader
    //     active: appleAnchorButton !== null

    //     AppleMenu {
    //         id: appleMenuInstance
    //         anchorButton: appleAnchorButton
    //         anchorWindow: appleBarWindow
    //     }
    // }

    Bar {
        id: bar

        onToggleAppleMenu: (button) => {
            console.log("shell.qml | ", "BarItem clicked! Rectangle id:", button.id, "text:", button.text, "### " + button)

            // optional: still toggle variable for testing
            if (appleAnchorButton === button) {
                appleAnchorButton = null
            } else {
                appleAnchorButton = button
            }
        }
    }

}
