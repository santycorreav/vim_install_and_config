# Vim Install and Config for Void Linux

This repository contains a Bash script designed to automate the installation and configuration of Vim (`vim-x11`) on Void Linux environments. It sets up a fast, development-ready `.vimrc` with an intuitive window management system using the native Netrw file explorer.

## Features

- **Automated Installation:** Checks if `vim-x11` is installed via `xbps-query` and installs it via `xbps-install` if missing.
- **Safe Backup:** Automatically creates a backup of your existing `~/.vimrc` to `~/.vimrc_backup` before making any changes.
- **Idempotent Execution:** Checks if the configuration is already applied to avoid duplicating lines in your `.vimrc`.
- **Performance Optimized:** Configures Vim for speed (using `lazyredraw`, `ttyfast`, and the classic regex engine).
- **Native File Explorer:** Enhances Netrw to work like an IDE sidebar without requiring heavy third-party plugins.

## Custom Keybindings

This configuration uses the **Space** key as the `<Leader>` key to provide comfortable, ergonomic shortcuts without relying on `Ctrl`, `Alt`, or `Super`:

- `<Space> + e` : Toggle the file explorer (Netrw) on the left sidebar.
- `<Enter>` *(inside the explorer)* : Open the selected file, replacing the current active buffer (changes the literal file).
- `<Space> + <Enter>` *(inside the explorer)* : Open the selected file in a new vertical split to the right (keeps the previous file open).
- `<Space> + Tab` : Switch focus between open windows.
- `<Space> + q` : Close the current file/window (it will warn you and prevent action if you try to use it to close the explorer).

## Step-by-Step Usage

**Step 1: Download or clone the repository**
Ensure you have the `vim_install_and_config.sh` file on your local machine and open your terminal in that directory.

**Step 2: Grant execution permissions**
Before running the script, give it executable permissions so the system allows it to run:
` ` `bash
chmod +x vim_install_and_config.sh
` ` `

**Step 3: Execute the script**
Run the installer script:
` ` `bash
./vim_install_and_config.sh
` ` `
*Note: If `vim-x11` is not currently installed, the script will request your administrator (sudo) password to install it via xbps.*

**Step 4: Start using Vim**
Once the terminal displays the success message, open Vim to see your new configuration in action:
` ` `bash
vim
` ` `

---

Author: Santiago Correa.
