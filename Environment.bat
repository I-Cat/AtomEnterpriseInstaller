@echo on
cd /d %~dp0

:: SET relevant paths for installation
SET AtomPath=%Program Files%\Atom
SET AtomInstallerPath=%cd%
SET ZipFilePath=%AtomInstallerPath%\atom-x64-windows.zip
SET ShortcutFilePath1=C:\Users\Public\Desktop\Atom.lnk
SET ShortcutFilePath2=C:\ProgramData\Microsoft\Windows\Start Menu\Programs\Atom.lnk
exit /b

