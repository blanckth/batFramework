:: Blanck Batch Script Framework
:: Authur Salar Muhammadi
:: DevSecOps(DSO)
:: Starter
@ECHO off
SETLOCAL
PROMPT "Blanck>>
:: GET ADMINISTRATOR ACCESS
set "params=%*"
cd /d "%~dp0" && ( if exist "%temp%\getadmin.vbs" del "%temp%\getadmin.vbs" ) && fsutil dirty query %systemdrive% 1>nul 2>nul || (  echo Set UAC = CreateObject^("Shell.Application"^) : UAC.ShellExecute "cmd.exe", "/c cd ""%~sdp0"" && %~s0 %params%", "", "runas", 1 >> "%temp%\getadmin.vbs" && "%temp%\getadmin.vbs" && exit /B )
:: GET ADMINISTRATOR ACCESS
ENDLOCAL
ECHO --------------------------------- >> log.txt
ECHO Welcome To Blanck Administration! >> log.txt
ECHO Welcome To Blanck Administration!
TIMEOUT 2
IF exist config\ ( ECHO . ) ELSE ( MD config )
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:MAIN
SETLOCAL
SETLOCAL ENABLEDELAYEDEXPANSION
:: MAIN
CALL :MAINMENU
:: MAIN END
PAUSE
ECHO Goodbye! >> log.txt
if exist "%temp%\getadmin.vbs" del "%temp%\getadmin.vbs"
ENDLOCAL
EXIT /B %ERRORLEVEL%
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:: TOP BANNER FUNCTION
:tBanner
SETLOCAL
SETLOCAL ENABLEDELAYEDEXPANSION
CLS
ECHO ------------------------------
VER >> log.txt
VER
ECHO | SET /p="WORKDIR : "
CD >> log.txt
CD
ECHO | SET /p="ADMIN : "
WHOAMI >> log.txt
WHOAMI
ECHO %date% %time% >> log.txt
ECHO %date% %time%
ECHO ------------------------------
ECHO Blanck Batch Framework.
ECHO ------------------------------
ENDLOCAL
EXIT /B %ERRORLEVEL%
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:: MAIN MENU FUNCTION
:MAINMENU
SETLOCAL
SETLOCAL ENABLEDELAYEDEXPANSION
CALL :tBanner
ECHO ------------------------------
ECHO ---------BLANCK MENU----------
ECHO ------------------------------
ECHO -
ECHO 1 . POWER CONFIGURATION
ECHO 2 . Startup Shell
ECHO 0 . EXIT
SET /P BChoice="Choose A Number And Press Enter : "
IF %BChoice%==1 GOTO POWERCFGMENU
IF %BChoice%==0 GOTO MAIN
ENDLOCAL
EXIT /B %ERRORLEVEL%
:: POWER CONFIGURATION MENU
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:POWERCFGMENU
SETLOCAL
SETLOCAL ENABLEDELAYEDEXPANSION
CALL :tBanner
ECHO ------------------------------
ECHO -------POWER.CFG MENU---------
ECHO ------------------------------
ECHO -
ECHO 1 . POWER CONFIGURATION
ECHO 2 . Startup Shell
ECHO 0 . EXIT
SET /P BChoice="Choose A Number And Press Enter : "
IF %BChoice%==1 GOTO EOF
IF %BChoice%==0 GOTO MAIN
ENDLOCAL
EXIT /B %ERRORLEVEL%
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::