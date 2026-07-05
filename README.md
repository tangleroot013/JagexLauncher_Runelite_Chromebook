Since this is a specialized technical fix for a very specific (and frustrating) set of bugs, your README should serve as both a **User Guide** and a **Technical Post-Mortem**. 

Here is a professional, comprehensive `README.md` tailored for a GitHub repository. I've maintained the "Carter the Duck" spirit in the tone, but kept the technical sections surgically precise for other developers who might stumble upon your repo while fighting the same bugs.

***

# 🦆 OSRS-Crostini-Optimization-Engine

[![Platform](https://img.shields.io/badge/Platform-ChromeOS%20Crostini-blue)](https://developer.chrome.com/docs/chromium/guest-tools/crostini)
[![Language](https://img.shields.io/badge/Shell-Zsh/Bash-orange)](https://zsh.sourceforge.net/)
[![Target](https://img.shields.io/badge/Target-RuneLite%20/%20Jagex%20Launcher-green)](https://runelite.net)

A high-performance wrapper and environment sanitizer for running Old School RuneScape (OSRS) via Flatpak on ChromeOS (Crostini). 

This project solves the "Three Great Walls" of OSRS on Chromebooks: **JVM Tokenization Crashes**, **Non-Breaking Space (NBSP) Corruption**, and **llvmpipe Software Rendering**.

---

## 🛠 The Problems Solved

### 1. The JVM Tokenization Bug
**Symptom:** `Invalid initial heap size: -Xms512m -Xmx2g ...`
**Root Cause:** The Jagex Launcher Flatpak wrapper quotes the `_JAVA_OPTIONS` environment variable, passing the entire string as a single token. The JVM fails to parse this as individual flags.
**Fix:** The engine unsets `_JAVA_OPTIONS` and utilizes `JAVA_TOOL_OPTIONS`, which is read directly by the JRE binary, bypassing the buggy wrapper script.

### 2. The "Invisible Algae" (NBSP) Bug
**Symptom:** Cryptic JVM crashes after copying flags from web documentation.
**Root Cause:** CMS platforms often convert standard ASCII spaces (`0x20`) to UTF-8 Non-Breaking Spaces (`0xC2 0xA0`). These are invisible to the user but fatal to the JVM argument parser.
**Fix:** A high-performance Zsh sanitization layer `[^ -~]` that scrubs all non-printable ASCII characters from JVM environment variables before execution.

### 3. The `llvmpipe` Performance Trap
**Symptom:** Extremely low FPS; CPU usage spikes to 100%.
**Root Cause:** Crostini often defaults to `llvmpipe` (software rasterization) if the GPU passthrough is disabled or the Flatpak sandbox blocks `/dev/dri`.
**Fix:** Automated `flatpak override` injections for the DRI device and optional `GALLIUM_DRIVER=virgl` forcing to ensure hardware acceleration.

---

## 🚀 Installation

### Prerequisites
* **ChromeOS** with Linux (Crostini) enabled.
* **Flatpak** installed.
* **Jagex Launcher** or **Bolt** installed via Flatpak.

### Setup
1. Clone this repository to your local machine:
   ```bash
   git clone https://github.com/yourusername/osrs-crostini-optimization.git
   ```
2. Add the engine to your Zsh configuration:
   ```bash
   echo "source ~/osrs-crostini-optimization/osrs.zsh" >> ~/.zshrc
   source ~/.zshrc
   ```

---

## 🎮 Usage

The engine provides several aliases to simplify your workflow:

| Command | Action | Mode |
| :--- | :--- | :--- |
| `osrs-audit` | Performs a full system health check (GPU, JVM, Sandbox) | Diagnostic |
| `osrs-start` | Launches Jagex Launcher with safe defaults | Software |
| `osrs-accel` | Launches Jagex Launcher with Hardware Acceleration | **Hardware** |
| `osrs-bolt` | Launches Bolt client with safe defaults | Software |
| `osrs-bolt-accel` | Launches Bolt client with Hardware Acceleration | **Hardware** |

### The "Golden Path" for Max Performance:
1. Enable **Crostini GPU Support** in `chrome://flags`.
2. Run `osrs-audit` to verify `OpenGL renderer` is **NOT** `llvmpipe`.
3. Execute `osrs-accel`.
4. Enable the **GPU Plugin** inside RuneLite.

---

## 🔬 Technical Deep Dive

### Environment Sanitization Logic
The engine uses Zsh parameter expansion to ensure environment purity:
```zsh
opts="${opts//[^ -~]/ }"
```
This regex whitelists all printable ASCII characters (Hex 20 to 7E) and replaces any non-standard UTF-8 sequences (like NBSPs) with standard spaces, preventing "Invalid Argument" crashes.

### Sandbox Escape
To allow the Flatpak container to talk to the Intel/AMD GPU on the host, the script executes:
```bash
flatpak override --user --device=dri com.jagexlauncher.JagexLauncher
```
This punches a hole in the sandbox specifically for the Direct Rendering Infrastructure (DRI) device nodes.

---

## 🦆 Contributor Notes
This project was developed with the assistance of **Carter the Duck**, a high-performance AI assistant. If you find a bug, please open an issue. Don't let the bugs swim away!

**License:** MIT  
**Maintainer:** bilbywilby
