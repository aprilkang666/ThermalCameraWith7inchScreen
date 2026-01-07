# ThermalCameraWith7inchScreen
# thermal-kiosk (Raspberry Pi)

Boot directly into a fullscreen thermal camera view on Raspberry Pi using `ffplay`.

This repo does **NOT** include any `.img` OS image.  
Instead, it provides scripts + systemd service + boot config snippets so anyone can rebuild the same setup.

---

## Hardware / Requirements

- Raspberry Pi (CM4 OK)
- USB thermal camera (UVC / V4L2), shows up as `/dev/video0`
- GUI desktop enabled (HDMI or DSI)
- Tested format: `yuyv422`, `640x512`, `30fps`

---

## Important beginner notes

- `usbboot` is **only a flashing tool**
- `config.txt` does **NOT** exist inside usbboot
- `config.txt` exists **only after the OS is installed and booted**
- This repository provides **snippets**, not full boot partitions

---

## 1): Clone the repository

Run these commands **on the Raspberry Pi**, not on your Mac:

```bash
git clone <YOUR_GITHUB_REPO_URL>
cd thermal-kiosk
```

## 2) Installation

```bash
git clone <YOUR_REPO_URL>
cd thermal-kiosk
chmod +x install.sh
sudo ./install.sh
sudo reboot
```
After reboot, the thermal camera will start automatically in fullscreen.

## 3) Apply boot configuration (`config.txt`)

config.txt may be located in /boot/config.txt or /boot/firmware/config.txt
Paste boot/config.txt.snippet at the bottom and reboot.
- `/boot/config.txt`
- `/boot/firmware/config.txt`

### Find which one exists

```bash
ls /boot
ls /boot/firmware
```
Edit the file that contains config.txt
```bash
sudo nano /boot/firmware/config.txt
# Use the following instead if config.txt is located directly under /boot:
# sudo nano /boot/config.txt
```

### Apply the configuration snippet

From this repository, copy the contents of:

boot/config.txt.snippet

Paste it at the bottom of config.txt.

Save and reboot:

```bash
sudo reboot
```

## USB camera note

- USB cameras do NOT need dtoverlay

- Do NOT enable CSI sensor overlays such as ov5647, imx219, or imx477

- USB cameras appear automatically as /dev/video0

## Fullscreen thermal command

The fullscreen thermal view is launched using:

```bash
ffplay -f v4l2 -input_format yuyv422 -video_size 640x512 -framerate 30 -fs /dev/video0
```
