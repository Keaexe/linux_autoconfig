# 🚀 Linux Autoconfig

Welcome! This is a collection of scripts designed to turn a fresh Arch-based installation into a fully-functional development environment.

---

## 📦 What’s Inside?

The base script handles the core heavy lifting for a clean, productive system:

* **Package Managers:** Installs `yay` (AUR helper) and `flatpak`.
* **Shell Experience:** * **Custom `.bashrc`** for productivity.
    * **Starship Prompt:** Styled with the **Catppuccin Mocha** theme.
    * **Fastfetch:** Custom configuration for a clean system summary.
* **Editor (LazyVim):** * Full Neovim setup via LazyVim.
    * **Custom Keymaps:** Optimized specifically for **AZERTY** keyboards.

---

## 🦊 Omarchy Setup (The Fork)

I also maintain a specialized fork called **Omarchy Setup**. This version includes everything above plus:

* **Firefox as Default:** Sets Firefox as the primary system browser.
* **Web App Integration:** Automated scripts to use Firefox for PWAs (Web Apps) with a chromeless, "native" look using `userChrome.css`.
* **Profile Automation:** Includes logic to automatically detect or create Firefox profiles and enable stylesheet support via bash.

---

## 🛠️ Installation

> [!WARNING]  
> Always review scripts before running them on your system.

```bash
# Clone the repository
git clone [https://github.com/your-username/your-repo-name.git](https://github.com/your-username/your-repo-name.git)
cd your-repo-name

# Make the script executable
chmod +x setup.sh

# Run the setup
./setup.sh
