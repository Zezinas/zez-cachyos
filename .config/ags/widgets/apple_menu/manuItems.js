// ~/.config/ags/widgets/apple_menu/menuItems.js

import { spawn } from "ags";

// Helper function to run shell commands
const run = (cmd) => () => spawn(cmd.split(" "));

export const appleMenuItems = [
  {
    label: "About this Mac",
    action: run("alacritty -e fastfetch"), // launches terminal + fastfetch
  },
  {
    label: "Updates",
    action: run("alacritty -e sh -c 'sudo pacman -Syu && yay -Syu'"),
  },
  {
    label: "Terminal",
    action: run("alacritty"), // open default terminal
  },
  { separator: true },
  {
    label: "Sleep",
    action: run("systemctl suspend"), // could replace with hyprctl if needed
  },
  {
    label: "Restart...",
    action: run("systemctl reboot"),
  },
  {
    label: "Shut Down...",
    action: run("systemctl poweroff"),
  },
  { separator: true },
  {
    label: "Lockscreen",
    action: run("loginctl lock-session"), // placeholder, update if you use swaylock, slock, etc.
  },
];
