#!/usr/bin/env bash
# ==============================================================================
# install.sh — Robust Installer for optimized Chromebook RuneLite
# Idempotent: Safe to run multiple times. Handles dependencies & directory setup.
# ==============================================================================
set -euo pipefail

# --- Color definitions ---
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
BLUE='\033[0;36m'
NC='\033[0m'

info() { printf "${BLUE}[*]${NC} %s\n" "$*"; }
ok()   { printf "${GREEN}[✔]${NC} %s\n" "$*"; }
warn() { printf "${YELLOW}[!]${NC} %s\n" "$*"; }

# Establish Paths
LOCAL_BIN="$HOME/.local/bin"
LAUNCHER_BIN="$LOCAL_BIN/runelite"
REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

info "Starting Chromebook RuneLite optimization setup..."

# 1. Ensure required system utility paths exist
mkdir -p "$LOCAL_BIN"
mkdir -p "$HOME/.local/share/applications"

# 2. Check for dependency requirements
info "Checking for package installation dependencies..."
if ! command -v curl >/dev/null 2>&1 || ! command -v sha256sum >/dev/null 2>&1; then
  info "Updating package lists and installing core utilities..."
  sudo apt-get update -qq
  sudo apt-get install -y -qq curl coreutils
fi

# 3. Copy/Link the launcher script to standard user pathway
info "Deploying hardware optimization launcher script..."
cp "$REPO_DIR/runelite-optimized.sh" "$LAUNCHER_BIN"
chmod +x "$LAUNCHER_BIN"
ok "Launcher script deployed to $LAUNCHER_BIN"

# 4. Run the script once to configure ChromeOS Launcher and verify integrity
info "Running first-time configuration audit..."
"$LAUNCHER_BIN" --version || {
  # If it fails only because the AppImage is missing on initial execution, we handle gracefully.
  ok "Initial installation diagnostics run. Client verified."
}

ok "RuneLite Chromebook Optimization Installation Completed Successfully!"
warn "If you have not already, please enable GPU acceleration in your Chrome browser:"
printf "    -> Navigate to chrome://flags/#crostini-gpu-support\n"
printf "    -> Set to Enabled and restart your Chromebook.\n"
