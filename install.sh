#!/bin/bash
set -e

USER_NAME="${SUDO_USER:-$USER}"
INSTALL_DIR="/opt/thermal-kiosk"
SERVICE_PATH="/etc/systemd/system/thermal-fullscreen.service"

echo "==> Installing packages..."
sudo apt update
sudo apt install -y ffmpeg v4l-utils

echo "==> Installing to ${INSTALL_DIR}..."
sudo mkdir -p "${INSTALL_DIR}"
sudo rsync -a --delete ./ "${INSTALL_DIR}/"

echo "==> Creating systemd service for user: ${USER_NAME}"
sudo sed \
  -e "s|{{USER}}|${USER_NAME}|g" \
  -e "s|{{INSTALL_DIR}}|${INSTALL_DIR}|g" \
  "${INSTALL_DIR}/systemd/thermal-fullscreen.service.template" | sudo tee "${SERVICE_PATH}" >/dev/null

echo "==> Enabling service..."
sudo systemctl daemon-reload
sudo systemctl enable thermal-fullscreen.service
sudo systemctl restart thermal-fullscreen.service

echo
echo "✅ Installed!"
echo "Status: systemctl status thermal-fullscreen.service -l --no-pager"
echo "Logs:   journalctl -u thermal-fullscreen.service -e --no-pager"
echo "Reboot: sudo reboot"
