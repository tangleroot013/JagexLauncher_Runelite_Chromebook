Chromebook Crostini RuneLite Optimizer 🚀

An advanced, production-grade launch optimizer specifically built for Old School RuneScape (OSRS) via RuneLite in the ChromeOS Linux (Crostini) Container environment.

🛠 Features

Dynamic Heap Memory Allocation: Automatically scales standard JVM heap size configurations between 1GB, 2GB, and 3GB dynamically based on total system memory resources.

Hardware Graphics Pipeline Binding: Forces the application to leverage Chromebook GPU render pipelines (opengl) instead of dropping back to software rasterizers.

Micro-stutter & Input Lag Minimizer: Configures Garbage Collection to use low-latency ZGC with specialized compile-scheduling thresholds.

Wayland Display Alignment: Corrects Sommelier desktop-scaling and mouse-pointer issues (like camera rotation bugs) to ensure smooth 3D navigation.

First-Class Launcher Integration: Automatically produces application desktop shortcuts, allowing you to pin the game client to your ChromeOS shelf directly.

📦 Quick Start Installation

Open your Chromebook's Linux (Crostini) Terminal and execute:

# 1. Clone this repository directly into your local machine
git clone [https://github.com/tangleroot013/runelite-crostini-optimizer.git](https://github.com/tangleroot013/runelite-crostini-optimizer.git) ~/.local/share/runelite-optimizer

# 2. Change into the optimization directory
cd ~/.local/share/runelite-optimizer

# 3. Make scripts executable and launch the installer
chmod +x install.sh update.sh runelite-optimized.sh
./install.sh


Once installed, type runelite in your terminal or launch it directly from your Chromebook App Drawer!

🔧 Post-Installation Checklist

To maximize your performance output:

Navigate your Chrome browser to chrome://flags/#crostini-gpu-support and set it to Enabled. Restart your device.

In-game, open the RuneLite Configuration Sidebar (wrench icon) and enable the GPU plugin.

📊 Telemetry Logging

Your wrapper maintains a local diagnostics file to simplify troubleshooting. You can view it anytime:

cat ~/.runelite/launcher_wrapper_debug.log
#######################################################################################
MIT License

Copyright (c) 2026 tangleroot013

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
