# Atom Enterprise Installer
This script allows you to install Atom inside the ProgramFiles directory or a directory of your choice.
It makes use of the Atom Zip package which is distributed alongside their exe automated installation.

## Usage
1. Download all three batch (.bat) files and put them inside one folder.
2. Download the atom-x64-windows.zip from [here](https://github.com/atom/atom/releases) and put the **ZIP file** in the same folder.
3. (Optional) Change the Installation directory in **Enviroment.bat** to suit your needs.
4. Execute the Install.bat with Administrator privileges.
5. Enjoy using Atom!

**Note: Automatic updates are disabled for the ZIP distributable**
## Why should I use this installer?
The current Atom Installer exe doesn't have any good working or well-supported way to make any changes to the installation process.
The squirrel-based installer opens without giving you the chance for changing the installation directory or choosing not to create a desktop shortcut.
Hence I created this simple Installer script to make life easier for enterprise administrators or people that just want to customize their Atom installation.

## What does the installer do?
- Delete a current installation if it's installed under the path that is specified Environment.bat
- Unzip the package
- Copy it to a specified path (%programfiles% by default)
- Change the owner of the Atom folder to SYSTEM
- Unblock the "untrusted program" with powershell
- Create shortcuts for Desktop and Start Menu
- Uninstall Atom if you choose to
