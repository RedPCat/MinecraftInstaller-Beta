@echo off

::Borrowed from @RedPCat's scripts
for /f "tokens=6 delims=[]. " %%i in ('ver') do set build=%%i

if %build% LSS 21390 (
    echo ==========================================================================
    echo This script is compatible only with Windows 11 Insider Build 2 and later.
    echo ==========================================================================
    echo.
    pause
    goto :EOF
)

REG QUERY HKU\S-1-5-19\Environment >NUL 2>&1
IF %ERRORLEVEL% EQU 0 goto :START_SCRIPT

echo =====================================================================================
echo This script needs to be executed as an admin. Please relaunch in a Admin Environment.
echo =====================================================================================
echo.
pause
goto :EOF

if %build% LSS 21996 (
    echo ===============================================================================
    echo WARNING! THIS IS A TESTING SCRIPT! IT IS NOT RECOMMENDED IN WINDOWS 11 BUILD 1
    echo ===============================================================================
    echo.
    echo Pirating is not tolerated, this is a unofficial way of downloading the Minecraft Launcher without going to Minecraft.net.
    echo Please don't modifiy the code and redisturbute it. THIS was built off of the OfflineInsiderRoll command line.
    echo Press any key to ignore the warning.
    pause
    goto :START_SCRIPT
)

:START_SCRIPT
set "scriptver=0.2.1"
set "FlightSigningEnabled=0"
bcdedit /enum {current} | findstr /I /R /C:"^flightsigning *Yes$" >NUL 2>&1
IF %ERRORLEVEL% EQU 0 set "FlightSigningEnabled=1"

:CHOICE_MENU
cls
set "choice="
echo Minecraft Launcher Installer Beta v%scriptver%
echo.
echo 1 - Install Minecraft
echo 2 - Uninstall Minecraft
echo 3 - Read Warnings
echo.
echo 4 - Install Labymod 1.16.5 (Non-functional)
echo 5 - Quit without making any changes
echo.
set /p choice="Choice: "
echo.
if /I "%choice%"=="1" goto :INSTALL_LAUNCHER
if /I "%choice%"=="2" goto :UNINSTALL_LAUNCHER
if /I "%choice%"=="3" goto :WARNINGS
if /I "%choice%"=="4" goto :CHOICE_MENU
if /I "%choice%"=="5" goto :EOF
goto :CHOICE_MENU

:INSTALL_LAUNCHER
winget install minecraft && (
  echo Installation was successful.
) || (
  echo An error occurred. Installation was unsuccessful. Error code: CREEPER
)
echo If you have gotten a error from winget, contact Microsoft. If winget broke and the code shows CREEPER, go to RedcatPhoenix2/MinecraftInstaller-Beta on Github.
echo.
pause
goto :EOF

:ERROR
ECHO "An ERROR has occurred."
ECHO "Proceed with error handling or cleanup."
pause
goto :EOF

:UNINSTALL_LAUNCHER
echo Working on it...
winget uninstall minecraft && (
  echo Uninstallation was successful.
) || (
  echo Something happened and our builders are fixing it! The installer crashed due to a known bug! >> log.txt && goto :UNINSTALL_FIX
)
echo If the installer breaks, contact RedPCat#9665 on Discord.
echo.
pause
goto :EOF

:WARNINGS
echo ---------------------------------------------------------------------------------------
echo Piracy is not tolerated by Mojang. Please don't pirate.
echo Minecraft is owned by Mojang and Microsoft. It is fair if this script gets taken down.
echo This was made for Windows 11. Windows 10 version will NOT be made.
echo ---------------------------------------------------------------------------------------
echo THIS SCRIPT WAS MADE BY REDPCAT AND BUILT OFF OF OFFLINEINSIDERENROLL
echo Uses Windows Package Manager (WinGet) to work.
echo Errors are bound to happen as this is a beta.
echo.
pause
goto :CHOICE_MENU

:EOF
echo Thanks for using the Unofficial Minecraft Launcher installer!
echo Come back later!
echo.
timeout 10
exit

:UNINSTALL_FIX
echo Oh noes! Something happened and made it go into UNINSTALL_FIX mode! This is a temporary fix to the crashes going on with Uninstall Launcher.
echo.
pause
winget uninstall minecraft
echo Uninstallation was a success
echo.
pause
goto :EOF