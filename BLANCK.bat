:: Blanck Batch Script Framework
:: Authur Salar Muhammadi
:: DevSecOps(DSO)
:: Starter
@ECHO off
PROMPT "Blanck>>
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
:: Public VARs
set "params=%*"
SET USERROLE=
::::::::::::::::::::::::::::::::::::::::::::::::::::::
:: NEEDED TREE
CD /d "%~dp0"
IF NOT exist config\ MD config
IF NOT exist config\info\ MD config\info
IF NOT exist config\info\db\ MD config\info\db
IF NOT exist config\info\db\%COMPUTERNAME%\ MD config\info\db\%COMPUTERNAME%
IF NOT exist config\info\db\%COMPUTERNAME%\USERS\ MD config\info\db\%COMPUTERNAME%\USERS
IF NOT exist config\info\db\%COMPUTERNAME%\USERS\LOCAL\ MD config\info\db\%COMPUTERNAME%\USERS\LOCAL
IF NOT exist config\info\db\%COMPUTERNAME%\USERS\LOCAL\STANDARD\ MD config\info\db\%COMPUTERNAME%\USERS\LOCAL\STANDARD
IF NOT exist config\info\db\%COMPUTERNAME%\USERS\LOCAL\ADMINISTRATORS\ MD config\info\db\%COMPUTERNAME%\USERS\LOCAL\ADMINISTRATORS
::::::::::::::::::::::::::::::::::::::::::::::::::::::
CALL :CHECKADMIN
::::::::::::::::::::::::::::::::::::::::::::::::::::::
:: NEEDED TREE
::::::::::::::::::::::::::::::::::::::::::::::::::::::
:: USER INFORMATION
::ECHO | SET /p=%USERNAME%> config\info\user\name.dat
::ECHO | SET /p=%USERDOMAIN%> config\info\user\domain.dat
::ECHO | SET /p=%COMPUTERNAME%> config\info\user\computer.dat
:: USER INFORMATION
::::::::::::::::::::::::::::::::::::::::::::::::::::::
ECHO ---------------------------------
ECHO Hello %USERNAME%.
ECHO Welcome To Blanck Administration!
ECHO ---------------------------------
ECHO All Users :
SET "USERS=DIR %SYSTEMDRIVE%\Users\ /B"
SETLOCAL ENABLEDELAYEDEXPANSION
FOR /F "tokens=1*" %%A IN (
   '%USERS%'
   ) DO (
   SET "Name=%%A"
   IF /I "!Name!" NEQ "Administrator" (
      IF /I "!Name!" NEQ "Public" (
         ECHO | SET /p="!Name! is " 
         SET /a "isAD=0"
         FOR /F "tokens=1*" %%B IN (
            'NET LOCALGROUP ADMINISTRATORS'
         ) DO (
            SET "ADN=%%B"
            IF /I "!Name!" EQU "!ADN!" (
                ECHO ADMINISTRATOR.
                SET /a "isAD=1"
            )
         )
         IF "!isAD!" == "0" ECHO STANDARD User.
      )
   )
)
ENDLOCAL
VER
ECHO | SET /p="WORKDIR : "
CD
ECHO | SET /p="USER : "
WHOAMI
ECHO | SET /p="Access Role : %USERROLE%"
ECHO .
ECHO %date% %time%
ECHO ---------------------------------
TIMEOUT 3
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:MAIN
CALL :GETADMIN
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
::::::::::::::::::::::::::::::::::::::::::::::::::::::
:GETADMIN
FSUTIL dirty QUERY %systemdrive% 1>NUL 2>NUL
IF %ERRORLEVEL% EQU 0 ( GOTO ADMINACCESSED )
:DOGETADMIN
( echo Set UAC = CreateObject^("Shell.Application"^) : UAC.ShellExecute "cmd.exe", "/c cd ""%~sdp0"" && %~s0 %params%", "", "runas", 1 > "%temp%\getadmin.vbs" && "%temp%\getadmin.vbs" )
SET /P skipch="You Are Not Administrator Do you want to retry(1) or skip(0) : "
IF %skipch%==1 GOTO DOGETADMIN
IF %skipch%==0 GOTO NOTADMIN
:ADMINACCESSED
ECHO ACCESS GRANTED!
TIMEOUT 3
GOTO EOF
:NOTADMIN
EXIT /B %ERRORLEVEL%
::::::::::::::::::::::::::::::::::::::::::::::::::::::
:: CHECK ADMINISTRATOR ACCESS
:CHECKADMIN
IF EXIST "%temp%\getadmin.vbs" DEL "%temp%\getadmin.vbs"
FSUTIL dirty QUERY %systemdrive% 1>NUL 2>NUL
IF %ERRORLEVEL% EQU 0 ( SET USERROLE=ADMINISTRATOR ) ELSE ( SET USERROLE=STANDARD )
IF "!USERDOMAIN!" == "!COMPUTERNAME!" ( SET DOMAINTYPE=LOCAL ) ELSE ( SET DOMAINTYPE=SERVER )
EXIT /B %ERRORLEVEL%
:: CHECK ADMINISTRATOR ACCESS
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
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
ECHO | SET /p="USER : "
WHOAMI
ECHO | SET /p="Access Role : %USERROLE%"
ECHO .
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
ECHO MAINMENU >> log.txt
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
ECHO POWERCFGMENU >> log.txt
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
SETLOCAL
SETLOCAL ENABLEDELAYEDEXPANSION
FOR /f "tokens=*" %%f in ('powercfg.exe /L ^| FINDSTR ^*') DO ( SET _output=%%f && FOR /f "tokens=4" %%g in ('ECHO !_output!') DO ( SET _guid=%%g )  &&  echo %_guid% )
ENDLOCAL
EXIT /B %ERRORLEVEL%
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:REMOTEMENU
SETLOCAL
SETLOCAL ENABLEDELAYEDEXPANSION
CALL :tBanner
ECHO REMOTECFGMENU >> log.txt
ECHO ------------------------------
ECHO -------REMOTE.CFG MENU--------
ECHO ------------------------------
ECHO -
ECHO 1 . Enable Remote Desktop
ECHO 2 . Hybernation
ECHO 0 . EXIT
SET /P BChoice="Choose A Number And Press Enter : "
IF %BChoice%==1 CALL :RDPEN
IF %BChoice%==2 CALL :RDPDIS
IF %BChoice%==0 GOTO MAIN
ENDLOCAL
EXIT /B %ERRORLEVEL%
::::::::::::::::::::::::::::::::::::::::::::::::::::
:RDPEN
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Terminal Server" /v fDenyTSConnections /t REG_DWORD /d 0 /f
ECHO Remote Desktop Protocol Enabled
EXIT /B %ERRORLEVEL%
:RDPDIS
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Terminal Server" /v fDenyTSConnections /t REG_DWORD /d 1 /f
ECHO Remote Desktop Protocol Disabled
EXIT /B %ERRORLEVEL%
::::::::::::::::::::::::::::::::::::::::::::::::::::
