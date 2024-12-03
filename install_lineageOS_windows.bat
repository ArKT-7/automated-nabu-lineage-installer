@echo off
cd %~dp0

set "base_dir=%~dp0"

if not exist "%base_dir%logs" (
    rem echo 'logs' folder does not exist. Creating it...
    mkdir "%base_dir%logs"
)

if not exist "%base_dir%bin" (
    rem echo 'bin' folder does not exist. Creating it...
    mkdir "%base_dir%bin"
)

if not exist "%base_dir%bin\windows" (
    rem echo 'windows' folder does not exist. Creating it...
    mkdir "%base_dir%bin\windows"
)

:: Check if the 'linux' directory exists inside 'bin'
rem if not exist "%base_dir%bin\linux" (
    rem echo 'linux' folder does not exist. Creating it...
    rem mkdir "%base_dir%bin\linux"
rem )

set "download_platform_tools_url=https://dl.google.com/android/repository/platform-tools-latest-windows.zip"
set "platform_tools_zip=%base_dir%bin\windows\platform-tools.zip"
set "extract_folder=%base_dir%bin\windows"
set "download_tee_url=https://github.com/dEajL3kA/tee-win32/releases/download/1.3.3/tee-win32.2023-11-27.zip"
set "tee_zip=%base_dir%bin\windows\tee-win32.2023-11-27.zip"
set "tee_extract_folder=%base_dir%bin\windows\log-tool"
set "check_flag=%base_dir%bin\download.flag"

echo.
echo ##       ######   ##   ##  #######    ##       ####   #######                            
echo ##         ##     ###  ##  ##         ##      ##  ##  ##                                 
echo ##         ##     ###  ##  ##        ####    ##       ##              #####    #####  
echo ##         ##     ## # ##  #####     ## #    ##       #####          ##   ##  ##      
echo ##         ##     ## # ##  ##       ######   ##  ###  ##             ##   ##   ####   
echo ##         ##     ##  ###  ##       ##   #    ##  ##  ##             ##   ##      ##  
echo ######   ######   ##   ##  ####### ###   ##    #####  #######         #####   #####                                                  
echo.
echo                               dev-harsh1998
echo Script By, @ArKT_7                                     
echo.

if not exist "%check_flag%" (
    goto download_ask
) else ( 
    goto re_download_ask 
)

:re_download_ask
call :get_input "Do you want to download dependencies again (Y) or continue (C)? " download_choice

if /i "%download_choice%"=="y" (
    call :download_dependencies
) else if /i "%download_choice%"=="c" (
    echo Continuing without downloading dependencies...
	goto start
) else (
    echo.
    echo Invalid choice. Please enter 'Y' to download or 'C' to continue.
    goto re_download_ask
)

:download_ask
call :get_input "Do you want to download dependencies online or continue? (Y/C): " download_choice

if /i "%download_choice%"=="y" (
    call :download_dependencies
) else if /i "%download_choice%"=="c" (
    echo Continuing without downloading dependencies...
	goto start
) else (
    echo.
    echo Invalid choice. Please enter 'Y' to download or 'C' to continue.
    goto download_ask
)

:get_input
setlocal
set /p input=%~1
if "%input%"=="" (
    goto start
    goto :get_input
) else if /i not "%input%"=="y" if /i not "%input%"=="c" (
    echo Invalid choice. Please enter 'Y' to download or 'C' to continue.
    goto :get_input
)
endlocal & set "%~2=%input%"
exit /b

:download_dependencies
(
    echo.
    echo Downloading platform-tools...
	timeout /t 2 /nobreak >nul
    curl -L "%download_platform_tools_url%" -o "%platform_tools_zip%"
    if %errorlevel% neq 0 (
	    echo.
        echo curl failed to download. Trying with again...
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
        echo Platform-tools downloaded and extracted successfully.
    ) else (
	    echo.
        echo Platform-tools could not be downloaded. press any key to continue.
        pause
        pause >nul
    )
	
	echo.
	echo Downloading tee-log-tool...
	timeout /t 2 /nobreak >nul
    curl -L "%download_tee_url%" -o "%tee_zip%"
    if %errorlevel% neq 0 (
	    echo.
        echo curl failed to download. Trying with again...
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
        echo tee downloaded and extracted successfully.
    ) else (
		echo.
        echo tee could not be downloaded. press any key to continue.
        pause >nul
    )
	echo download flag. > "%check_flag%"
)

:start
set "fastboot=%base_dir%\bin\windows\platform-tools\fastboot.exe"
set "tee=%base_dir%\bin\windows\log-tool\tee-x86.exe"
if /I "%PROCESSOR_ARCHITECTURE%"=="AMD64" (
    set "tee=%base_dir%\bin\windows\log-tool\tee-x64.exe"
) else if /I "%PROCESSOR_ARCHITECTURE%"=="ARM64" (
    set "tee=%base_dir%\bin\windows\log-tool\tee-a64.exe"
) else if /I "%PROCESSOR_ARCHITECTURE%"=="x86" (
    set "tee=%base_dir%\bin\windows\log-tool\tee-x86.exe"
)

if not exist "%fastboot%" (
    echo %fastboot% not found.
	echo.
	echo let's proceed with downloading.
    call :download_dependencies
)

if not exist "%tee%" (
    echo %tee% not found.
	echo.
	echo let's proceed with downloading.
    call :download_dependencies
)

set "log_file=%base_dir%\logs\install_log_%date:/=-%_%time::=-%.txt"

:: Create log file with timestamp in the name
echo. > "%log_file%"

:: Rest of the script continues...

cls
echo.
call :log "##       ######   ##   ##  #######    ##       ####   #######                        "          
call :log "##         ##     ###  ##  ##         ##      ##  ##  ##                             "     
call :log "##         ##     ###  ##  ##        ####    ##       ##              #####    ##### "  
call :log "##         ##     ## # ##  #####     ## #    ##       #####          ##   ##  ##     "  
call :log "##         ##     ## # ##  ##       ######   ##  ###  ##             ##   ##   ####  "  
call :log "##         ##     ##  ###  ##       ##   #    ##  ##  ##             ##   ##      ## "  
call :log "######   ######   ##   ##  ####### ###   ##    #####  #######         #####   #####  "                                                 
echo.
call :log "                              dev-harsh1998                                          "
call :log "Script By, @ArKT_7                                                                   "
echo.
echo.
call :log "Waiting for device..."
set device=unknown
for /f "tokens=2" %%D in ('%fastboot% getvar product 2^>^&1 ^| findstr /l /b /c:"product:"') do set device=%%D
if "%device%" neq "nabu" (
    echo.
    call :log "Compatible devices: nabu"
    call :log "Your device: %device%"
	echo.
    call :log "Please connect your Xiaomi Pad 5 - Nabu"
	echo.
    pause
    exit /B 1
)

cls
echo.
call :log "##       ######   ##   ##  #######    ##       ####   #######                        "          
call :log "##         ##     ###  ##  ##         ##      ##  ##  ##                             "     
call :log "##         ##     ###  ##  ##        ####    ##       ##              #####    ##### "  
call :log "##         ##     ## # ##  #####     ## #    ##       #####          ##   ##  ##     "  
call :log "##         ##     ## # ##  ##       ######   ##  ###  ##             ##   ##   ####  "  
call :log "##         ##     ##  ###  ##       ##   #    ##  ##  ##             ##   ##      ## "  
call :log "######   ######   ##   ##  ####### ###   ##    #####  #######         #####   #####  "                                                 
echo.
call :log "                              dev-harsh1998                                          "
call :log "Script By, @ArKT_7                               
echo.
call :log "Device detected. Proceeding with installation..."
echo.
call :log "You are going to wipe your data and internal storage."
call :log "It will delete all your files and photos stored on internal storage."
echo.
set /p choice=Do you agree? (Y/N) 
if /i "%choice%" neq "y" exit
echo.

:choose_method
call :log "Choose installation method:"
echo.
echo 1. With root (KSU - Kernel SU)
echo 2. With root (Magisk 28 and KSU)
echo.
set /p install_choice=Enter option (1 or 2): 

if "%install_choice%"=="1" goto install_ksu
if "%install_choice%"=="2" goto install_magisk
echo.
call :log "Invalid option. Please try again."
echo.
goto choose_method

:install_ksu
cls
echo.
echo ##       ######   ##   ##  #######    ##       ####   #######                            
echo ##         ##     ###  ##  ##         ##      ##  ##  ##                                 
echo ##         ##     ###  ##  ##        ####    ##       ##              #####    #####  
echo ##         ##     ## # ##  #####     ## #    ##       #####          ##   ##  ##      
echo ##         ##     ## # ##  ##       ######   ##  ###  ##             ##   ##   ####   
echo ##         ##     ##  ###  ##       ##   #    ##  ##  ##             ##   ##      ##  
echo ######   ######   ##   ##  ####### ###   ##    #####  #######         #####   #####                                                  
echo.
echo                               dev-harsh1998
echo Script By, @ArKT_7     
echo.
echo ##################################################################
echo Please wait. The device will reboot when installation is finished.
echo ##################################################################
echo.
call :log "Starting installation with KSU..."
%fastboot% set_active a 2>&1 | %tee% -a "%log_file%"
echo.
call :log "Flashing ksu_dtbo"
%fastboot% flash dtbo_ab images\dtbo.img 2>&1 | %tee% -a "%log_file%"
echo.
call :log "Flashing vbmeta"
%fastboot% flash vbmeta_ab images\vbmeta.img 2>&1 | %tee% -a "%log_file%"
echo.
call :log "Flashing vbmeta_system"
%fastboot% flash vbmeta_system_ab images\vbmeta_system.img 2>&1 | %tee% -a "%log_file%"
echo.
call :log "Flashing ksu_boot"
%fastboot% flash boot_ab images\boot.img 2>&1 | %tee% -a "%log_file%"
goto common_flash

:install_magisk
cls
echo.
echo ##       ######   ##   ##  #######    ##       ####   #######                            
echo ##         ##     ###  ##  ##         ##      ##  ##  ##                                 
echo ##         ##     ###  ##  ##        ####    ##       ##              #####    #####  
echo ##         ##     ## # ##  #####     ## #    ##       #####          ##   ##  ##      
echo ##         ##     ## # ##  ##       ######   ##  ###  ##             ##   ##   ####   
echo ##         ##     ##  ###  ##       ##   #    ##  ##  ##             ##   ##      ##  
echo ######   ######   ##   ##  ####### ###   ##    #####  #######         #####   #####                                                  
echo.
echo                               dev-harsh1998
echo Script By, @ArKT_7      
echo.
echo ##################################################################
echo Please wait. The device will reboot when installation is finished.
echo ##################################################################
echo.
call :log "Starting installation with Magisk..."
%fastboot% set_active a 2>&1 | %tee% -a "%log_file%"
echo.
call :log "Flashing dtbo"
%fastboot% flash dtbo_ab images\dtbo.img 2>&1 | %tee% -a "%log_file%"
echo.
call :log "Flashing vbmeta"
%fastboot% flash vbmeta_ab images\vbmeta.img 2>&1 | %tee% -a "%log_file%"
echo.
call :log "Flashing vbmeta_system"
%fastboot% flash vbmeta_system_ab images\vbmeta_system.img 2>&1 | %tee% -a "%log_file%"
echo.
call :log "Flashing magisk_boot"
%fastboot% flash boot_ab images\magisk_boot.img 2>&1 | %tee% -a "%log_file%"
goto common_flash

:common_flash
cls
echo.
echo.
echo ##       ######   ##   ##  #######    ##       ####   #######                            
echo ##         ##     ###  ##  ##         ##      ##  ##  ##                                 
echo ##         ##     ###  ##  ##        ####    ##       ##              #####    #####  
echo ##         ##     ## # ##  #####     ## #    ##       #####          ##   ##  ##      
echo ##         ##     ## # ##  ##       ######   ##  ###  ##             ##   ##   ####   
echo ##         ##     ##  ###  ##       ##   #    ##  ##  ##             ##   ##      ##  
echo ######   ######   ##   ##  ####### ###   ##    #####  #######         #####   #####                                                  
echo.
echo                               dev-harsh1998
echo Script By, @ArKT_7      
echo.
echo ##################################################################
echo Please wait. The device will reboot when installation is finished.
echo ##################################################################
echo.
call :log "Flashing vendor_boot"
%fastboot% flash vendor_boot_ab images\vendor_boot.img 2>&1 | %tee% -a "%log_file%"
cls
echo.
echo.
echo ##       ######   ##   ##  #######    ##       ####   #######                            
echo ##         ##     ###  ##  ##         ##      ##  ##  ##                                 
echo ##         ##     ###  ##  ##        ####    ##       ##              #####    #####  
echo ##         ##     ## # ##  #####     ## #    ##       #####          ##   ##  ##      
echo ##         ##     ## # ##  ##       ######   ##  ###  ##             ##   ##   ####   
echo ##         ##     ##  ###  ##       ##   #    ##  ##  ##             ##   ##      ##  
echo ######   ######   ##   ##  ####### ###   ##    #####  #######         #####   #####                                                  
echo.
echo                               dev-harsh1998
echo Script By, @ArKT_7      
echo.
echo ##################################################################
echo Please wait. The device will reboot when installation is finished.
echo ##################################################################
echo.
call :log "Flashing super"
%fastboot% flash super images\super.img 2>&1 | %tee% -a "%log_file%"
echo.
call :log "Erasing metadata"
%fastboot% erase metadata 2>&1 | %tee% -a "%log_file%"
echo.
call :log "Flashing userdata"
%fastboot% flash userdata images\userdata.img 2>&1 | %tee% -a "%log_file%"
echo.
call :log "Erasing userdata"
%fastboot% erase userdata 2>&1 | %tee% -a "%log_file%"
%fastboot% reboot 2>&1 | %tee% -a "%log_file%"
goto finished

:finished
echo.
echo.
echo.
echo ##       ######   ##   ##  #######    ##       ####   #######                            
echo ##         ##     ###  ##  ##         ##      ##  ##  ##                                 
echo ##         ##     ###  ##  ##        ####    ##       ##              #####    #####  
echo ##         ##     ## # ##  #####     ## #    ##       #####          ##   ##  ##      
echo ##         ##     ## # ##  ##       ######   ##  ###  ##             ##   ##   ####   
echo ##         ##     ##  ###  ##       ##   #    ##  ##  ##             ##   ##      ##  
echo ######   ######   ##   ##  ####### ###   ##    #####  #######         #####   #####                                                  
echo.
echo                               dev-harsh1998
echo Script By, @ArKT_7    
echo.
echo.
call :log "Installation is complete! Your device has rebooted successfully."
echo.
set /p "=Press any key to exit" <nul
pause >nul
exit

:log
echo %~1 | %tee% -a "%log_file%"
goto :eof
