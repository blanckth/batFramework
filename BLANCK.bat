:: Blanck Batch Script Framework
:: Authur Salar Muhammadi
:: DevSecOps(DSO)
:: Starter
@ECHO off
PROMPT "Blanck>>
:: GET ADMINISTRATOR ACCESS
set "params=%*"
:: cd /d "%~dp0" && ( if exist "%temp%\getadmin.vbs" del "%temp%\getadmin.vbs" ) && fsutil dirty query %systemdrive% 1>nul 2>nul || (  echo Set UAC = CreateObject^("Shell.Application"^) : UAC.ShellExecute "cmd.exe", "/c cd ""%~sdp0"" && %~s0 %params%", "", "runas", 1 >> "%temp%\getadmin.vbs" && "%temp%\getadmin.vbs" && exit /B )
:: GET ADMINISTRATOR ACCESS
:::::::::::::::::::::::::::::::::::::::::::::::::::::
:: STARTUP LOG
ECHO --------------------------------- >> log.txt
ECHO Start Program At : %date% %time% >> log.txt
ECHO Welcome To Blanck Administration! >> log.txt
VER >> log.txt
CD >> log.txt
WHOAMI >> log.txt
ECHO 000000000000000000000000000000000 >> log.txt
:: STARTUP LOG
::::::::::::::::::::::::::::::::::::::::::::::::::::::
:: NEEDED TREE
IF exist config\ ( ECHO . ) ELSE ( MD config )
IF exist config\info\ ( ECHO . ) ELSE ( MD config\info )
IF exist config\info\user\ ( ECHO . ) ELSE ( MD config\info\user )
:: NEEDED TREE
::::::::::::::::::::::::::::::::::::::::::::::::::::::
:: USER INFORMATION
ECHO | SET /p=%USERNAME%> config\info\user\name.dat
ECHO | SET /p=%USERDOMAIN%> config\info\user\domain.dat
ECHO | SET /p=%COMPUTERNAME%> config\info\user\computer.dat
:: USER INFORMATION
::::::::::::::::::::::::::::::::::::::::::::::::::::::
ECHO ---------------------------------
ECHO Hello %USERNAME%.
ECHO Welcome To Blanck Administration!
ECHO ---------------------------------
VER
ECHO | SET /p="WORKDIR : "
CD
ECHO | SET /p="ADMIN : "
WHOAMI
ECHO %date% %time%
ECHO ---------------------------------
TIMEOUT 3
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:MAIN
SETLOCAL
SETLOCAL ENABLEDELAYEDEXPANSION
:: MAIN
GOTO MAINMENU
:: MAIN END
:MAINEXIT
ECHO "Goodbye!"
PAUSE
ECHO "Goodbye!" >> log.txt
if exist "%temp%\getadmin.vbs" del "%temp%\getadmin.vbs"
ECHO EXIT Program At : %date% %time% >> log.txt
ENDLOCAL
EXIT /B %ERRORLEVEL%
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:: TOP BANNER FUNCTION
CD >> log.txt
WHOAMI >> log.txt
ECHO %date% %time% >> log.txt
:tBanner
SETLOCAL
SETLOCAL ENABLEDELAYEDEXPANSION
CLS
ECHO ------------------------------
ECHO Blanck Batch Framework.
ECHO ------------------------------
VER
ECHO | SET /p="WORKDIR : "
CD
ECHO | SET /p="ADMIN : "
WHOAMI
ECHO %date% %time%
ECHO ------------------------------
ENDLOCAL
EXIT /B %ERRORLEVEL%
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:: MAIN MENU FUNCTION
:MAINMENU
SETLOCAL
SETLOCAL ENABLEDELAYEDEXPANSION
CALL :tBanner
ECHO MAINMENU > log.txt
ECHO ------------------------------
ECHO ---------BLANCK MENU----------
ECHO ------------------------------
ECHO -
ECHO 1 . POWER CONFIGURATION
ECHO 2 . Startup Shell
ECHO 0 . EXIT
SET /P BChoice="Choose A Number And Press Enter : "
IF %BChoice%==1 GOTO POWERCFGMENU
IF %BChoice%==0 GOTO MAINEXIT
ENDLOCAL
EXIT /B %ERRORLEVEL%
:: POWER CONFIGURATION MENU
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:POWERCFGMENU
SETLOCAL
SETLOCAL ENABLEDELAYEDEXPANSION
CALL :tBanner
ECHO POWERCFGMENU > log.txt
ECHO ------------------------------
ECHO -------POWER.CFG MENU---------
ECHO ------------------------------
ECHO -
ECHO 1 . Auto POWER CONFIGURATION
ECHO 2 . Hybernation
ECHO 0 . EXIT
SET /P BChoice="Choose A Number And Press Enter : "
IF %BChoice%==1 GOTO EOF
IF %BChoice%==0 GOTO MAIN
ENDLOCAL
EXIT /B %ERRORLEVEL%
::::::::::::::::::::::::::::::::::::::::::::::::::::
:CURACTGUID
SETLOCAL ENABLEDELAYEDEXPANSION
FOR /f "tokens=*" %%f in ('powercfg.exe /L ^| FINDSTR ^*') DO ( SET _output=%%f && FOR /f "tokens=4" %%g in ('ECHO !_output!') DO ( SET _guid=%%g ) ) &&  echo %_guid%
endlocal

EXIT /B %ERRORLEVEL%
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::