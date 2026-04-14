# 🚀 Linux Autoconfig

Welcome! This is a collection of scripts designed to turn a fresh Arch-based installation into a fully-functional development environment.

---

## 📦 What’s Inside?

The base script handles the core heavy lifting for a clean, productive system:

* **Package Managers:** Installs `yay` (AUR helper) and `flatpak`.
* **Shell Experience:**
    * **Custom `.bashrc`** for productivity.
    * **Starship Prompt:** Styled with the **Catppuccin Mocha** theme.
    * **Fastfetch:** Custom configuration for a clean system summary.
* **Editor (LazyVim):** 
    * **Full Neovim setup** via LazyVim.

---

## 🪾 Omarchy Setup (The Fork)

I also maintain a specialized fork called **amarchy_autoconfig**. This version includes everything above plus:

* **Firefox as Default:** Sets Firefox as the primary system browser.
* **Web App Integration:** Automated scripts to use Firefox or Zen-Browser for Web Apps

---

## 🛠️ Installation

> [!WARNING]  
> Always review scripts before running them on your system.

```bash
# Clone the repository
git clone https://github.com/Keaexe/linux_autoconfig.git
cd linux_autoconfig

# Optional (for omarchy)
# git checkout omarchy_autoconfig

# Make the script executable
chmod +x installAll.sh

# Run the setup
./installAll.sh
