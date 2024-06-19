@echo off
@setlocal EnableExtensions
@setlocal DisableDelayedExpansion

REM Metadata Header
set ProgramName=MSEdge Tweaker
set GitHubLink=https://github.com/TheBobPony/MSEdgeTweaker/tree/948b70704c320486fa23abeeedbdac211749202b
set Author=TheBobPony
set CreationDate=2024-06-19

REM Version Information
set version=v24-06-19.1
set UpdateDate=2024-06-19
set CreatorOfChange=SmearODeer
set ReasonForUpdate=Improved readability and added features

REM Determine System Drive Letter
for %%I in (C D E F G H I J K L M N O P Q R S T U V W X Y Z) do if exist %%I:\Windows\System32 set SystemDrive=%%I:

REM Create Timestamp Variable
for /f "tokens=1-4 delims=:. " %%a in ("%date% %time%") do (
    set Timestamp=%%c%%a%%b_%%d%%e%%f
)

REM Log and Backup Directories
set LogDir=%SystemDrive%\ProgramData\MSEdgeTweaker\Logs_%Timestamp%
set BackupDir=%SystemDrive%\ProgramData\MSEdgeTweaker\Backups_%Timestamp%
set MaxLogAge=7

REM Create Directories
if not exist %LogDir% mkdir %LogDir%
if not exist %BackupDir% mkdir %BackupDir%

REM Logging Function
:Log
echo %~1 >> %LogDir%\MSEdgeTweaker.log
exit /b

REM Rotate Logs
forfiles /p "%SystemDrive%\ProgramData\MSEdgeTweaker" /s /m *.log /d -%MaxLogAge% /c "cmd /c del @path"
forfiles /p "%SystemDrive%\ProgramData\MSEdgeTweaker" /s /m *.txt /d -%MaxLogAge% /c "cmd /c del @path"

REM Initialize Choice Tracking
set "choices="

REM Function to Track Choices
:TrackChoice
echo %~1 >> %LogDir%\Choices.log
set choices=%choices% %~1
exit /b

REM Check if Choice Already Made
:CheckChoice
echo %choices% | find "%~1" >nul
if %errorlevel%==0 (
    echo Option %~1 has already been chosen during this run.
    pause
    goto MainMenu
)
exit /b

REM Script Execution Starts Here
call :Log "Script execution started at %Timestamp%"

set version=v24-06-19
title MSEdge Tweaker %version%
echo Please wait, checking your system...

REM Check if there's Admin rights
Reg.exe query "HKU\S-1-5-19\Environment"
if not %ERRORLEVEL% EQU 0 (
    cls
    echo You must have administrator rights to run this script!
    echo To do this, right click on this script file then select 'Run as administrator'.
    pause
    exit
)

REM Check OS version
%SystemRoot%\System32\WindowsPowerShell\v1.0\powershell.exe -NoProfile "If ($([System.Environment]::OSVersion.Version.Major) -ge 10) { Exit 0 } Else { Exit 1 }"
if ErrorLevel 1 (
    cls
    echo Sorry, this script requires Windows 10 and newer! This script will now exit...
    pause
    exit /b
)

REM Check if device is joined to domain
echo Checking if this device is joined to a domain...
for /f %%a in ('powershell "(Get-WmiObject -Class Win32_ComputerSystem).PartOfDomain"') do set ComMem=%%a
echo %ComMem%

if %ComMem% EQU True (
    goto DomainUser
) else (
    goto WorkgroupUser
)

:DomainUser
cls
echo This device appears to be joined to a domain!
echo If you're an administrator of the domain, you should deploy Microsoft's own group policies for your domain instead!
echo Would you like to read the documentation for it or still proceed using this script?
echo [1] Read the documentation for it
echo [2] Proceed to Main Menu
echo [3] Exit
choice /C:123 /N
set _erl=%errorlevel%
if %_erl%==3 exit /b
if %_erl%==2 goto MainMenu
if %_erl%==1 (
    start https://learn.microsoft.com/deployedge/configure-microsoft-edge
    exit /b
)
goto MainMenu

:WorkgroupUser
goto MainMenu

:MainMenu
cls
echo Welcome to MSEdge Tweaker %version%!
echo Here's the list of available options:
echo [1] Configure startup behavior, new tab and about page
echo [2] Disable importing from other web browsers on launch
echo [3] Disable browser sign in and sync services
echo [4] Disable setting as the default browser
echo [5] Disable edge sidebar
echo [6] Disable shopping assistant
echo [7] Disable visual search
echo [8] Go to Extras menu
echo [9] Visit this project on GitHub
echo [0] Exit
echo [A] Apply All
choice /C:1234567890A /N
set _erl=%errorlevel%

if %_erl%==11 goto ApplyAll
if %_erl%==10 (
    start https://github.com/TheBobPony/MSEdgeTweaker
    goto MainMenu
)
if %_erl%==9 goto MainMenu
if %_erl%==8 goto ExtrasMenu
if %_erl%==7 goto visualsearch
if %_erl%==6 goto shoppingassist
if %_erl%==5 goto sidebar
if %_erl%==4 goto defaultbrowser
if %_erl%==3 goto nosignin
if %_erl%==2 goto browserimport
if %_erl%==1 goto builtinpages
goto MainMenu

:ApplyAll
set "applyAll=1"
goto builtinpages

:ExtrasMenu
cls
echo Extras menu for MSEdge Tweaker
echo Here's the list of available options:
echo [1] Disable Gamer mode
echo [2] Disable user feedback option
echo [3] Disable search bar and on startup
echo [4] Disable browser guest mode
echo [5] Disable collections feature
echo [6] Remove ALL registry policies set
echo [7] Uninstall Microsoft Edge web browser (coming soon)
echo [8] Uninstall Microsoft Edge WebView (coming soon)
echo [9] Return to Main Menu
echo [0] Exit
choice /C:1234567890 /N
set _erl=%errorlevel%
if %_erl%==10 exit /b
if %_erl%==9 goto MainMenu
if %_erl%==8 goto uninstalledgewebview
if %_erl%==7 goto uninstalledge
if %_erl%==6 goto clearpolicies
if %_erl%==5 goto collections
if %_erl%==4 goto guestmode
if %_erl%==3 goto searchbar
if %_erl%==2 goto userfeedback
if %_erl%==1 goto gamermode
goto MainMenu

:builtinpages
cls
echo Configure startup, new tab and about page with MSEdge Tweaker
echo Here's the list of available options:
echo [1] Disable startup boost
echo [2] Disable the first run experience and splash screen
echo [3] Disable sponsored links in the new tab page
echo [4] Disable quick links in the new tab page
echo [5] Disable insider banner in the about page
echo [9] Return to Main Menu
echo [0] Exit
choice /C:1234590 /N
set _erl=%errorlevel%

REM Apply All Logic
if defined applyAll (
    for /L %%i in (1, 1, 5) do (
        call :CheckChoice %%i
        call :TrackChoice %%i
        goto choice%%i
    )
    goto MainMenu
)

if %_erl%==10 exit /b
if %_erl%==9 goto MainMenu
if %_erl%==5 goto insiderbanner
if %_erl%==4 goto quicklinksnewtab
if %_erl%==3 goto sponsorednewtab
if %_erl%==2 goto firstrunoobe
if %_erl%==1 goto startupboost
goto MainMenu

:firstrunoobe
call :CheckChoice 2
call :TrackChoice 2
set regd=HideFirstRunExperience
echo Disabling the first run experience and splash screen...
goto regchecks

:browserimport
call :CheckChoice 2
call :TrackChoice 2
set regd=ImportOnEachLaunch
echo Disabling importing from other web browsers on launch...
goto regchecks

:defaultbrowser
call :CheckChoice 4
call :TrackChoice 4
set regd=DefaultBrowserSettingEnabled
echo Disabling setting as default browser...
goto regchecks

:gamermode
call :CheckChoice 1
call :TrackChoice 1
set regd=GamerModeEnabled
echo Disabling Gamer mode...
goto regchecks

:sidebar
call :CheckChoice 5
call :TrackChoice 5
set regd=HubsSidebarEnabled
set regd2=StandaloneHubsSidebarEnabled
echo Disabling edge sidebar...
goto regchecks

:shoppingassist
call :CheckChoice 6
call :TrackChoice 6
set regd=EdgeShoppingAssistantEnabled
echo Disabling shopping assistant...
goto regchecks

:sponsorednewtab
call :CheckChoice 3
call :TrackChoice 3
set regd=NewTabPageHideDefaultTopSites
echo Disabling Sponsored links in new tab page...
goto regchecks

:quicklinksnewtab
call :CheckChoice 4
call :TrackChoice 4
set regd=NewTabPageQuickLinksEnabled
echo Disabling quick links in new tab page...
goto regchecks

:visualsearch
call :CheckChoice 7
call :TrackChoice 7
set regd=VisualSearchEnabled
echo Disabling visual search...
goto regchecks

:nosignin
call :CheckChoice 3
call :TrackChoice 3
set regd=BrowserSignin
set regd2=ImplicitSignInEnabled
set regd3=SyncDisabled
echo Disabling browser sign in and sync services...
goto regchecks

:insiderbanner
call :CheckChoice 5
call :TrackChoice 5
set regd=MicrosoftEdgeInsiderPromotionEnabled
echo Disabling insider banner in the about page...
goto regchecks

:userfeedback
call :CheckChoice 2
call :TrackChoice 2
set regd=UserFeedbackAllowed
echo Disabling submit user feedback option...
goto regchecks

:searchbar
call :CheckChoice 3
call :TrackChoice 3
set regd=SearchbarAllowed
set regd2=SearchbarIsEnabledOnStartup
echo Disabling search bar...
goto regchecks

:guestmode
call :CheckChoice 4
call :TrackChoice 4
set regd=BrowserGuestModeEnabled
echo Disabling use of guest mode...
goto regchecks

:collections
call :CheckChoice 5
call :TrackChoice 5
set regd=EdgeCollectionsEnabled
echo Disabling collections feature...
goto regchecks

:startupboost
call :CheckChoice 1
call :TrackChoice 1
set regd=StartupBoostEnabled
echo Disabling startup boost...
goto regchecks

:uninstalledge
echo Uninstalling Microsoft Edge web browser is coming soon...
timeout 5
goto MainMenu

:uninstalledgewebview
echo Uninstalling Microsoft Edge WebView2 is coming soon, check back later!
timeout 5
goto MainMenu

:clearpolicies
call :TrackChoice 6
echo Clearing all registry policies set...
reg delete HKLM\Software\Policies\Microsoft\Edge /f
reg delete HKCU\Software\Policies\Microsoft\Edge /f
timeout 5
goto MainMenu

:regchecks
echo Checking if the registry policy already exists...
reg query HKLM\Software\Policies\Microsoft\Edge\ /v %regd% >nul 2>&1
if %ERRORLEVEL%==0 goto existingregd
if %ERRORLEVEL%==1 goto notexistregd

:existingregd
echo The registry policy (%regd) already exists, what would you like to do now?
echo [1] Do nothing, go back to main menu
echo [2] Remove the registry policy.
choice /C:12 /N
set _erl=%errorlevel%
if %_erl%==2 goto undoregd
if %_erl%==1 goto MainMenu

:notexistregd
echo Applying registry policy...
reg add "HKLM\Software\Policies\Microsoft\Edge" /v "%regd%" /t REG_DWORD /d "0" /f
if "%regd2%"=="" goto donemenu
reg add "HKLM\Software\Policies\Microsoft\Edge" /v "%regd2%" /t REG_DWORD /d "0" /f
if "%regd3%"=="" goto donemenu
reg add "HKLM\Software\Policies\Microsoft\Edge" /v "%regd3%" /t REG_DWORD /d "1" /f

:donemenu
echo What would you like to do now?
echo [1] Return to main menu
echo [2] Undo change
echo [3] Exit
choice /C:123 /N
set _erl=%errorlevel%
if %_erl%==3 exit /b
if %_erl%==2 goto undoregd
if %_erl%==1 goto MainMenu

:undoregd
echo Undoing registry change(s)...
reg delete HKLM\Software\Policies\Microsoft\Edge /v %regd% /f
if "%regd2%"=="" timeout 5 & goto MainMenu
reg delete HKLM\Software\Policies\Microsoft\Edge /v %regd2% /f
if "%regd3%"=="" timeout 5 & goto MainMenu
reg delete HKLM\Software\Policies\Microsoft\Edge /v %regd3% /f
timeout 5
goto MainMenu
