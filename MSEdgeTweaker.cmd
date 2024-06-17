@echo off
@setlocal DisableDelayedExpansion
set version=v24-06-17
title MSEdge Tweaker %version%
echo Please wait, checking your system...

Reg.exe query "HKU\S-1-5-19\Environment"
If Not %ERRORLEVEL% EQU 0 (
 cls & echo You must have administrator rights to run this script... && echo To do this, right click on this script file then select 'Run as administrator'.
 Pause & Exit
)
:MainMenu
cls
echo.
echo Welcome to MSEdge Tweaker %version%!
echo.
echo Here's the list of availables options that you can do here:
echo.
echo. [1] Disable the first run experience and splash screen
echo. [2] Disable importing from other web browsers on launch
echo. [3] Disable browser sign in and sync services
echo. [4] Disable setting as the default browser
echo. [5] Disable edge sidebar
echo. [6] Disable shopping assistant
echo. [7] Disable sponsored links in the new tab page
echo.
echo. [8] Extras menu
echo.
echo. [9] Visit this project on GitHub
echo. [0] Exit
echo.
echo Enter a menu option on the Keyboard [1,2,3,4,5,6,7,8,9,0] :
choice /C:1234567890 /N
set _erl=%errorlevel%
if %_erl%==10 exit /b
if %_erl%==9 start https://github.com/TheBobPony/MSEdgeTweaker & goto :MainMenu
if %_erl%==8 cls & goto :ExtrasMenu
if %_erl%==7 cls & goto :sponsorednewtab
if %_erl%==6 cls & goto :shoppingassist
if %_erl%==5 cls & goto :sidebar
if %_erl%==4 cls & goto :defaultbrowser
if %_erl%==3 cls & goto :nosignin
if %_erl%==2 cls & goto :browserimport
if %_erl%==1 cls & goto :firstrunoobe
goto :MainMenu
pause
:ExtrasMenu
echo.
echo Extras menu for MSEdge Tweaker
echo.
echo Here's the list of availables options that you can do here:
echo. 
echo. [1] Disable insider banner in about page
echo. [2] Disable user feedback option
echo. [3] Disable search bar and on startup
echo. [4] Disable browser guest mode
echo. [5] Disable collections feature
echo. [6] Disable startup boost
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
if %_erl%==9 goto :MainMenu
if %_erl%==8 cls & goto :uninstalledgewebview
if %_erl%==7 cls & goto :uninstalledge
if %_erl%==6 cls & goto :startup
if %_erl%==5 cls & goto :collections
if %_erl%==4 cls & goto :guestmode
if %_erl%==3 cls & goto :searchbar
if %_erl%==2 cls & goto :userfeedback
if %_erl%==1 cls & goto :insiderbanner
goto :MainMenu

:firstrunoobe
echo Disabling the first run experience and splash screen...
Reg.exe add "HKLM\Software\Policies\Microsoft\Edge" /v "HideFirstRunExperience" /t REG_DWORD /d "1" /f
timeout 5
goto :MainMenu
:browserimport
echo Disabling importing from other web browsers on launch...
Reg.exe add "HKLM\Software\Policies\Microsoft\Edge" /v "ImportOnEachLaunch" /t REG_DWORD /d "0" /f
timeout 5
goto :MainMenu
:defaultbrowser
echo Disabling setting as default browser...
Reg.exe add "HKLM\Software\Policies\Microsoft\Edge" /v "DefaultBrowserSettingEnabled" /t REG_DWORD /d "0" /f
timeout 5
goto :MainMenu
:sidebar
echo Disabling edge sidebar...
Reg.exe add "HKLM\Software\Policies\Microsoft\Edge" /v "HubsSidebarEnabled" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\Software\Policies\Microsoft\Edge" /v "StandaloneHubsSidebarEnabled" /t REG_DWORD /d "0" /f
timeout 5
goto :MainMenu
:shoppingassist
echo Disabling shopping assistant...
Reg.exe add "HKLM\Software\Policies\Microsoft\Edge" /v "EdgeShoppingAssistantEnabled" /t REG_DWORD /d "0" /f
timeout 5
goto :MainMenu
:sponsorednewtab
echo Disabling Sponsored links in new tab page...
Reg.exe add "HKLM\Software\Policies\Microsoft\Edge" /v "NewTabPageHideDefaultTopSites" /t REG_DWORD /d "1" /f
timeout 5
goto :MainMenu
:nosignin
echo Disabling browser sign in and sync services...
Reg.exe add "HKLM\Software\Policies\Microsoft\Edge" /v "BrowserSignin" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\Software\Policies\Microsoft\Edge" /v "ImplicitSignInEnabled" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\Software\Policies\Microsoft\Edge" /v "SyncDisabled" /t REG_DWORD /d "1" /f
timeout 5
goto :MainMenu
:insiderbanner
echo Disabling insider banner in the about page...
Reg.exe add "HKLM\Software\Policies\Microsoft\Edge" /v "MicrosoftEdgeInsiderPromotionEnabled" /t REG_DWORD /d "0" /f
timeout 5
goto :MainMenu
:userfeedback
echo Disabling user feedback option...
Reg.exe add "HKLM\Software\Policies\Microsoft\Edge" /v "UserFeedbackAllowed" /t REG_DWORD /d "0" /f
timeout 5
goto :MainMenu
:searchbar
echo Disabling search bar...
Reg.exe add "HKLM\Software\Policies\Microsoft\Edge" /v "SearchbarAllowed" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\Software\Policies\Microsoft\Edge" /v "SearchbarIsEnabledOnStartup" /t REG_DWORD /d "0" /f
timeout 5
goto :MainMenu
:guestmode
echo Disabling use of guest mode...
Reg.exe add "HKLM\Software\Policies\Microsoft\Edge" /v "BrowserGuestModeEnabled" /t REG_DWORD /d "0" /f
timeout 5
goto :MainMenu
:collections
echo Disabling collections feature...
Reg.exe add "HKLM\Software\Policies\Microsoft\Edge" /v "EdgeCollectionsEnabled" /t REG_DWORD /d "0" /f
timeout 5
goto :MainMenu
:startup
echo Disabling startup boost...
Reg.exe add "HKLM\Software\Policies\Microsoft\Edge" /v "StartupBoostEnabled" /t REG_DWORD /d "0" /f
timeout 5
goto :MainMenu
:uninstalledge
echo Uninstalling Microsoft Edge web browser is coming soon...

timeout 5
goto :MainMenu
:uninstalledgewebview
echo Uninstalling Microsoft Edge WebView2 is coming soon, check back later!

timeout 5
goto :MainMenu