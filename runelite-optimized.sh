#!/usr/bin/env bash
set -euo pipefail
export _JAVA_AWT_WM_NONREPARENTING=1
export GDK_BACKEND=x11
export SB_opengl=1
export J2D_D3D=false
export JAVA_FONTS_U_SCALE=1.0
TOTAL_KB=$(grep MemTotal /proc/meminfo | awk '{print $2}')
TOTAL_MB=$(( TOTAL_KB / 1024 ))
if (( TOTAL_MB >= 6000 )); then
  HEAP_SIZE="3072m"
elif (( TOTAL_MB >= 3500 )); then
  HEAP_SIZE="2048m"
else
  HEAP_SIZE="1024m"
fi
TARGET_DIR="$HOME/JagexLauncher_Runelite_Chromebook"
TARGET="$TARGET_DIR/RuneLite.AppImage"
ICON_URL="https://runelite.net/img/logo.png"
ICON_PATH="$TARGET_DIR/runelite.png"
LAUNCHER_URL="https://github.com/runelite/launcher/releases/latest/download/RuneLite.AppImage"
mkdir -p "$TARGET_DIR"
if [[ ! -f "$TARGET" ]]; then
  printf '\033[0;33m[!]\033[0m Target not found. Downloading official RuneLite AppImage...\n'
  curl -L -o "$TARGET" "$LAUNCHER_URL"
fi
chmod +x "$TARGET"
DESKTOP_DIR="$HOME/.local/share/applications"
DESKTOP_FILE="$DESKTOP_DIR/runelite.desktop"
if [[ ! -f "$ICON_PATH" ]] && command -v curl >/dev/null 2>&1; then
  curl -fsSL -o "$ICON_PATH" "$ICON_URL"
fi
if [[ ! -f "$DESKTOP_FILE" ]]; then
  mkdir -p "$DESKTOP_DIR"
  cat <<EOT > "$DESKTOP_FILE"
[Desktop Entry]
Name=RuneLite
Comment=Optimized Client for Old School RuneScape
Exec=$HOME/.local/bin/runelite
Icon=${ICON_PATH}
Terminal=false
Type=Application
Categories=Game;
Keywords=runescape;osrs;runelite;
StartupNotify=true
EOT
  chmod +x "$DESKTOP_FILE"
fi
exec "$TARGET" \
  --J-Xmx"${HEAP_SIZE}" \
  --J-Xms"${HEAP_SIZE}" \
  --J-XX:+UseZGC \
  --J-Dsun.java2d.opengl=true \
  --mode=OFF \
  "$@"
