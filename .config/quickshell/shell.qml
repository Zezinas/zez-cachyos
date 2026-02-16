// shell.qml
import Quickshell
import "bar"
import "appleMenu"

Scope {
    LazyLoader {
      id: appleMenuLoader
      active: false

      AppleMenu {}
    }

  Bar {
    id: bar

    onToggleAppleMenu: {
        console.log("signal working shell.qml - onToggleAppleMenu")  // debug log
        appleMenuLoader.active = !appleMenuLoader.active
    }
  }

  AppleMenu {}
}
