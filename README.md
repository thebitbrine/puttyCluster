# gSSH
## Group SSH / Multi-session / Multi-window input

Simple AutoHotkey script to enable sending input to multiple putty window simultaneously.

### Changes:
- Minimalistic UI
- Cleaned up source code
- Auto close PuTTY session upon exit
- Renamed to gSSH
- Works with CMD and Powershell (if you want to go borderless)
- Default 3x7 tile layout (Hard-coded for 1920x1080 output)
- Auto clear command upon login
- Auto restore minimized PuTTY windows (on 'Locate')
- Auto 'Find' and 'Tile' on startup
- Removed 'Find' background task because it was causing input issues with more than 10 session (now has to be done manually; with 'Locate')
- Refocus on main window after 'Locate'
- Input is now taken from any element (NOT RECOMMENDED)
- Auto borderless if possible (Only with CMD or PowerShell)
- Removed minimize button
- Startup on the lower right corner of the screen (above taskbar (50px))
- No save files on UI configs whatsoever (change source code)
- Increased transparency range

### Known bugs:
- Tabs show up in the text box
- Arrow keys, paste, auto-clear might not work with CMD -> Plink, CMD -> PowerShell -> Plink, configuration
- It might lose control of PuTTY windows in some rare cases


### license
* free as in free coffee and free as in free speech
* use at your own risk
