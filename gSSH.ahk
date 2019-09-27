#SingleInstance force
#NoTrayIcon
#WinActivateForce
SendMode Input

Gui, Add, Edit, x11 w172 WantTab ReadOnly, 
Gui, Add, button, X10 y32 gLocate -default, Locate
Gui, Add, button, X57 y32 gGoPaste -default, Paste
Gui, Add, button, X98 y32 gTile -default, Tile
Gui, Add, button, X129 y32 gCascade -default, Cascade
Gui, Add, Slider, x10 Range10-255 w172 gFind, 255
Gui, -MinimizeBox
Gui, Show, x1720 y911, gSSH
SetTitleMatchMode, RegEx

onMessage(0x100,"key")	; key down
onMessage(0x101,"key")	; key up
onMessage(0x104,"key")	; alt key down
onMessage(0x105,"key")	; alt key down

width := 640
height := 148
global found := 0

xstep := 30
ystep := 40

Gosub, Find
Gosub, Tile
Gosub, GoClean
WinActivate, gSSH



key(wParam, lParam,msg, hwnd)
{ 
	global paste
		if (paste ==1) {
			return
			}
	GuiControlGet, currentInput, Focus	
	ControlSetText, Edit1, 
	global id
	Loop, %id%
		{
			this_id := id%A_Index%		
			if(this_id >0){
				PostMessage, %msg%,%wParam%, %lParam%, ,ahk_id %this_id%,
			}		
		} 
	}
return 

GuiClose:
	SetTimer, Find, Off
	Gosub, Find 
	Loop, %id%
		{
			this_id := id%A_Index%		
			if(this_id > 0){
					WinKill, ahk_id %this_id%
			}
		}
ExitApp

Tile:
	Gosub, Find 
	x:=0
	y:=0
	Loop, %id%
		{
		this_id := id%A_Index%		
			if( this_id > 0){
					WinMove, ahk_id %this_id%,, x,y,width,height
					x:=x+width
					if( (x+width) > A_ScreenWidth){
						x:=0
						y:=y+height
					}
			}
		}
return
	
Cascade:
	Gosub, Find 
	x:=0
	y:=0
	Loop, %id%
		{
		this_id := id%A_Index%		
			if( this_id > 0){
					WinMove, ahk_id %this_id%,, x,y,width,height				
					x:=x+xstep
					y:=y+ystep
			}
		}
return
	
	
GoClean:
	Gosub, Find
	Loop, %id%
		{
			this_id := id%A_Index%		
			if( this_id >0 ){
				WinActivate, ahk_id %this_id%
				SendInput, c
				SendInput, l
				SendInput, e
				SendInput, a
				SendInput, r
				SendInput, {enter}
				
			}
		}
return 

GoPaste:
	Gosub, Find 
	paste=1
	clipboard=%clipboard%
	Loop, %id%
		{
		this_id := id%A_Index%		
			if( this_id >0 ){
				WinActivate, ahk_id %this_id%			
				SendRaw, %clipboard%		
			}
		}	
	paste=0
return

Locate:	
		Gosub, Find 
		Loop, %id%
		{
			this_id := id%A_Index%
			if( this_id >0){
				WinRestore, ahk_id %this_id%
				WinActivate, ahk_id %this_id%,
			}
		}	
	WinActivate, gSSH
	return 

Find:
	gui, Submit, nohide
		WinGet,id, list, (root)|(PuTTY)
		notPutty := 0
		Loop, %id%
		{
			this_id := id%A_Index%
			WinGet, name, ProcessName, ahk_id %this_id%,
			if(name != "putty.exe" && name != "kitty.exe" && name != "powershell.exe" && name != "cmd.exe"){
				notPutty++
				id%A_Index%=""
			}
		}
	found := id - notPutty

Alpha:
	GuiControlGet, alpha, ,msctls_trackbar321
	Loop, %id%
	{
		this_id := id%A_Index%	
		if(id%A_Index% >0){
			WinSet, Transparent, %alpha%, ahk_id %this_id%
		}	
	}
return
