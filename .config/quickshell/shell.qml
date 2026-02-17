// shell.qml
import Quickshell
import "bar"
import "appleMenu"

Scope {
    property var appleAnchorButton: null
    property var appleBarWindow: null
    property bool appleMenuOpen: false

    Bar {
        id: bar

        onToggleAppleMenu: (button, window) => {
            console.log("shell.qml | ", "BarItem clicked! Rectangle id:", button.id, "text:", button.text, "### " + button)

            console.log("shell.qml | ", "appleAnchorButton = ", appleAnchorButton, " | button = ", button, " | window = ", window)

            // optional: still toggle variable for testing
            if (appleAnchorButton === button) {
                console.log("shell.qml | ", "IF TRUE ", "appleAnchorButton = ", appleAnchorButton, " | button = ", button, " | window = ", window)
                appleMenuOpen = false

                appleAnchorButton = null
                appleBarWindow = null
            } else {
                console.log("shell.qml | ", "IF FALSE ", "appleAnchorButton = ", appleAnchorButton, " | button = ", button, " | window = ", window)
                appleAnchorButton = button
                appleBarWindow = window
                appleMenuOpen = true
            }
            console.log("")
            console.log("")
        }
    }

    AppleMenu {
        id: appleMenuInstance

        open: appleMenuOpen
        anchorButton: appleAnchorButton
        anchorWindow: appleBarWindow
    }

}
