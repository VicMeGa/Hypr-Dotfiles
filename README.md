# 🌀 Hyprland Dotfiles

This is my personal **Hyprland** setup. I'm not a big fan of the excessive transparency found in many Hyprland themes, so I built my own rice with a focus on visual harmony and low eye strain.

I use Hyprland as my main operating system, so I've tuned it to be comfortable, functional, and visually balanced for daily use. If you have any suggestions or better ideas, feel free to modify or adapt this rice to your liking 😊.

![Hyprland Screenshot](./screenshots/hyprland.png)

---

## 📦 Main Components

- **Hyprland** – Wayland compositor
- **Waybar** – Customizable top bar
- **Hyprlock** – Lock screen
- **Hyprpaper** – Wallpaper manager
- **Swaync** – Notification center
- **Rofi / Wofi** – App launchers
- **Kitty** – Terminal emulator
- **Fish** – Friendly interactive shell
- **Fastfetch / Neofetch** – System info in terminal
- **Dolphin** – File manager

---

## 🖥️ Requirements

Before using this setup, make sure you have:

- An Arch-based distribution (recommended)
- Wayland environment
- [Hyprland](https://github.com/hyprwm/Hyprland)
- [Waybar](https://github.com/Alexays/Waybar)
- [Hyprlock](https://github.com/hyprwm/hyprlock)
- [Swaync](https://github.com/ErikReider/SwayNotificationCenter)
- [Rofi](https://github.com/davatorium/rofi) or [Wofi](https://hg.sr.ht/~scoopta/wofi)
- [Fish](https://github.com/fish-shell/fish-shell)

---

## 🚀 Installation

1. Install the required dependencies:
```
# On Arch Linux
sudo pacman -S hyprland waybar kitty rofi dolphin fish fastfetch
yay -S swaync-git hyprlock-git hyprpaper-git
```
2. Clone this repository:
```bash
git clone https://github.com/your-username/hyprland-config.git ~/.config
```
3. Move config files

```bash
cd Hypr-Dotfiles/config
mv * ~/.config
```

4. Log in to Hyprland from your session manager (e.g., sddm, greetd, ly).

5. (Optional) Enable services. Personally, I start them from Hyprland's config file, but it's often better to manage service initialization from your system:
``` bash
systemctl --user enable --now swaync
```