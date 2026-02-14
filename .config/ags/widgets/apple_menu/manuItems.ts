import { execAsync } from "astal/utils";

// Helper function to run shell commands
const run = (cmd: string) => () => execAsync(cmd).catch(print);

export const appleMenuItems = [
  {
    label: "About this Mac",
    action: run("alacritty -e fastfetch"),
  },
  {
    label: "Updates",
    action: run("alacritty -e sh -c 'sudo pacman -Syu && yay -Syu'"),
  },
  {
    label: "Terminal",
    action: run("alacritty"),
  },
  { separator: true },
  {
    label: "Sleep",
    action: run("systemctl suspend"),
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
    action: run("loginctl lock-session"),
  },
];
