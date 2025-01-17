@echo off
setlocal enabledelayedexpansion
title LineageOS Auto Installer 2.0
cd %~dp0

echo.
echo.
echo db      d888888b d8b   db d88888b  .d8b.   d888b  d88888b       .d88b.  .d8888. 
echo 88        `88'   888o  88 88'     d8' `8b 88' Y8b 88'          .8P  Y8. 88'  YP 
echo 88         88    88V8o 88 88ooooo 88ooo88 88      88ooooo      88    88 `8bo.   
echo 88         88    88 V8o88 88~~~~~ 88~~~88 88  ooo 88~~~~~      88    88   `Y8b. 
echo 88booo.   .88.   88  V888 88.     88   88 88. ~8~ 88.          `8b  d8' db   8D 
echo Y88888P Y888888P VP   V8P Y88888P YP   YP  Y888P  Y88888P       `Y88P'  `8888Y' 
echo. 
echo rom by dev-harsh1998
echo.
echo Flasher by @ArKT_7
echo.

rem Enable ANSI escape codes for colors
rem The ESC character is represented by 0x1B in the batch script
for /f %%a in ('echo prompt $E ^| cmd') do set "ESC=%%a"

rem Define color codes
set RED=%ESC%[91m
set YELLOW=%ESC%[93m
set GREEN=%ESC%[92m
set RESET=%ESC%[0m

rem Define required files in the 'images' folder
set required_files=boot.img dtbo.img magisk_boot.img super.img userdata.img vbmeta.img vbmeta_system.img vendor_boot.img

rem Check if the 'images' folder exists
if not exist "images" (
    echo %RED%ERROR! Please extract the zip again. 'images' folder is missing.%RESET%
	echo.
    echo %YELLOW%Press any key to exit...%RESET%
    pause > nul
    exit /b
)

rem Initialize variables
set missing=false
set missing_files=

rem Check for specific files dynamically
for %%f in (%required_files%) do (
    if not exist "images\%%f" (
        echo %YELLOW%Missing: %%f%RESET%
        set missing=true
        set missing_files=!missing_files! %%f
    )
)

rem If any files are missing, exit with a message
if "!missing!"=="true" (
	echo.
    echo %RED%Missing files: !missing_files!%RESET%
	echo.
	echo %RED%ERROR! Please extract the zip again. One or more required files are missing in the 'images' folder.%RESET%
	echo.
    echo %YELLOW%Press any key to exit...%RESET%
    pause > nul
    exit /b
)


if not exist "logs" (
    rem echo 'logs' folder does not exist. Creating it...
    mkdir "logs"
)

if not exist "bin" (
    rem echo 'bin' folder does not exist. Creating it...
    mkdir "bin"
)

if not exist "bin\windows" (
    rem echo 'windows' folder does not exist. Creating it...
    mkdir "bin\windows"
)

:: Check if the 'linux' directory exists inside 'bin'
rem if not exist "bin\linux" (
    rem echo 'linux' folder does not exist. Creating it...
    rem mkdir "bin\linux"
rem )

set "download_platform_tools_url=https://dl.google.com/android/repository/platform-tools-latest-windows.zip"
set "platform_tools_zip=bin\windows\platform-tools.zip"
set "extract_folder=bin\windows"
set "download_tee_url=https://github.com/dEajL3kA/tee-win32/releases/download/1.3.3/tee-win32.2023-11-27.zip"
set "tee_zip=bin\windows\tee-win32.2023-11-27.zip"
set "tee_extract_folder=bin\windows\log-tool"
set "check_flag=bin\download.flag"

cls
echo.
echo.
echo db      d888888b d8b   db d88888b  .d8b.   d888b  d88888b       .d88b.  .d8888. 
echo 88        `88'   888o  88 88'     d8' `8b 88' Y8b 88'          .8P  Y8. 88'  YP 
echo 88         88    88V8o 88 88ooooo 88ooo88 88      88ooooo      88    88 `8bo.   
echo 88         88    88 V8o88 88~~~~~ 88~~~88 88  ooo 88~~~~~      88    88   `Y8b. 
echo 88booo.   .88.   88  V888 88.     88   88 88. ~8~ 88.          `8b  d8' db   8D 
echo Y88888P Y888888P VP   V8P Y88888P YP   YP  Y888P  Y88888P       `Y88P'  `8888Y' 
echo. 
echo rom by dev-harsh1998
echo.
echo Flasher by @ArKT_7
echo.

if not exist "%check_flag%" (
    goto download_ask
) else ( 
    goto re_download_ask 
)

:re_download_ask
call :get_input "%YELLOW%Do you want to download dependencies again (Y) or %GREEN%continue (C)? %RESET%" download_choice

if /i "%download_choice%"=="y" (
    call :download_dependencies
) else if /i "%download_choice%"=="c" (
    echo %YELLOW%Continuing without downloading dependencies...%RESET%
	goto start
) else (
    echo.
    echo %RED%Invalid choice.%RESET% %YELLOW%Please enter 'Y' to download or 'C' to continue.%RESET%
    goto re_download_ask
)

:download_ask
call :get_input "%YELLOW%Do you want to download dependencies online or %GREEN%continue? %YELLOW%(Y/C)%RESET%: " download_choice

if /i "%download_choice%"=="y" (
    call :download_dependencies
) else if /i "%download_choice%"=="c" (
    echo %YELLOW%Continuing without downloading dependencies...%RESET%
	goto start
) else (
    echo.
    echo %RED%Invalid choice.%RESET% %YELLOW%Please enter 'Y' to download or 'C' to continue.%RESET%
    goto download_ask
)

:get_input
setlocal
set /p input=%~1
if "%input%"=="" (
    goto start
    goto :get_input
) else if /i not "%input%"=="y" if /i not "%input%"=="c" (
    echo %RED%Invalid choice.%RESET% %YELLOW%Please enter 'Y' to download or 'C' to continue.%RESET%
    goto :get_input
)
endlocal & set "%~2=%input%"
exit /b

:download_dependencies
(
    echo.
    echo %YELLOW%Downloading platform-tools...%RESET%
	timeout /t 2 /nobreak >nul
    curl -L "%download_platform_tools_url%" -o "%platform_tools_zip%"
    if %errorlevel% neq 0 (
	    echo.
        echo %RED%curl failed to download.%RESET% %YELLOW%Trying with again...%RESET%
		echo.
        if exist "%platform_tools_zip%" del "%platform_tools_zip%"
		timeout /t 2 /nobreak >nul
        curl -L "%download_platform_tools_url%" -o "%platform_tools_zip%"
    )
	
    if exist "%platform_tools_zip%" (
	    echo.
        echo Extracting platform-tools...
        mkdir "%extract_folder%"
		timeout /t 2 /nobreak >nul
        tar -xf "%platform_tools_zip%" -C "%extract_folder%"
        del "%platform_tools_zip%"
        echo %GREEN%Platform-tools downloaded and extracted successfully.%RESET%
    ) else (
	    echo.
        echo %YELLOW%Platform-tools could not be downloaded. press any key to continue.%RESET%
        pause
        pause >nul
    )
	
	echo.
	echo %YELLOW%Downloading tee-log-tool...%RESET%
	timeout /t 2 /nobreak >nul
    curl -L "%download_tee_url%" -o "%tee_zip%"
    if %errorlevel% neq 0 (
	    echo.
        echo %RED%curl failed to download.%RESET% %YELLOW%Trying with again...%RESET%
		echo.
        if exist "%tee_zip%" del "%tee_zip%"
		timeout /t 2 /nobreak >nul
        curl -L "%download_tee_url%" -o "%tee_zip%"
    )

    if exist "%tee_zip%" (
		echo.
        echo Extracting tee...
        mkdir "%tee_extract_folder%"
		timeout /t 2 /nobreak >nul
        tar -xf "%tee_zip%" -C "%tee_extract_folder%"
        del "%tee_zip%"
        echo %GREEN%tee downloaded and extracted successfully.%RESET%
    ) else (
		echo.
        echo %YELLOW%tee could not be downloaded. press any key to continue.%RESET%
        pause >nul
    )
	echo download flag. > "%check_flag%"
)

:start
set "fastboot=bin\windows\platform-tools\fastboot.exe"
set "tee=bin\windows\log-tool\tee-x86.exe"
if /I "%PROCESSOR_ARCHITECTURE%"=="AMD64" (
    set "tee=bin\windows\log-tool\tee-x64.exe"
) else if /I "%PROCESSOR_ARCHITECTURE%"=="ARM64" (
    set "tee=bin\windows\log-tool\tee-a64.exe"
) else if /I "%PROCESSOR_ARCHITECTURE%"=="x86" (
    set "tee=bin\windows\log-tool\tee-x86.exe"
)

if not exist "%fastboot%" (
    echo %RED%%fastboot% not found.%RESET%
	echo.
	echo let's proceed with downloading.
    call :download_dependencies
)

if not exist "%tee%" (
    echo %RED%%tee% not found.%RESET%
	echo.
	echo let's proceed with downloading.
    call :download_dependencies
)

set "log_file=logs\install_log_%date:/=-%_%time::=-%.txt"

:: Create log file with timestamp in the name
echo. > "%log_file%"

:: Rest of the script continues...

cls
echo.   
echo.
call :log  "db      d888888b d8b   db d88888b  .d8b.   d888b  d88888b       .d88b.  .d8888. "
call :log  "88        `88'   888o  88 88'     d8' `8b 88' Y8b 88'          .8P  Y8. 88'  YP "
call :log  "88         88    88V8o 88 88ooooo 88ooo88 88      88ooooo      88    88 `8bo.   "
call :log  "88         88    88 V8o88 88~~~~~ 88~~~88 88  ooo 88~~~~~      88    88   `Y8b. "
call :log  "88booo.   .88.   88  V888 88.     88   88 88. ~8~ 88.          `8b  d8' db   8D "
call :log  "Y88888P Y888888P VP   V8P Y88888P YP   YP  Y888P  Y88888P       `Y88P'  `8888Y' "
echo. 
call :log  " rom by dev-harsh1998"
echo.
call :log  " Flasher by @ArKT_7"
echo.
call :log "%YELLOW%Waiting for device...%RESET%"
set device=unknown
for /f "tokens=2" %%D in ('%fastboot% getvar product 2^>^&1 ^| findstr /l /b /c:"product:"') do set device=%%D
if "%device%" neq "nabu" (
    echo.
    call :log "%YELLOW%Compatible devices: nabu%RESET%"
    call :log "%RED%Your device: %device%%RESET%"
	echo.
    call :log "%YELLOW%Please connect your Xiaomi Pad 5 - Nabu%RESET%"
	echo.
    pause
    exit /B 1
)

cls
echo.
echo.
echo db      d888888b d8b   db d88888b  .d8b.   d888b  d88888b       .d88b.  .d8888. 
echo 88        `88'   888o  88 88'     d8' `8b 88' Y8b 88'          .8P  Y8. 88'  YP 
echo 88         88    88V8o 88 88ooooo 88ooo88 88      88ooooo      88    88 `8bo.   
echo 88         88    88 V8o88 88~~~~~ 88~~~88 88  ooo 88~~~~~      88    88   `Y8b. 
echo 88booo.   .88.   88  V888 88.     88   88 88. ~8~ 88.          `8b  d8' db   8D 
echo Y88888P Y888888P VP   V8P Y88888P YP   YP  Y888P  Y88888P       `Y88P'  `8888Y' 
echo. 
echo rom by dev-harsh1998
echo.
echo Flasher by @ArKT_7
echo.
call :log "%GREEN%Device detected. Proceeding with installation...%RESET%"
echo.

:choose_method
call :log "%YELLOW%Choose installation method:%RESET%"
echo.
echo %YELLOW%1.%RESET% With root (KSU - Kernel SU)
echo %YELLOW%2.%RESET% With root (Magisk 28.1 and KSU)
echo.
set /p install_choice=%YELLOW%Enter option (1 or 2):%RESET% 

if "%install_choice%"=="1" goto install_ksu
if "%install_choice%"=="2" goto install_magisk
echo.
call :log "%RED%Invalid option. %YELLOW%Please try again.%RESET%"
echo.
goto choose_method


:install_ksu
cls
echo.
echo.
echo db      d888888b d8b   db d88888b  .d8b.   d888b  d88888b       .d88b.  .d8888. 
echo 88        `88'   888o  88 88'     d8' `8b 88' Y8b 88'          .8P  Y8. 88'  YP 
echo 88         88    88V8o 88 88ooooo 88ooo88 88      88ooooo      88    88 `8bo.   
echo 88         88    88 V8o88 88~~~~~ 88~~~88 88  ooo 88~~~~~      88    88   `Y8b. 
echo 88booo.   .88.   88  V888 88.     88   88 88. ~8~ 88.          `8b  d8' db   8D 
echo Y88888P Y888888P VP   V8P Y88888P YP   YP  Y888P  Y88888P       `Y88P'  `8888Y' 
echo. 
echo rom by dev-harsh1998
echo.
echo Flasher by @ArKT_7
echo.
echo ######################################################################
echo %YELLOW%  WARNING: Do not click on this window, as it will pause the process%RESET%
echo %YELLOW%  Please wait, Device will auto reboot when installation is finished.%RESET%
echo ######################################################################
echo.
call :log "%YELLOW%Starting installation with KSU...%RESET%"
%fastboot% set_active a 2>&1 | %tee% -a "%log_file%"
echo.
call :log "%YELLOW%Flashing ksu_dtbo%RESET%"
%fastboot% flash dtbo_a images\dtbo.img 2>&1 | %tee% -a "%log_file%"
%fastboot% flash dtbo_b images\dtbo.img 2>&1 | %tee% -a "%log_file%"
echo.
call :log "%YELLOW%Flashing vbmeta%RESET%"
%fastboot% flash vbmeta_a images\vbmeta.img 2>&1 | %tee% -a "%log_file%"
%fastboot% flash vbmeta_b images\vbmeta.img 2>&1 | %tee% -a "%log_file%"
echo.
call :log "%YELLOW%Flashing vbmeta_system%RESET%"
%fastboot% flash vbmeta_system_a images\vbmeta_system.img 2>&1 | %tee% -a "%log_file%"
%fastboot% flash vbmeta_system_b images\vbmeta_system.img 2>&1 | %tee% -a "%log_file%"
echo.
call :log "%YELLOW%Flashing ksu_boot%RESET%"
%fastboot% flash boot_a images\boot.img 2>&1 | %tee% -a "%log_file%"
%fastboot% flash boot_b images\boot.img 2>&1 | %tee% -a "%log_file%"
goto common_flash

:install_magisk
cls
echo.
echo.
echo db      d888888b d8b   db d88888b  .d8b.   d888b  d88888b       .d88b.  .d8888. 
echo 88        `88'   888o  88 88'     d8' `8b 88' Y8b 88'          .8P  Y8. 88'  YP 
echo 88         88    88V8o 88 88ooooo 88ooo88 88      88ooooo      88    88 `8bo.   
echo 88         88    88 V8o88 88~~~~~ 88~~~88 88  ooo 88~~~~~      88    88   `Y8b. 
echo 88booo.   .88.   88  V888 88.     88   88 88. ~8~ 88.          `8b  d8' db   8D 
echo Y88888P Y888888P VP   V8P Y88888P YP   YP  Y888P  Y88888P       `Y88P'  `8888Y' 
echo. 
echo rom by dev-harsh1998
echo.
echo Flasher by @ArKT_7
echo.
echo ######################################################################
echo %YELLOW%  WARNING: Do not click on this window, as it will pause the process%RESET%
echo %YELLOW%  Please wait, Device will auto reboot when installation is finished.%RESET%
echo ######################################################################
echo.
call :log "%YELLOW%Starting installation with Magisk...%RESET%"
%fastboot% set_active a 2>&1 | %tee% -a "%log_file%"
echo.
call :log "%YELLOW%Flashing dtbo%RESET%"
%fastboot% flash dtbo_a images\dtbo.img 2>&1 | %tee% -a "%log_file%"
%fastboot% flash dtbo_b images\dtbo.img 2>&1 | %tee% -a "%log_file%"
echo.
call :log "%YELLOW%Flashing vbmeta%RESET%"
%fastboot% flash vbmeta_a images\vbmeta.img 2>&1 | %tee% -a "%log_file%"
%fastboot% flash vbmeta_b images\vbmeta.img 2>&1 | %tee% -a "%log_file%"
echo.
call :log "%YELLOW%Flashing vbmeta_system%RESET%"
%fastboot% flash vbmeta_system_a images\vbmeta_system.img 2>&1 | %tee% -a "%log_file%"
%fastboot% flash vbmeta_system_b images\vbmeta_system.img 2>&1 | %tee% -a "%log_file%"
echo.
call :log "%YELLOW%Flashing magisk_boot%RESET%"
%fastboot% flash boot_a images\magisk_boot.img 2>&1 | %tee% -a "%log_file%"
%fastboot% flash boot_b images\magisk_boot.img 2>&1 | %tee% -a "%log_file%"
goto common_flash

:common_flash
cls
echo.
echo.
echo db      d888888b d8b   db d88888b  .d8b.   d888b  d88888b       .d88b.  .d8888. 
echo 88        `88'   888o  88 88'     d8' `8b 88' Y8b 88'          .8P  Y8. 88'  YP 
echo 88         88    88V8o 88 88ooooo 88ooo88 88      88ooooo      88    88 `8bo.   
echo 88         88    88 V8o88 88~~~~~ 88~~~88 88  ooo 88~~~~~      88    88   `Y8b. 
echo 88booo.   .88.   88  V888 88.     88   88 88. ~8~ 88.          `8b  d8' db   8D 
echo Y88888P Y888888P VP   V8P Y88888P YP   YP  Y888P  Y88888P       `Y88P'  `8888Y' 
echo. 
echo rom by dev-harsh1998
echo.
echo Flasher by @ArKT_7
echo.
echo ######################################################################
echo %YELLOW%  WARNING: Do not click on this window, as it will pause the process%RESET%
echo %YELLOW%  Please wait, Device will auto reboot when installation is finished.%RESET%
echo ######################################################################

echo.
call :log "%YELLOW%Flashing vendor_boot%RESET%"
%fastboot% flash vendor_boot_a images\vendor_boot.img 2>&1 | %tee% -a "%log_file%"
%fastboot% flash vendor_boot_b images\vendor_boot.img 2>&1 | %tee% -a "%log_file%"
cls
echo.
echo.
echo db      d888888b d8b   db d88888b  .d8b.   d888b  d88888b       .d88b.  .d8888. 
echo 88        `88'   888o  88 88'     d8' `8b 88' Y8b 88'          .8P  Y8. 88'  YP 
echo 88         88    88V8o 88 88ooooo 88ooo88 88      88ooooo      88    88 `8bo.   
echo 88         88    88 V8o88 88~~~~~ 88~~~88 88  ooo 88~~~~~      88    88   `Y8b. 
echo 88booo.   .88.   88  V888 88.     88   88 88. ~8~ 88.          `8b  d8' db   8D 
echo Y88888P Y888888P VP   V8P Y88888P YP   YP  Y888P  Y88888P       `Y88P'  `8888Y' 
echo. 
echo rom by dev-harsh1998
echo.
echo Flasher by @ArKT_7
echo.
echo ######################################################################
echo %YELLOW%  WARNING: Do not click on this window, as it will pause the process%RESET%
echo %YELLOW%  Please wait, Device will auto reboot when installation is finished.%RESET%
echo ######################################################################
echo.
call :log "%YELLOW%Flashing super%RESET%"
%fastboot% flash super images\super.img 2>&1 | %tee% -a "%log_file%"
echo.
%fastboot% reboot 2>&1 | %tee% -a "%log_file%"
goto finished

:finished
echo.   
echo.
call :log  "db      d888888b d8b   db d88888b  .d8b.   d888b  d88888b       .d88b.  .d8888. "
call :log  "88        `88'   888o  88 88'     d8' `8b 88' Y8b 88'          .8P  Y8. 88'  YP "
call :log  "88         88    88V8o 88 88ooooo 88ooo88 88      88ooooo      88    88 `8bo.   "
call :log  "88         88    88 V8o88 88~~~~~ 88~~~88 88  ooo 88~~~~~      88    88   `Y8b. "
call :log  "88booo.   .88.   88  V888 88.     88   88 88. ~8~ 88.          `8b  d8' db   8D "
call :log  "Y88888P Y888888P VP   V8P Y88888P YP   YP  Y888P  Y88888P       `Y88P'  `8888Y' "
echo. 
call :log  " rom by dev-harsh1998"
echo.
call :log  " Flasher by @ArKT_7"
echo.
echo.
call :log "%GREEN%Installation is complete! Your device has rebooted successfully.%RESET%"
echo.
set /p "=%YELLOW%Press any key to exit%RESET%" <nul
pause >nul
exit

:log
echo %~1 | %tee% -a "%log_file%"
goto :eof
