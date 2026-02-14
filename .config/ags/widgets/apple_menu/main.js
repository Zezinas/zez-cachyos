// ~/.config/ags/widgets/apple_menu/main.js
import ags from "ags";
import { appleMenuItems } from "./menuItems.js";
import "./style.css";

export default class AppleMenu extends ags.Widget {
  constructor() {
    super({ name: "apple_menu", id: "apple_menu" });

    // Vertical container
    this.container = new ags.Widget({ type: "vbox", spacing: 0 });

    // Build menu
    appleMenuItems.forEach((item) => {
      if (item.separator) {
        this.container.addChild(new ags.Widget({ type: "separator" }));
      } else {
        const button = new ags.Widget({
          type: "button",
          label: item.label,
          onClick: item.action,
        });
        this.container.addChild(button);
      }
    });

    this.addChild(this.container);
  }

  // Method to show menu at pointer or relative to button
  show(x = 0, y = 0) {
    this.popupAt(x, y);
  }
}
