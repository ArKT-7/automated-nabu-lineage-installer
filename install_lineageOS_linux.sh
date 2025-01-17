#!/bin/bash

# Change directory to the script's location
cd "$(dirname "$0")"


if [ ! -d "logs" ]; then
    # echo "'logs' folder does not exist. Creating it..."
    mkdir -p "logs"
fi

if [ ! -d "bin" ]; then
    # echo "'bin' folder does not exist. Creating it..."
    mkdir -p "bin"
fi

if [ ! -d "$base_dir/bin/linux" ]; then
    # echo "'linux' folder does not exist. Creating it..."
    mkdir -p "bin/linux"
fi

print_lineageOS_ascii() {
    echo
	echo " ██▓     ██▓ ███▄    █ ▓█████ ▄▄▄        ▄████ ▓█████     ▒█████    ██████ "
	echo "▓██▒    ▓██▒ ██ ▀█   █ ▓█   ▀▒████▄     ██▒ ▀█▒▓█   ▀    ▒██▒  ██▒▒██    ▒ "
	echo "▒██░    ▒██▒▓██  ▀█ ██▒▒███  ▒██  ▀█▄  ▒██░▄▄▄░▒███      ▒██░  ██▒░ ▓██▄   "
	echo "▒██░    ░██░▓██▒  ▐▌██▒▒▓█  ▄░██▄▄▄▄██ ░▓█  ██▓▒▓█  ▄    ▒██   ██░  ▒   ██▒"
	echo "░██████▒░██░▒██░   ▓██░░▒████▒▓█   ▓██▒░▒▓███▀▒░▒████▒   ░ ████▓▒░▒██████▒▒"
	echo "░ ▒░▓  ░░▓  ░ ▒░   ▒ ▒ ░░ ▒░ ░▒▒   ▓▒█░ ░▒   ▒ ░░ ▒░ ░   ░ ▒░▒░▒░ ▒ ▒▓▒ ▒ ░"
	echo "░ ░ ▒  ░ ▒ ░░ ░░   ░ ▒░ ░ ░  ░ ▒   ▒▒ ░  ░   ░  ░ ░  ░     ░ ▒ ▒░ ░ ░▒  ░ ░"
	echo "  ░ ░    ▒ ░   ░   ░ ░    ░    ░   ▒   ░ ░   ░    ░      ░ ░ ░ ▒  ░  ░  ░  "
	echo "    ░  ░ ░           ░    ░  ░     ░  ░      ░    ░  ░       ░ ░        ░  "
    echo
    echo "                             dev-harsh1998                              "
    echo "Script By, @ArKT_7"
    echo
}

# Function to print and log cool ascii header
# NOTE: see above NOTE.
print_log_lineageOS_ascii() {
    echo
	echo " ██▓     ██▓ ███▄    █ ▓█████ ▄▄▄        ▄████ ▓█████     ▒█████    ██████ " | tee -a "$log_file"
	echo "▓██▒    ▓██▒ ██ ▀█   █ ▓█   ▀▒████▄     ██▒ ▀█▒▓█   ▀    ▒██▒  ██▒▒██    ▒ " | tee -a "$log_file"
	echo "▒██░    ▒██▒▓██  ▀█ ██▒▒███  ▒██  ▀█▄  ▒██░▄▄▄░▒███      ▒██░  ██▒░ ▓██▄   " | tee -a "$log_file"
	echo "▒██░    ░██░▓██▒  ▐▌██▒▒▓█  ▄░██▄▄▄▄██ ░▓█  ██▓▒▓█  ▄    ▒██   ██░  ▒   ██▒" | tee -a "$log_file"
	echo "░██████▒░██░▒██░   ▓██░░▒████▒▓█   ▓██▒░▒▓███▀▒░▒████▒   ░ ████▓▒░▒██████▒▒" | tee -a "$log_file"
	echo "░ ▒░▓  ░░▓  ░ ▒░   ▒ ▒ ░░ ▒░ ░▒▒   ▓▒█░ ░▒   ▒ ░░ ▒░ ░   ░ ▒░▒░▒░ ▒ ▒▓▒ ▒ ░" | tee -a "$log_file"
	echo "░ ░ ▒  ░ ▒ ░░ ░░   ░ ▒░ ░ ░  ░ ▒   ▒▒ ░  ░   ░  ░ ░  ░     ░ ▒ ▒░ ░ ░▒  ░ ░" | tee -a "$log_file"
	echo "  ░ ░    ▒ ░   ░   ░ ░    ░    ░   ▒   ░ ░   ░    ░      ░ ░ ░ ▒  ░  ░  ░  " | tee -a "$log_file"
	echo "    ░  ░ ░           ░    ░  ░     ░  ░      ░    ░  ░       ░ ░        ░  " | tee -a "$log_file"
    echo
    echo "                             dev-harsh1998                              " | tee -a "$log_file"
    echo "Script By, @ArKT_7"                                                       | tee -a "$log_file"
}


# Define the download link and file names
platform_tools_url="https://dl.google.com/android/repository/platform-tools-latest-linux.zip"
platform_tools_zip="bin/platform-tools.zip"
extract_folder="bin/linux/"

# Function to download platform tools
download_platform_tools() {
    echo
    echo "Attempting to download platform tools..."

    # First, try using wget
    if command -v wget &> /dev/null; then
        echo "Using wget to download platform tools..."
        if wget "$platform_tools_url" -O "$platform_tools_zip"; then
            echo "Download successful using wget."
        else
            echo "wget failed. Trying to download using curl..."
            curl -L "$platform_tools_url" -o "$platform_tools_zip" || echo "curl download failed."
        fi
    else
        echo "wget is not installed. Trying to download using curl..."
        curl -L "$platform_tools_url" -o "$platform_tools_zip" || echo "curl download failed."
    fi

    # Extract the downloaded zip file
    if [ -d "$extract_folder" ]; then
        echo "Removing existing platform-tools directory..."
        rm -rf "$extract_folder"
    fi
    echo "Extracting platform tools..."
    mkdir -p "$extract_folder"
    unzip -q "$platform_tools_zip" -d "$extract_folder"
    rm "$platform_tools_zip"
}

print_lineageOS_ascii

read -p "Do you want to download dependencies? (y/n): " answer
case "$answer" in
    [Yy]* ) download_platform_tools ;;
    [Nn]* ) echo "Skipping download of platform tools." ;;
    * ) echo "Skipping download of platform tools." ;;
esac


fastboot="bin/linux/platform-tools/fastboot"

chmod -R +x bin/linux/

log_file="logs/install_log_$(date +'%Y-%m-%d_%H-%M-%S').txt"

if [ ! -f "$fastboot" ]; then
    echo
    echo "$fastboot not found." | tee -a "$log_file"
	echo
	echo "let's proceed with downloading." | tee -a "$log_file"
    download_platform_tools ;
	chmod -R +x bin/linux/
	chmod +x "$fastboot"
fi
echo
echo "Waiting for device..." | tee -a "$log_file"
device=$($fastboot getvar product 2>&1 | grep -oP '(?<=product: )\S+' | tee -a "$log_file")

if [ "$device" != "nabu" ]; then
	echo
    echo "Compatible devices: nabu" | tee -a "$log_file"
    echo "Your device: $device" | tee -a "$log_file"
	echo
    echo "Please connect your Xiaomi Pad 5 - Nabu" | tee -a "$log_file"
	echo
    read -n 1 -s -r -p "Press any key to exit..."
    exit 1
fi

clear    

print_log_lineageOS_ascii

echo
echo "You are going to wipe your data and internal storage." | tee -a "$log_file"
echo "It will delete all your files and photos stored on internal storage." | tee -a "$log_file"
echo
read -p "Do you agree? (Y/N) " choice
if [[ ! "$choice" =~ ^[Yy]$ ]]; then
    exit 0
fi


while true; do
    echo
    echo "Choose installation method:" | tee -a "$log_file"
    echo
    echo "1. With root (KSU - Kernel SU)" | tee -a "$log_file"
    echo "2. With root (Magisk 28 and KSU)" | tee -a "$log_file"
    echo
    read -p "Enter option (1, or 2): " install_choice
    install_choice=$(echo "$install_choice" | xargs) # Strip whitespace

    if [[ ! "$install_choice" =~ ^[1-2]$ ]]; then
	    echo
        echo "Invalid option. Please try again." | tee -a "$log_file"
        continue
    fi

    case $install_choice in
        1)
            clear    
			
            print_lineageOS_ascii

            echo "##################################################################"
            echo "Please wait. The device will reboot when installation is finished."
            echo "##################################################################"
            $fastboot set_active a |& tee -a "$log_file"
			echo
            echo "flashing ksu_dtbo" | tee -a "$log_file"
            $fastboot flash dtbo_ab images/dtbo.img |& tee -a "$log_file"
			echo
            echo "flashing vbmeta" | tee -a "$log_file"
            $fastboot flash vbmeta_ab images/vbmeta.img |& tee -a "$log_file"
			echo
            echo "flashing vbmeta_system" | tee -a "$log_file"
            $fastboot flash vbmeta_system_ab images/vbmeta_system.img |& tee -a "$log_file"
			echo
            echo "flashing ksu_boot" | tee -a "$log_file"
            $fastboot flash boot_ab images/boot.img |& tee -a "$log_file"
            break
            ;;
        2)
            clear    
			
            print_lineageOS_ascii

            echo "##################################################################"
            echo "Please wait. The device will reboot when installation is finished."
            echo "##################################################################"
            $fastboot set_active a |& tee -a "$log_file"
			echo
            echo "flashing dtbo" | tee -a "$log_file"
            $fastboot flash dtbo_ab images/dtbo.img |& tee -a "$log_file"
			echo
            echo "flashing vbmeta" | tee -a "$log_file"
            $fastboot flash vbmeta_ab images/vbmeta.img |& tee -a "$log_file"
			echo
            echo "flashing vbmeta_system" | tee -a "$log_file"
            $fastboot flash vbmeta_system_ab images/vbmeta_system.img |& tee -a "$log_file"
			echo
            echo "flashing magisk_boot" | tee -a "$log_file"
            $fastboot flash boot_ab images/magisk_boot.img |& tee -a "$log_file"
            break
            ;;
    esac
done

clear    

print_lineageOS_ascii

echo "##################################################################"
echo "Please wait. The device will reboot when installation is finished."
echo "##################################################################"
echo
echo
echo "flashing vendor_boot" | tee -a "$log_file"
$fastboot flash vendor_boot_ab images/vendor_boot.img |& tee -a "$log_file"
echo
echo "flashing super" | tee -a "$log_file"
$fastboot flash super images/super.img |& tee -a "$log_file"
echo
echo "erasing metadata" | tee -a "$log_file"
$fastboot erase metadata | tee -a "$log_file"
echo
echo "flashing userdata" | tee -a "$log_file"
$fastboot flash userdata images/userdata.img |& tee -a "$log_file"
echo
echo "erasing userdata" | tee -a "$log_file"
$fastboot erase userdata | tee -a "$log_file"
$fastboot erase frp | tee -a "$log_file"
echo
$fastboot reboot |& tee -a "$log_file"
echo

print_log_lineageOS_ascii

echo
echo "Installation is complete! Your device has rebooted successfully." | tee -a "$log_file"
read -n 1 -s -r -p "Press any key to close this window..."
