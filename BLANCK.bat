::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:: Blanck Batch Script Framework
:: Authur Salar Muhammadi
:: DevSecOps(DSO)
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:: Starter
@ECHO off
TITLE BLANCK ADMINISTRATOR
PROMPT "Blanck>>
CD /d "%~dp0"
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:: Public VARs
SET STARTDATETIME=%DATE%-%TIME%
SET "params=%*"
SET USERROLE=
SET DOMAINTYPE=
SET IDMAC=
::
SET MANUFACTURER=
SET MODEL=
SET SERIALNUMBER=
SET OSNAME=
:: Public VARs
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
::::::::::::::::::::::::::::::::::::::::::::::::::::::
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:MAIN
CALL :WELCOMEBAN
CALL :CHECKADMIN
IF NOT EXIST tmpAdmin.tmp ( CALL :GETADMIN ) ELSE ECHO PRIVILAGE ACCESS GRANTED!!!
TIMEOUT /T 1 /NOBREAK >NUL
CLS
CALL :WELCOMEBAN
CALL :GETMACS
TIMEOUT /T 1 /NOBREAK >NUL
CALL :MAKETREES
TIMEOUT /T 1 /NOBREAK >NUL
CALL :GATHERINFO
CALL :STARTUPLOGS
TIMEOUT /T 1 /NOBREAK >NUL
SETLOCAL
SETLOCAL ENABLEDELAYEDEXPANSION
:: MAIN
CALL :MAINMENU
:: MAIN END
:MAINEXIT
ECHO "Goodbye!"
ECHO "Goodbye!" >> config\info\db\computers\%COMPUTERNAME%\%IDMAC%\log\events.log
ECHO "Goodbye!" >> logs\events.log 
if exist "%temp%\getadmin.vbs" del "%temp%\getadmin.vbs"
IF EXIST tmpAdmin.tmp DEL tmpAdmin.tmp
ECHO EXIT Program At : %date% %time% >> config\info\db\computers\%COMPUTERNAME%\%IDMAC%\log\events.log
ECHO EXIT Program At : %date% %time% >> logs\events.log 
ECHO 9999999999999999999999999999999 >> config\info\db\computers\%COMPUTERNAME%\%IDMAC%\log\events.log
ECHO 9999999999999999999999999999999 >> logs\events.log 
IF EXIST logs\events.log ( 
   MOVE /Y logs\events.log logs\history\ >nul
   REN "logs\history\events.log" "event_%date:~10,4%-%date:~7,2%-%date:~4,2%@%time:~0,2%#%time:~3,2%#%time:~6,2%.log" )
IF EXIST config\info\db\computers\%COMPUTERNAME%\%IDMAC%\log\events.log (
   MOVE /Y config\info\db\computers\%COMPUTERNAME%\%IDMAC%\log\events.log config\info\db\computers\%COMPUTERNAME%\%IDMAC%\log\history\ >NUL
   REN "config\info\db\computers\%COMPUTERNAME%\%IDMAC%\log\history\events.log" "event_%date:~10,4%-%date:~7,2%-%date:~4,2%@%time:~0,2%#%time:~3,2%#%time:~6,2%.log" )
IF EXIST config\info\db\computers\%COMPUTERNAME%\%IDMAC%\ip\ip.txt (
   MOVE /Y config\info\db\computers\%COMPUTERNAME%\%IDMAC%\ip\ip.txt config\info\db\computers\%COMPUTERNAME%\%IDMAC%\ip\history\ >NUL
   REN "config\info\db\computers\%COMPUTERNAME%\%IDMAC%\ip\history\ip.txt" "ip_%date:~10,4%-%date:~7,2%-%date:~4,2%@%time:~0,2%#%time:~3,2%#%time:~6,2%.txt" )
ENDLOCAL
:: ECHO REBOOTING SYSTEM...
TIMEOUT /T 1 /NOBREAK >NUL
:: SHUTDOWN /r /t 0 /f
EXIT /B %ERRORLEVEL%
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
::::::::::::::::::::::::::::::::::::::::::::::::::::::
:: CHECK ADMINISTRATOR ACCESS
:CHECKADMIN
IF EXIST "%temp%\getadmin.vbs" DEL "%temp%\getadmin.vbs"
FSUTIL dirty QUERY %systemdrive% 1>NUL 2>NUL
IF %ERRORLEVEL% EQU 0 ( SET USERROLE=ADMINISTRATOR && ECHO 1 > tmpAdmin.tmp ) ELSE ( SET USERROLE=STANDARD && IF EXIST tmpAdmin.tmp DEL tmpAdmin.tmp )
IF %USERDOMAIN% == %COMPUTERNAME% ( SET DOMAINTYPE=LOCAL ) ELSE SET DOMAINTYPE=SERVER
EXIT /B %ERRORLEVEL%
:: CHECK ADMINISTRATOR ACCESS
::::::::::::::::::::::::::::::::::::::::::::::::::::::
::::::::::::::::::::::::::::::::::::::::::::::::::::::
:GETADMIN
:DOGETADMIN
( ECHO SET UAC = CreateObject^("Shell.Application"^) : UAC.ShellExecute "cmd.exe", "/c cd ""%~sdp0"" && %~s0 %params%", "", "runas", 1 > "%temp%\getadmin.vbs" && "%temp%\getadmin.vbs" )
TIMEOUT /T 1 /NOBREAK >NUL
IF EXIST tmpAdmin.tmp EXIT
SETLOCAL
SETLOCAL ENABLEDELAYEDEXPANSION
CHOICE /C yn /n /t 3 /d y /m "You Are Not Administrator Do you want to retry(Y) or skip(N) : " 
IF %ERRORLEVEL%==2 GOTO NOTADMIN
IF %ERRORLEVEL%==1 GOTO DOGETADMIN
GOTO GETADMIN
ENDLOCAL
:NOTADMIN
ECHO PRIVILAGE ACCESS DENIED!!!
TIMEOUT /T 1 /NOBREAK >NUL
EXIT /B %ERRORLEVEL%
:::::::::::::::::::::::::::::::::::::::::::::::::::::::
:::::::::::::::::::::::::::::::::::::::::::::::::::::::
::::::::::::::::::::::::::::::::::::::::::::::::::::::
:GETMACS
for /f "tokens=3 delims=," %%a in ('"getmac /nh /v /fo csv"') DO ( 
   SET IDMAC=%%a
   IF !IDMAC! NEQ "" EXIT /B )
EXIT /B %ERRORLEVEL%
::::::::::::::::::::::::::::::::::::::::::::::::::::::
:WELCOMEBAN
ECHO ---------------------------------
ECHO Hello %USERNAME%.
ECHO Welcome To Blanck Administration!
ECHO ---------------------------------
EXIT /B %ERRORLEVEL%
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:: NEEDED TREE
:MAKETREES
:: LOGS
IF NOT exist logs\ MD logs
IF NOT exist logs\history\ MD logs\history
IF EXIST logs\events.log ( 
   MOVE /Y logs\events.log logs\history\
   REN "logs\history\events.log" "event_%date:~10,4%-%date:~7,2%-%date:~4,2%@%time:~0,2%#%time:~3,2%#%time:~6,2%break.log" )
:: LOGS
:: CONFIGURATIONS
IF NOT exist config\ MD config
:: :: INFORMATIONS
IF NOT exist config\info\ MD config\info
:: :: :: DATABASES
IF NOT exist config\info\db\ MD config\info\db
:: :: :: :: COMPUTER NAMES
IF NOT exist config\info\db\computers\ MD config\info\db\computers
IF NOT exist config\info\db\computers\%COMPUTERNAME%\ MD config\info\db\computers\%COMPUTERNAME%
IF NOT exist config\info\db\computers\%COMPUTERNAME%\%IDMAC%\ MD config\info\db\computers\%COMPUTERNAME%\%IDMAC%
:: :: :: :: :: LOCAL GROUPS
IF NOT exist config\info\db\computers\%COMPUTERNAME%\%IDMAC%\local\ MD config\info\db\computers\%COMPUTERNAME%\%IDMAC%\local
IF NOT exist config\info\db\computers\%COMPUTERNAME%\%IDMAC%\local\users\ MD config\info\db\computers\%COMPUTERNAME%\%IDMAC%\local\users
IF NOT exist config\info\db\computers\%COMPUTERNAME%\%IDMAC%\local\users\standard\ MD config\info\db\computers\%COMPUTERNAME%\%IDMAC%\local\users\standard
IF NOT exist config\info\db\computers\%COMPUTERNAME%\%IDMAC%\local\users\administrators\ MD config\info\db\computers\%COMPUTERNAME%\%IDMAC%\local\users\administrators
:: :: :: :: :: LOCAL GROUPS
:: :: :: :: :: DOMAIN GROUPS
IF %USERDOMAIN% NEQ %COMPUTERNAME% (
   IF NOT exist config\info\db\computers\%COMPUTERNAME%\%IDMAC%\%USERDOMAIN%\ MD config\info\db\computers\%COMPUTERNAME%\%IDMAC%\%USERDOMAIN%
   IF NOT exist config\info\db\computers\%COMPUTERNAME%\%IDMAC%\%USERDOMAIN%\users\ MD config\info\db\computers\%COMPUTERNAME%\%IDMAC%\%USERDOMAIN%\users
   IF NOT exist config\info\db\computers\%COMPUTERNAME%\%IDMAC%\%USERDOMAIN%\users\standard\ MD config\info\db\computers\%COMPUTERNAME%\%IDMAC%\%USERDOMAIN%\users\standard
   IF NOT exist config\info\db\computers\%COMPUTERNAME%\%IDMAC%\%USERDOMAIN%\users\administrators\ MD config\info\db\computers\%COMPUTERNAME%\%IDMAC%\%USERDOMAIN%\users\administrators )
:: :: :: :: :: DOMAIN GROUPS
:: :: :: :: :: LOG
IF NOT exist config\info\db\computers\%COMPUTERNAME%\%IDMAC%\log\ MD config\info\db\computers\%COMPUTERNAME%\%IDMAC%\log
:: :: :: :: :: :: History
IF NOT exist config\info\db\computers\%COMPUTERNAME%\%IDMAC%\log\history\ MD config\info\db\computers\%COMPUTERNAME%\%IDMAC%\log\history
IF EXIST config\info\db\computers\%COMPUTERNAME%\%IDMAC%\log\events.log (
   MOVE /Y config\info\db\computers\%COMPUTERNAME%\%IDMAC%\log\events.log config\info\db\computers\%COMPUTERNAME%\%IDMAC%\log\history\
   REN "config\info\db\computers\%COMPUTERNAME%\%IDMAC%\log\history\events.log" "event_%date:~10,4%-%date:~7,2%-%date:~4,2%@%time:~0,2%#%time:~3,2%#%time:~6,2%break.log" )
:: :: :: :: :: :: History
:: :: :: :: :: LOG
:: :: :: :: :: IP
IF NOT exist config\info\db\computers\%COMPUTERNAME%\%IDMAC%\ip\ MD config\info\db\computers\%COMPUTERNAME%\%IDMAC%\ip
IF NOT exist config\info\db\computers\%COMPUTERNAME%\%IDMAC%\ip\history\ MD config\info\db\computers\%COMPUTERNAME%\%IDMAC%\ip\history
IF EXIST config\info\db\computers\%COMPUTERNAME%\%IDMAC%\ip\ip.txt (
   MOVE /Y config\info\db\computers\%COMPUTERNAME%\%IDMAC%\ip\ip.txt config\info\db\computers\%COMPUTERNAME%\%IDMAC%\ip\history\
   REN "config\info\db\computers\%COMPUTERNAME%\%IDMAC%\ip\history\ip.txt" "ip_%date:~10,4%-%date:~7,2%-%date:~4,2%@%time:~0,2%#%time:~3,2%#%time:~6,2%break.txt" )
SET ip_address_string="IPv4 Address"
FOR /F "usebackq tokens=2 delims=:" %%f in ( `ipconfig ^| findstr /c:%ip_address_string%` ) DO ( 
   ECHO Your IP Address is: %%f
   ECHO %%f >> config\info\db\computers\%COMPUTERNAME%\%IDMAC%\ip\ip.txt )
:: :: :: :: :: IP
:: :: :: :: COMPUTER NAMES
:: :: :: DATABASES
:: :: INFORMATIONS
:: CONFIGURATIONS
EXIT /B %ERRORLEVEL%
:: NEEDED TREE
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:: GATHER INFORMATION 
:GATHERINFO
FOR /F "tokens=2 delims='='" %%A IN ('wmic ComputerSystem Get Manufacturer /value') DO SET MANUFACTURER=%%A
FOR /F "tokens=2 delims='='" %%A IN ('wmic ComputerSystem Get Model /value') DO SET MODEL=%%A
FOR /F "tokens=2 delims='='" %%A IN ('wmic Bios Get SerialNumber /value') DO SET SERIALNUMBER=%%A
FOR /F "tokens=2 delims='='" %%A IN ('wmic os get Name /value') DO SET OSNAME=%%A
FOR /F "tokens=1 delims='|'" %%A IN ("%OSNAME%") DO SET OSNAME=%%A
EXIT /B %ERRORLEVEL%
:: GATHER INFORMATION 
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:: LOGS
:: STARTUP LOG
:STARTUPLOGS
ECHO 000000000000000000000000000000000 > config\info\db\computers\%COMPUTERNAME%\%IDMAC%\log\events.log
ECHO 000000000000000000000000000000000 > logs\events.log
ECHO Start Program At : %STARTDATETIME% >> config\info\db\computers\%COMPUTERNAME%\%IDMAC%\log\events.log
ECHO Start Program At : %STARTDATETIME% >> logs\events.log
ECHO Welcome To Blanck Administration! >> config\info\db\computers\%COMPUTERNAME%\%IDMAC%\log\events.log
ECHO Welcome To Blanck Administration! >> logs\events.log
ECHO --------------------------------- >> config\info\db\computers\%COMPUTERNAME%\%IDMAC%\log\events.log
ECHO --------------------------------- >> logs\events.log
ECHO Computer Informations >> config\info\db\computers\%COMPUTERNAME%\%IDMAC%\log\events.log
ECHO Computer Informations >> logs\events.log
ECHO MANUFACTURER = %MANUFACTURER% >> config\info\db\computers\%COMPUTERNAME%\%IDMAC%\log\events.log
ECHO MANUFACTURER = %MANUFACTURER% >> logs\events.log
ECHO MODEL = %MODEL% >> config\info\db\computers\%COMPUTERNAME%\%IDMAC%\log\events.log
ECHO MODEL = %MODEL% >> logs\events.log
ECHO SERIAL NUMBER = %SERIALNUMBER% >> config\info\db\computers\%COMPUTERNAME%\%IDMAC%\log\events.log
ECHO SERIAL NUMBER = %SERIALNUMBER% >> logs\events.log
ECHO OS = %OSNAME% >> config\info\db\computers\%COMPUTERNAME%\%IDMAC%\log\events.log
ECHO OS = %OSNAME% >> logs\events.log
VER >> config\info\db\computers\%COMPUTERNAME%\%IDMAC%\log\events.log
VER >> logs\events.log
CD >> config\info\db\computers\%COMPUTERNAME%\%IDMAC%\log\events.log
CD >> logs\events.log
ECHO --------------------------------- >> config\info\db\computers\%COMPUTERNAME%\%IDMAC%\log\events.log
ECHO --------------------------------- >> logs\events.log
ECHO All Users :
ECHO All Users : >> config\info\db\computers\%COMPUTERNAME%\%IDMAC%\log\events.log
ECHO All Users : >> logs\events.log
SET "USERS=DIR %SYSTEMDRIVE%\Users\ /B"
SETLOCAL ENABLEDELAYEDEXPANSION
FOR /F "tokens=1*" %%A IN (
   '%USERS%'
   ) DO (
   SET "Name=%%A"
   IF /I "!Name!" NEQ "Administrator" (
      IF /I "!Name!" NEQ "Public" (
         ECHO | SET /p="!Name! is " 
         ECHO | SET /p="!Name! is " >> config\info\db\computers\%COMPUTERNAME%\%IDMAC%\log\events.log
         ECHO | SET /p="!Name! is " >> logs\events.log

         SET /a "isAD=0"
         FOR /F "tokens=1*" %%B IN (
            'NET LOCALGROUP ADMINISTRATORS'
         ) DO (
            SET "ADN=%%B"
            IF /I !Name! EQU !ADN! (
                ECHO %DOMAINTYPE%ADMINISTRATOR.
                ECHO %DOMAINTYPE%ADMINISTRATOR. >> config\info\db\computers\%COMPUTERNAME%\%IDMAC%\log\events.log
                ECHO %DOMAINTYPE%ADMINISTRATOR. >> logs\events.log
                IF NOT EXIST config\info\db\computers\%SERIALNUMBER%\%COMPUTERNAME%\ SET /a "isAD=1"
            )
         )
         IF "!isAD!" == "0" ( 
            ECHO %DOMAINTYPE%STANDARD User.
            ECHO %DOMAINTYPE%STANDARD User. >> config\info\db\computers\%COMPUTERNAME%\%IDMAC%\log\events.log
            ECHO %DOMAINTYPE%STANDARD User. >> logs\events.log 
         )
      )
   )
)
ENDLOCAL
ECHO --------------------------------- >> config\info\db\computers\%COMPUTERNAME%\%IDMAC%\log\events.log
ECHO --------------------------------- >> logs\events.log
ECHO ---------------------------------
ECHO | SET /p="%MANUFACTURER% "
ECHO : %MODEL%
ECHO %OSNAME%
ECHO | SET /p="WORKDIR : "
CD
ECHO | SET /p="USER : "
ECHO | SET /p="USER : " >> config\info\db\computers\%COMPUTERNAME%\%IDMAC%\log\events.log
ECHO | SET /p="USER : " >> logs\events.log 
WHOAMI
WHOAMI >> config\info\db\computers\%COMPUTERNAME%\%IDMAC%\log\events.log
WHOAMI >> logs\events.log 
ECHO Access Role : %DOMAINTYPE% / %USERROLE%
ECHO Access Role : %DOMAINTYPE% / %USERROLE% >> config\info\db\computers\%COMPUTERNAME%\%IDMAC%\log\events.log
ECHO Access Role : %DOMAINTYPE% / %USERROLE% >> logs\events.log 
ECHO %date% %time%
ECHO ---------------------------------
ECHO --------------------------------- >> config\info\db\computers\%COMPUTERNAME%\%IDMAC%\log\events.log
ECHO --------------------------------- >> logs\events.log 
TIMEOUT /T 1 /NOBREAK >NUL
EXIT /B %ERRORLEVEL%
:: STARTUP LOG
:: LOGS
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:: TOP BANNER FUNCTION
:tBanner
SETLOCAL
SETLOCAL ENABLEDELAYEDEXPANSION
CLS
ECHO ------------------------------
ECHO Blanck Batch Framework.
ECHO ------------------------------
ECHO | SET /p="WORKDIR : "
CD
ECHO | SET /p="USER : "
WHOAMI
ECHO | SET /p="Access Role : %USERROLE%"
ECHO .
ECHO %date% %time%
ECHO %date% %time% >> logs\events.log 
ECHO ------------------------------
ENDLOCAL
EXIT /B %ERRORLEVEL%
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:: MAIN MENU FUNCTION
:MAINMENU
ECHO MAINMENU >> logs\events.log
CALL :tBanner
SETLOCAL
SETLOCAL ENABLEDELAYEDEXPANSION
ECHO ------------------------------
ECHO ---------BLANCK MENU----------
ECHO ------------------------------
ECHO -
ECHO A . Auto Config
ECHO P . POWER CONFIGURATION
ECHO S . Startup Shell
ECHO R . Remote Desktop Management
ECHO E . EXIT
ECHO -
CHOICE /C apsre /n /t 1 /d a /m "Pick an Option : " 
IF ERRORLEVEL ==5 GOTO MMEND
IF ERRORLEVEL ==4 GOTO REMOTEMENU
IF ERRORLEVEL ==3 GOTO EOF
IF ERRORLEVEL ==2 GOTO POWERCFGMENU
IF ERRORLEVEL ==1 ( 
   CALL :AUTOCONFIGMENU
   GOTO MMEND )
GOTO MAINMENU
ENDLOCAL
:MMEND
EXIT /B %ERRORLEVEL%
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:: AUTOMATIC CONFIGURATION MENU
:AUTOCONFIGMENU
ECHO AUTOCONFIGMENU >> logs\events.log
CALL :tBanner
SETLOCAL
SETLOCAL ENABLEDELAYEDEXPANSION
ECHO ------------------------------
ECHO -------AUTO CONFIG MENU-------
ECHO ------------------------------
ECHO -
ECHO A . Auto Config Sandbad CC
ECHO E . EXIT
ECHO -
CHOICE /C ae /n /t 1 /d a /m "Pick an Option : " 
IF ERRORLEVEL ==2 GOTO ACMEND
IF ERRORLEVEL ==1 ( 
   CALL :SCCAC
   GOTO ACMEND )
GOTO AUTOCONFIGMENU
ENDLOCAL
:ACMEND
EXIT /B %ERRORLEVEL%
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:: SANDBAD CC AUTO CONFIGURATION
:SCCAC
ECHO SANDBAD-CC AUTO CONFIGURATIONS >> logs\events.log
CALL :tBanner
SETLOCAL
SETLOCAL ENABLEDELAYEDEXPANSION
ECHO ------------------------------
ECHO -----SANDBAD AUTO CONFIG------
ECHO ------------------------------
powercfg /x -standby-timeout-ac 0
echo No Standby
ECHO No Standby >> config\info\db\computers\%COMPUTERNAME%\%IDMAC%\log\events.log
powercfg /x -hibernate-timeout-ac 0
powercfg /h off
echo No hibernate
echo No hibernate >> config\info\db\computers\%COMPUTERNAME%\%IDMAC%\log\events.log
powercfg /x -disk-timeout-ac 0
echo No disk off
echo No disk off >> config\info\db\computers\%COMPUTERNAME%\%IDMAC%\log\events.log
ENDLOCAL
EXIT /B %ERRORLEVEL%
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:: POWER CONFIGURATION MENU
:POWERCFGMENU
ECHO POWERCFGMENU >> logs\events.log
CALL :tBanner
SETLOCAL
SETLOCAL ENABLEDELAYEDEXPANSION
ECHO ------------------------------
ECHO -------POWER.CFG MENU---------
ECHO ------------------------------
ECHO -
ECHO A . Auto POWER CONFIGURATION
ECHO H . Hybernation
ECHO E . EXIT
CHOICE /C ahe /n /t 3 /d a /m "Pick an Option : "
IF ERRORLEVEL == 3 GOTO MAINMENU
IF ERRORLEVEL == 2 GOTO EOF
IF ERRORLEVEL == 1 GOTO POWERCFGMENU
GOTO POWERCFGMENU
ENDLOCAL
EXIT /B %ERRORLEVEL%
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:REMOTEMENU
ECHO REMOTECFGMENU >> logs\events.log
CALL :tBanner
SETLOCAL
SETLOCAL ENABLEDELAYEDEXPANSION
ECHO ------------------------------
ECHO -------REMOTE.CFG MENU--------
ECHO ------------------------------
ECHO -
ECHO E . Enable Remote Desktop
ECHO D . Disable Remote Desktop
ECHO X . EXIT
CHOICE /C edx /n /t 1 /d e /m "Pick an Option : "
SET /P BChoice="Choose A Number And Press Enter : "
IF %ERRORLEVEL% ==3 GOTO EOF
IF %ERRORLEVEL% ==2 CALL :RDPDIS
IF %ERRORLEVEL% ==1 CALL :RDPEN
ENDLOCAL
EXIT /B %ERRORLEVEL%
::::::::::::::::::::::::::::::::::::::::::::::::::::
:RDPEN
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Terminal Server" /v fDenyTSConnections /t REG_DWORD /d 0 /f
ECHO Remote Desktop Protocol Enabled
ECHO Remote Desktop Protocol Enabled >> config\info\db\computers\%COMPUTERNAME%\%IDMAC%\log\events.log
ECHO Remote Desktop Protocol Enabled >> logs\events.log
EXIT /B %ERRORLEVEL%
:RDPDIS
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Terminal Server" /v fDenyTSConnections /t REG_DWORD /d 1 /f
ECHO Remote Desktop Protocol Disabled
ECHO Remote Desktop Protocol Disabled >> config\info\db\computers\%COMPUTERNAME%\%IDMAC%\log\events.log
ECHO Remote Desktop Protocol Disabled >> logs\events.log
EXIT /B %ERRORLEVEL%
::::::::::::::::::::::::::::::::::::::::::::::::::::