@echo off&setlocal enabledelayedexpansion
title BrickOS Flasher
cd %~dp0
set fastboot=META-INF\fastboot
set /p DeviceCodeRom=<META-INF\Data\DeviceCode
echo BRICKOS ROM FLASHER 
echo ==========================================================================================
echo.[i] - Press any key to start the installation.
echo.[i] - Else, exit this window.
pause >NUL 2>NUL
echo.=========================================================================================
echo. Please Choose Format Option Before Flash ROM
echo.
echo.   y = Format All Data(Clean Flash)         
echo.   n = Keep Data And Document(Dirty Flash)
echo.
echo.=========================================================================================
set /p CHOICE="Your choice {y/n}: "
echo.=========================================================================================
echo.Make Sure Your Devices Is On Fastboot Mode
echo.If It Still Not Detect Please Install Driver
echo.And Try Again...
echo.=========================================================================================

for /f "tokens=2" %%a in ('!fastboot! getvar product 2^>^&1 ^| findstr /l /b /c:"product:"') do set DeviceCodeReal=%%a
for /f "tokens=2" %%a in ('!fastboot! getvar slot-count 2^>^&1 ^| findstr /l /b /c:"slot-count:"') do set fqlx=%%a
if "!fqlx!" == "2" (set fqlx=AB)  else (set fqlx=A)

if "!DeviceCodeReal!" == "mars" set DeviceCodeReal=star

echo !DeviceCodeReal! | findstr /b /c:"!DeviceCodeRom!"  >nul 2>nul 

if errorlevel 1 (
    title Device Code Mismatch! & echo. Device codename does not match, your device is "!DeviceCodeReal!". This rom file is for "!DeviceCodeRom!". & pause & exit /B 1
)

for /f %%i in ('dir /b *.img.zst') do (
 	set par=%%i
 	set par=!par:.img.zst=!
 	del /s /q !par!.img >nul 2>nul 
 	echo.  Extract !par! ...
   	META-INF\zstd -d !par!.img.zst -o !par!.img
)

if /I "%CHOICE%" == "y" (
	echo.  Formatting...
	!fastboot! erase frp  >NUL 2>NUL
	!fastboot! erase userdata  >NUL 2>NUL
        !fastboot! erase metadata  >NUL 2>NUL
	echo.
)


for /f %%i in ('dir /b images') do (
	set par=%%~ni
	set url=images\%%i
	if !par! == cust ( 
		!fastboot! flash !par! !url!  >nul 2>nul 
	) else if !par! == preloader_raw (
		!fastboot! flash preloader_a !url! >nul 2>nul 
		!fastboot! flash preloader_b !url! >nul 2>nul 
		!fastboot! flash preloader1 !url! >nul 2>nul 
		!fastboot! flash preloader2 !url! >nul 2>nul 
	) else if !fqlx! == AB ( 
		!fastboot! flash !par!_a !url!
		!fastboot! flash !par!_b !url!
	) else ( 
		!fastboot! flash !par! !url!
	)
)

if exist super.img (
        !fastboot! flash super super.img
        del /s /q super.img >nul 2>nul 
)

if !fqlx! == AB (!fastboot! set_active a  >NUL 2>NUL)
!fastboot! reboot 


echo.  All done,Your Devices Is Automatic Restart...
echo.  
echo.

pause
exit
