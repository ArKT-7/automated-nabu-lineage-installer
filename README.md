# 🚀 Automated Lineage OS Installer for Xiaomi Pad 5 (nabu)

## A simple and efficient script to flash Lineage ROM on the Xiaomi Pad 5 (nabu) in fastboot mode.
### ROM A15 LATEST FLASTBOOT FLASHABLE LINK [lineage-22.0-20241201-UNOFFICIAL-nabu-FASTBOOT](https://1drv.ms/f/s!ArrRdTwOqQPll48G9o3XYsFBhHFNvQ?e=t9h7q3)
### 🏆 Original ROM Creator
### This ROM was built by [dev-harsh1998](https://github.com/dev-harsh1998). Special thanks for making this ROM available!
---
### 🛠 Support
### **ROM Support Group**: [Join here on Telegram](https://t.me/xiaomipad5global) for assistance, updates, and community support.
---

## 📂 Folder Structure
### Download all necessary binaries, files and [images](https://github.com/ArKT-7/automated-nabu-Lineage-installer/releases/tag/Lineage-november), and organize them as follows:

```plaintext
Derfest-rom.zip

-install_LineageOS_linux.sh
-install_LineageOS_windows.bat
-update_LineageOS_linux.sh
-update_LineageOS_windows.bat

└── images
    ├── boot.img
    ├── dtbo.img
    ├── magisk_boot.img
    ├── userdata.img
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

└── ROOT_APK_INSATLL_THIS_ONLY
    ├── KernelSU.apk (1.0.1)
    └── Magisk.apk (V28 Stable)
```

## 🔧 Installation and Usage

### Windows Users:
- Simply run the .bat file for installation or updating:
  ```plaintext
  install_LineageOS_windows.bat   # For installation
  update_LineageOS_windows.bat    # For updating
  ```
  
### Linux Users:
#### 1. Make sure the scripts are executable(If Needed):
   ```bash
   chmod +x install_LineageOS_linux.sh update_LineageOS_linux.sh
   ```
   
#### 2. Run the installation or update script:
   ```bash
   sudo bash ./install_lineageOS_linux.sh    # For installation
   sudo bash ./update_LineageOS_linux.sh     # For updating
   ```

### 📜 Notes
- **Images Folder:** Contains necessary partition images.
- **ROOT_APK_INSATLL_THIS_ONLY Folder:** Stores Magisk apk from which the Magisk boot is patched and KSU apk (For root).
- **Bin Folder:** Stores platform tools and logging utilities for both Windows and Linux.
  - **Platform Tools for Windows:** [Download here](https://developer.android.com/studio/releases/platform-tools)  
  - **Platform Tools for Linux:** [Download here](https://developer.android.com/studio/releases/platform-tools)  
  - **tee.exe for Windows logging utility:** [Download here](https://github.com/dEajL3kA/tee-win32)
  - If these files or folders are missing, the script will automatically download the required files, create the necessary folders, and place the platform tools and logging utilities in the appropriate locations.


---
### Enjoy a smooth flashing experience with the **Automated Lineage Installer**!
---

