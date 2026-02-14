import AppleMenu from "./widgets/apple_menu/main.js";

const appleMenu = new AppleMenu();

// Register widget so you can call it later
ags.registerWidget(appleMenu);

// Optional: show immediately for testing
appleMenu.show();
