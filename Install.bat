@echo on
setlocal
cd /d %~dp0

::Call environment configuration file
Call ".\Environment.bat"

:: Check for administrator privileges
call :IsAdmin
if %errorlevel% == 0 (
echo Running with admin rights.
) else (
echo Error: Access denied. Run this script as administrator.
exit /b 5
)

:: Running the uninstall script to repair existing installs
call "%AtomInstallerPath%\Uninstall.bat"

:: Check whether the temporary folder already exists and delete it if it does
if exist "%AtomInstallerPath%\Atom" rmdir /q /s "%AtomInstallerPath%\Atom"

:: Call unzip script which extracts to "%AtomInstallerPath%\Atom"
call :UnZipFile "%AtomInstallerPath%\Atom" "%ZipFilePath%"

:: Copy To Program Files Path
mkdir "%AtomPath%"
xcopy "%AtomInstallerPath%\Atom\Atom x64" "%AtomPath%" /s /h /q /y

:: Change ownership to SYSTEM
icacls "%AtomPath%" /setowner SYSTEM /t

:: Unblock using powershell
powershell -command "Get-ChildItem -Path '%AtomPath%' -Recurse | Unblock-File"

:: Create those shortcuts
call :CreateShortcut "%ShortcutFilePath1%" "%AtomPath%\atom.exe"
call :CreateShortcut "%ShortcutFilePath2%" "%AtomPath%\atom.exe"

:: Create registry keys for URI Handler
reg add HKCR\atom /ve /d URL:atom /f
reg add HKCR\atom /v "URL Protocol" /f
reg add HKCR\atom\shell\open\command /ve /d "\"C:\Program Files\Atom\atom.exe\" --uri-handler -- \"%1\"" /f

:: Second key generated - Experimental
:: reg add HKLM\SOFTWARE\Classes\atom /ve /d URL:atom /f
:: reg add HKLM\SOFTWARE\Classes\atom /v "URL Protocol" /f
:: reg add HKLM\SOFTWARE\Classes\atom\shell\open\command /ve /d "\"C:\Program Files\Atom\atom.exe\" --uri-handler -- \"%1\"" /f


:: Cleanup
if exist "%AtomInstallerPath%\Atom" rmdir /q /s "%AtomInstallerPath%\Atom"

pause
exit /b


:: Functions

:UnZipFile <ExtractTo> <newzipfile>
set unzipvbs="%AtomInstallerPath%\unzipscript.vbs"
if exist %unzipvbs% del /f /q %unzipvbs%
>%unzipvbs%  echo Set fso = CreateObject("Scripting.FileSystemObject")
>>%unzipvbs% echo If NOT fso.FolderExists(%1) Then
>>%unzipvbs% echo fso.CreateFolder(%1)
>>%unzipvbs% echo End If
>>%unzipvbs% echo set objShell = CreateObject("Shell.Application")
>>%unzipvbs% echo set FilesInZip=objShell.NameSpace(%2).items
>>%unzipvbs% echo objShell.NameSpace(%1).CopyHere(FilesInZip)
>>%unzipvbs% echo Set fso = Nothing
>>%unzipvbs% echo Set objShell = Nothing
cscript //nologo %unzipvbs%
if exist %unzipvbs% del /f /q %unzipvbs%
goto :eof

:CreateShortcut <ShortcutLocation> <TargetPath>
set shortcutvbs="%AtomInstallerPath%\shortcutscript.vbs"
if exist %shortcutvbs% del /f /q %shortcutvbs%
>%shortcutvbs% echo Set oWS = WScript.CreateObject("WScript.Shell")
>>%shortcutvbs% echo sLinkFile = %1
>>%shortcutvbs% echo Set oLink = oWS.CreateShortcut(sLinkFile)
>>%shortcutvbs% echo oLink.TargetPath = %2
>>%shortcutvbs% echo oLink.Save
cscript //nologo %shortcutvbs%
if exist %shortcutvbs% del /f /q %shortcutvbs%
goto :eof

:IsAdmin
fsutil dirty query %systemdrive% >nul
goto :eof
