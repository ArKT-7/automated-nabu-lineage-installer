# 🚀 Automated Derpfest Installer for Xiaomi Pad 5 (nabu)

A simple and efficient script to flash Derpfest ROM on the Xiaomi Pad 5 (nabu) in fastboot mode.

## 📂 Folder Structure
Download all necessary binaries and files, and organize them as follows:

```plaintext
Derfest-rom.zip
-install_derpfest_linux.sh
-install_derpfest_windows.bat
-update_derpfest_linux.sh
-update_derpfest_windows.bat
└── images
    ├── boot.img
    ├── dtbo.img
    ├── ksu_boot.img
    ├── ksu_dtbo.img
    ├── magisk_boot.img
    ├── super.img
    ├── vbmeta.img
    ├── vbmeta_system.img
    └── vendor_boot.img
└── bin
    ├── windows
    │   ├── platform-tools (files)
    │   └── log-tool (tee.exe files)
    └── linux
        └── platform-tools (files)
```

## 🔧 Installation and Usage

### Linux Users:
1. Make sure the scripts are executable(If Needed):
   ```bash
   chmod +x install_derpfest_linux.sh update_derpfest_linux.sh
   ```
   
2. Run the installation or update script:
   ```bash
   ./install_derpfest_linux.sh    # For installation
   ./update_derpfest_linux.sh     # For updating
   ```

### Windows Users:
- Simply run the .bat file for installation or updating:
  ```plaintext
  install_derpfest_windows.bat   # For installation
  update_derpfest_windows.bat    # For updating
  ```

### 📜 Notes
- **Images Folder:** Contains necessary partition images.
- **Bin Folder:** Stores platform tools and logging utilities for both Windows and Linux.
  - If these files or folders are missing, the script will automatically download the required files, create the necessary folders, and place the platform tools and logging utilities (like `tee.exe`) in the appropriate locations.


---
# Enjoy a smooth flashing experience with the **Automated Derpfest Installer**!
---

