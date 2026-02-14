import { Gtk, Gdk } from "astal/gtk3";
import { appleMenuItems } from "./menuItems.js";

export default function AppleMenu() {
  return Widget({
    type: Gtk.Window,
    name: "apple_menu",
    layer: Gtk.Layer.OVERLAY,
    anchor: Gtk.Anchor.TOP | Gtk.Anchor.LEFT,
    keymode: Gtk.Keymode.ON_DEMAND,
    visible: false,
    child: Widget({
      type: Gtk.Box,
      orientation: Gtk.Orientation.VERTICAL,
      spacing: 0,
      className: "apple-menu-container",
      children: appleMenuItems.map((item) =>
        item.separator
          ? Widget({ type: Gtk.Separator, className: "menu-separator" })
          : Widget({
              type: Gtk.Button,
              className: "menu-button",
              label: item.label,
              on_clicked: item.action,
            }),
      ),
    }),
  });
}

// Helper to show at pointer
export function showAppleMenu() {
  const display = Gdk.Display.get_default();
  const seat = display?.get_default_seat();
  const pointer = seat?.get_pointer();
  if (pointer) {
    const [, x, y] = pointer.get_position();
    // Position and show window
  }
}
