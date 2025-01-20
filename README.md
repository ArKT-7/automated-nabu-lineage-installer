# 🚀 Automated Lineage OS Installer for Xiaomi Pad 5 (nabu)

## A simple and efficient script to flash Lineage ROM on the Xiaomi Pad 5 (nabu) in fastboot mode.
### ROM A15 LATEST FLASTBOOT/RECOVERY FLASHABLE LINK [lineage-22.1-20250115-UNOFFICIAL-nabu-FASTBOOT_RECOVERY](https://1drv.ms/u/c/e503a90e3c75d1ba/EePOGMhdCy9OlagQrbOYf48BHZfLSw7lxTiIqWsMz_d_Ig?e=pYeEji)
### 🏆 Original ROM Creator
### This ROM was built by [dev-harsh1998](https://github.com/dev-harsh1998). Special thanks for making this ROM available!
---
### 🛠 Support
### **ROM Support Group**: [Join here on Telegram](https://t.me/xiaomipad5global) for assistance, updates, and community support.
---

## 📂 Folder Structure
### Download all necessary binaries, files and [images](https://github.com/ArKT-7/automated-nabu-lineage-installer/releases/tag/lineage-22.1-20250115-UNOFFICIAL-nabu), and organize them as follows:

```plaintext
LineageOS-rom.zip

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

└── META-INF
    └── com
        ├── arkt 
        │   └── bootctl (binary for switch slot)
        └── google
            └── android
                ├── update-binary 
                └── updater-script 

└── bin
    ├── windows
    │   ├── platform-tools (files)
    │   └── log-tool (tee.exe files)
    └── linux
        └── platform-tools (files)

└── ROOT_APK_INSATLL_THIS_ONLY
    ├── KernelSU.apk (1.0.1)
    └── Magisk.apk (V28.1 Stable)
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
- **ROOT_APK_INSATLL_THIS_ONLY Folder:** Stores [Magisk apk](https://github.com/topjohnwu/Magisk/releases/tag/v28.1) from which the Magisk boot is patched and [KernelSU apk](https://github.com/rsuntk/KernelSU/releases/tag/v1.0.2-40-legacy) (For root).
- **Bin Folder:** Stores platform tools and logging utilities for both Windows and Linux.
  - **Platform Tools for Windows:** [Download here](https://developer.android.com/studio/releases/platform-tools)  
  - **Platform Tools for Linux:** [Download here](https://developer.android.com/studio/releases/platform-tools)  
  - **tee.exe for Windows logging utility:** [Download here](https://github.com/dEajL3kA/tee-win32)
  - If these files or folders are missing, the script will automatically download the required files, create the necessary folders, and place the platform tools and logging utilities in the appropriate locations.


---
### Enjoy a smooth flashing experience with the **Automated Lineage Installer**!
---

