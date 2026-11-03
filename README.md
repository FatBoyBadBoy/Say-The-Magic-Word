<div align="center">

# 🦖 magic-word-sudo

**Ah, ah, ah... you didn't say the magic word!**

Get the classic Jurassic Park "access denied" moment every time you fail your `sudo` password 3 times.

![Shell: fish](https://img.shields.io/badge/shell-fish-4AAE46?logo=gnubash&logoColor=white)
![Platform: Linux](https://img.shields.io/badge/platform-Linux-FCC624?logo=linux&logoColor=black)
![License: MIT](https://img.shields.io/badge/license-MIT-blue)

</div>

---

## ✨ What it does

When you type your `sudo` password wrong 3 times in a row, you get:

- 🔴 A big red **ACCESS DENIED** banner in the terminal
- 🟡 "Ah, ah, ah..." followed by a flood of **YOU DIDN'T SAY THE MAGIC WORD!**
- 🔔 A desktop notification
- 🎞️ Your own GIF or video clip in a popup window (optional)

If you type the right password, `sudo` works exactly like normal.

<!-- Add a screenshot of your terminal here, for example:
![Demo](assets/demo.png)
-->

## 📦 Requirements

| Required | Optional |
|---|---|
| [fish shell](https://fishshell.com/) | `figlet` for the big ASCII banner |
| `sudo` | `mpv` to play a GIF/video clip |
| | `libnotify` for desktop notifications |

On Arch / CachyOS:

```bash
sudo pacman -S --needed figlet mpv libnotify
```

## 🚀 Installation

```bash
git clone https://github.com/YOUR-USERNAME/magic-word-sudo.git
cd magic-word-sudo
./install.sh
```

Then open a new terminal, or run `exec fish`.

### Adding a GIF or video

No media is included in this repo. If you have your own clip (`.gif`, `.mp4` or `.webm`), pass it to the installer:

```bash
./install.sh ~/Downloads/your-clip.gif
```

Or copy it manually:

```bash
mkdir -p ~/.local/share/magic-word
cp ~/Downloads/your-clip.gif ~/.local/share/magic-word/clip.gif
```

## 🧪 Testing

```bash
sudo -k      # forget the cached password
sudo ls      # type the wrong password 3 times
```

To see the effect without failing a password, run:

```bash
magic_word
```

## ⚙️ How it works

The project installs two fish functions:

- **`sudo.fish`** wraps the real `sudo`. It first runs `sudo -v`, which only checks your password (3 tries). If that fails, it calls `magic_word`. If it succeeds, your actual command runs.
- **`magic_word.fish`** shows the banner, the notification and the clip.

`command sudo` is used inside the wrapper, so it always calls the real `sudo` binary and never loops.

## ⚠️ Account lockout (faillock)

Many distros, including Arch and CachyOS, use **faillock**, which locks your account for 10 minutes after 3 wrong passwords. That means testing this can lock you out.

If you're locked, wait 10 minutes or reboot. To change the limit:

```bash
sudo nano /etc/security/faillock.conf
```

Set `deny` to a higher number such as `deny = 10`, or `deny = 0` to turn the lockout off completely. Turning it off means unlimited password guesses, so use a strong password.

Reset failed attempts:

```bash
sudo faillock --user $USER --reset
```

## 🚧 Limitations

- Only works for `sudo` typed in a **fish** terminal. Bash scripts, polkit/pkexec, and graphical password dialogs are not affected.
- Pressing Ctrl+C at the password prompt also triggers the message.
- On KDE Wayland, `--ontop` may not keep the popup above other windows.

## 🗑️ Uninstall

```bash
./uninstall.sh
```

## 📄 License

[MIT](LICENSE). Jurassic Park is a trademark of Universal Pictures. This project is a fan joke and is not affiliated with or endorsed by Universal.

## AI 

This project is made with the help of AI(cluade), and it not a 100% Human made.
