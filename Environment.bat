@echo on
cd /d %~dp0

:: Set relevant paths for installation
set AtomPath=%programfiles%\Atom
set AtomInstallerPath=%cd%
set ZipFilePath=%AtomInstallerPath%\atom-x64-windows.zip
set ShortcutFilePath1=C:\Users\Public\Desktop\Atom.lnk
set ShortcutFilePath2=C:\ProgramData\Microsoft\Windows\Start Menu\Programs\Atom.lnk
exit /b
