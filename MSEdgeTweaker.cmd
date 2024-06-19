@echo off
@setlocal DisableDelayedExpansion
set version=v24-06-19
title MSEdge Tweaker %version%
echo Please wait, checking your system...

REM Check if there's Admin rights
Reg.exe query "HKU\S-1-5-19\Environment"
If Not %ERRORLEVEL% EQU 0 (
 cls & echo. You must have administrator rights to run this script! & echo. To do this, right click on this script file then select 'Run as administrator'. & echo.
 Pause & Exit
)
REM Check OS version
%SystemRoot%\System32\WindowsPowerShell\v1.0\powershell.exe -NoProfile "If ($([System.Environment]::OSVersion.Version.Major) -GE '10') { Exit 0 } Else { Exit 1 }"
If ErrorLevel 1 cls & echo. Sorry, this script requires Windows 10 and newer! This script will now exit... & pause & exit /b

REM Check if device is joined to domain
echo Checking if this device is joined to a domain...
for /f %%a in ('powershell "(Get-WmiObject -Class Win32_ComputerSystem).PartOfDomain"') do set ComMem=%%a
echo %ComMem%

If %ComMem% Equ True    (
                        GoTo DomainUser
                        ) Else  (
                                GoTo WorkgroupUser
                                )
:DomainUser
cls
echo.
echo Hey there!
echo.
echo This device appears to be joined to a domain!
echo If you're an administrator of the domain, you should deploy Microsoft's own group policies for your domain instead!
echo.
echo Would you like to read the documentation for it or still proceed using this script?
echo.
echo. [1] Read the documentation for it
echo. [2] Proceed to Main Menu
echo.
echo. [3] Exit
echo.
echo Enter a menu option on the Keyboard [1,2,3] :
choice /C:123 /N
set _erl=%errorlevel%
if %_erl%==3 exit /b
if %_erl%==2 goto MainMenu
if %_erl%==1 start https://learn.microsoft.com/deployedge/configure-microsoft-edge & exit /b
:WorkgroupUser
goto MainMenu

:MainMenu
set regd=
set regd2=
set regd3=
cls
echo.
echo Welcome to MSEdge Tweaker %version%!
echo.
echo Here's the list of availables options that you can do here:
echo.
echo. [1] Configure startup behavior, new tab and about page
echo. [2] Disable importing from other web browsers on launch
echo. [3] Disable browser sign in and sync services
echo. [4] Disable setting as the default browser
echo. [5] Disable edge sidebar
echo. [6] Disable shopping assistant
echo. [7] Disable visual search (icon that appears over images)
echo.
echo. [8] Go to Extras menu
echo.
echo. [9] Visit this project on GitHub
echo. [0] Exit
echo.
echo Enter a menu option on the Keyboard [1,2,3,4,5,6,7,8,9,0] :
choice /C:1234567890 /N
set _erl=%errorlevel%
if %_erl%==10 exit /b
if %_erl%==9 start https://github.com/TheBobPony/MSEdgeTweaker & goto MainMenu
if %_erl%==8 cls & goto ExtrasMenu
if %_erl%==7 cls & goto visualsearch
if %_erl%==6 cls & goto shoppingassist
if %_erl%==5 cls & goto sidebar
if %_erl%==4 cls & goto defaultbrowser
if %_erl%==3 cls & goto nosignin
if %_erl%==2 cls & goto browserimport
if %_erl%==1 cls & goto builtinpages
goto MainMenu

:ExtrasMenu
echo.
echo Extras menu for MSEdge Tweaker
echo.
echo Here's the list of availables options that you can do here:
echo. 
echo. [1] Disable Gamer mode
echo. [2] Disable user feedback option
echo. [3] Disable search bar and on startup
echo. [4] Disable browser guest mode
echo. [5] Disable collections feature
echo.
echo. [6] Remove ALL registry policies set
echo.
echo. [7] Uninstall Microsoft Edge web browser (coming soon)
echo. [8] Uninstall Microsoft Edge WebView (coming soon)
echo.
echo. [9] Return to Main Menu
echo. [0] Exit
echo.
echo Enter a menu option on the Keyboard [1,2,3,4,5,6,7,8,9,0] :
choice /C:1234567890 /N
set _erl=%errorlevel%
if %_erl%==10 exit /b
if %_erl%==9 goto MainMenu
if %_erl%==8 cls & goto uninstalledgewebview
if %_erl%==7 cls & goto uninstalledge
if %_erl%==6 cls & goto clearpolicies
if %_erl%==5 cls & goto collections
if %_erl%==4 cls & goto guestmode
if %_erl%==3 cls & goto searchbar
if %_erl%==2 cls & goto userfeedback
if %_erl%==1 cls & goto gamermode
goto MainMenu

:builtinpages
echo.
echo Configure startup, new tab and about page with MSEdge Tweaker
echo.
echo Here's the list of availables options that you can do here:
echo. 
echo. [1] Disable startup boost
echo. [2] Disable the first run experience and splash screen
echo. [3] Disable sponsored links in the new tab page
echo. [4] Disable quick links in the new tab page
echo. [5] Disable insider banner in the about page
echo.
echo. [9] Return to Main Menu
echo. [0] Exit
echo.
echo Enter a menu option on the Keyboard [1,2,3,4,5,9,0] :
choice /C:1234567890 /N
set _erl=%errorlevel%
if %_erl%==10 exit /b
if %_erl%==9 goto MainMenu
if %_erl%==5 cls & goto insiderbanner
if %_erl%==4 cls & goto quicklinksnewtab
if %_erl%==3 cls & goto sponsorednewtab
if %_erl%==2 cls & goto firstrunoobe
if %_erl%==1 cls & goto startupboost
goto MainMenu

:firstrunoobe
set regd=HideFirstRunExperience
echo Disabling the first run experience and splash screen...
goto regchecks
:browserimport
set regd=ImportOnEachLaunch
echo Disabling importing from other web browsers on launch...
goto regchecks
:defaultbrowser
set regd=DefaultBrowserSettingEnabled
echo Disabling setting as default browser...
goto regchecks
:gamermode
set regd=GamerModeEnabled
echo Disabling Gamer mode...
goto regchecks
:sidebar
set regd=HubsSidebarEnabled
set regd2=StandaloneHubsSidebarEnabled
echo Disabling edge sidebar...
goto regchecks
:shoppingassist
set regd=EdgeShoppingAssistantEnabled
echo Disabling shopping assistant...
goto regchecks
:sponsorednewtab
set regd=NewTabPageHideDefaultTopSites
echo Disabling Sponsored links in new tab page...
goto regchecks
:quicklinksnewtab
set regd=NewTabPageQuickLinksEnabled
echo Disabling quick links in new tab page...
goto regchecks
:visualsearch
set regd=VisualSearchEnabled
echo Disabling visual search...
goto regchecks
:nosignin
set regd=BrowserSignin
set regd2=ImplicitSignInEnabled
set regd3=SyncDisabled
echo Disabling browser sign in and sync services...
goto regchecks
:insiderbanner
set regd=MicrosoftEdgeInsiderPromotionEnabled
echo Disabling insider banner in the about page...
goto regchecks
:userfeedback
set regd=UserFeedbackAllowed
echo Disabling submit user feedback option...
goto regchecks
:searchbar
set regd=SearchbarAllowed
set regd2=SearchbarIsEnabledOnStartup
echo Disabling search bar...
goto regchecks
:guestmode
set regd=BrowserGuestModeEnabled
echo Disabling use of guest mode...
goto regchecks
:collections
set regd=EdgeCollectionsEnabled
echo Disabling collections feature...
goto regchecks
:startupboost
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
echo Clearing all registry policies set...
reg delete HKLM\Software\Policies\Microsoft\Edge /f
reg delete HKCU\Software\Policies\Microsoft\Edge /f
timeout 5
goto MainMenu

:regchecks
echo Checking if the registry policy already exists...
reg query HKLM\Software\Policies\Microsoft\Edge\ /v %regd% >nul 2>&1
if %ERRORLEVEL% == 0  goto existingregd
if %ERRORLEVEL% == 1 goto notexistregd

:existingregd
echo.
echo The registry policy (%regd) already exists, what would you like to do now?
echo.
echo. [1] Do nothing, go back to main menu
echo. [2] Remove the registry policy.
echo.
echo Enter a menu option on the Keyboard [1,2] :
choice /C:12 /N
set _erl=%errorlevel%
if %_erl%==2 cls & goto undoregd
if %_erl%==1 cls & goto MainMenu
goto MainMenu

:notexistregd
echo.
echo Applying registry policy...
Reg.exe add "HKLM\Software\Policies\Microsoft\Edge" /v "%regd%" /t REG_DWORD /d "0" /f
IF "%regd2%"=="" goto donemenu
Reg.exe add "HKLM\Software\Policies\Microsoft\Edge" /v "%regd2%" /t REG_DWORD /d "0" /f
IF "%regd3%"=="" goto donemenu
Reg.exe add "HKLM\Software\Policies\Microsoft\Edge" /v "%regd3%" /t REG_DWORD /d "1" /f

:donemenu
echo.
echo What would you like to do now?
echo.
echo. [1] Return to main menu
echo. [2] Undo change
echo.
echo. [3] Exit
echo.
echo Enter a menu option on the Keyboard [1,2,3] :
choice /C:123 /N
set _erl=%errorlevel%
if %_erl%==3 exit /b
if %_erl%==2 cls & goto undoregd
if %_erl%==1 cls & goto MainMenu
goto MainMenu
:undoregd
echo.
echo Undoing registry change(s)...
echo.
reg delete HKLM\Software\Policies\Microsoft\Edge\ /v %regd% /f
IF "%regd2%"=="" timeout 5 & goto MainMenu
reg delete HKLM\Software\Policies\Microsoft\Edge\ /v %regd2% /f
IF "%regd3%"=="" timeout 5 & goto MainMenu
reg delete HKLM\Software\Policies\Microsoft\Edge\ /v %regd3% /f
timeout 5
goto MainMenu