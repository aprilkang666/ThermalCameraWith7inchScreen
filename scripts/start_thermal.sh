#!/bin/bash
set -e

# 等桌面與 USB camera 準備好
sleep 2

# GUI 顯示用（有桌面時通常是 :0）
export DISPLAY=:0

# 防止螢幕休眠/黑屏（可選，但建議）
xset s off || true
xset -dpms || true
xset s noblank || true

# 全螢幕顯示 USB thermal cam（V4L2）
exec ffplay -hide_banner -loglevel error \
  -fflags nobuffer -flags low_delay \
  -f v4l2 -input_format yuyv422 -video_size 640x512 -framerate 30 \
  -fs /dev/video0
