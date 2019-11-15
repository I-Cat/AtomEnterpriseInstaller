@echo on
setlocal
cd /d %~dp0

::Call environment configuration file
Call ".\Environment.bat"

:: Check for administrator privileges
call :isAdmin
if %errorlevel% == 0 (
echo Running with admin rights.
) else (
echo Error: Access denied. Run this script as administrator.
exit /b 5
)

:: Delete those shortcuts
if exist "%ShortcutFilePath1%" del /f /q "%ShortcutFilePath1%"
if exist "%ShortcutFilePath2%" del /f /q "%ShortcutFilePath2%"

:: Delete Atom installation
if exist "%AtomPath%" rmdir /q /s "%AtomPath%"

exit /b 0

:: Functions

:isAdmin
fsutil dirty query %systemdrive% >nul
goto :eof
