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

## 1) Install (one command)

```bash
git clone <YOUR_REPO_URL>
cd thermal-kiosk
chmod +x install.sh
sudo ./install.sh
sudo reboot
