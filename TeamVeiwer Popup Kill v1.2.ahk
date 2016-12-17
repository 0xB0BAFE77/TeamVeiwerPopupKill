; Written by 0xB0BAFE77
; This program is free of charge and should only be obtainable at my github address.
; https://github.com/0xB0BAFE77/TeamVeiwerPopupKill

; Enjoy and pay it forward.

;============================== Start Auto-Execution Section ==============================

; Keeps script permanently running
#Persistent

; Avoids checking empty variables to see if they are environment variables.
; Recommended for performance and compatibility with future AutoHotkey releases.
#NoEnv

; Ensures that there is only a single instance of this script running.
#SingleInstance, Force

;Makes sure invisible windows are "seen" by the script.
DetectHiddenWindows, Off

; Makes a script unconditionally use its own folder as its working directory.
; Ensures a consistent starting directory.
SetWorkingDir %A_ScriptDir%

; Strict search. Must contain ONLY the title provided
SetTitleMatchMode, 3

; sets the key send input type. Event is used to make use of KeyDelay.
SendMode, Event

; Sets delay between key strokes and how long a key should be pressed.
; SetKeyDelay KeyStrokeDelay, 
SetKeyDelay 50, 25

; Bundles sys tray icon with exe.
FileInstall, TVAntiPop.ico, % A_ScriptDir , 1

; Changes sys tra icon
Menu, Tray, Icon, % "TVAntiPop.ico"

sidePanelActive	:= 0
activateWin		:= 0

; Run the scan
SetTimer, TVCheck, 100

return

;============================== Main Script ==============================

TVCheck:
	
	; If Sponsored Session, ControlWin and TeamViewer are not the current active window,
	; then set whatever is active as the "last window open".
	IfWinNotActive, ahk_class TV_ControlWin
		IfWinNotExist, Sponsored session
			IfWinNotActive, TeamViewer
					LastID	:= WinExist("A")
	
	; Checks for presence of side panel to determine if user is logged in.	
	IfWinExist, ahk_class TV_ControlWin
		sidePanelActive	:= 1
	
	; Checks to see if user was just logged in.
	; If yes, reset tracking var, sleep 2 seconds, and then activate LastID
	if (sidePanelActive = 1)
		IfWinNotExist, ahk_class TV_ControlWin
		{
			sidePanelActive	:= 0
			activateWin		:= 1
		}
	
	; If TeamViewer window is found, force win close then activate last window.
	IfWinExist, TeamViewer
	{
		Sleep, 50
		WinClose, TeamViewer
		activateWin		:= 1
	}
	
	; If Sponsoered Session popup is found, activate it and press enter.
	; Now activate whatever the last window was.
	IfWinExist, Sponsored session
	{
		ControlClick, Button4, Sponsored session
		activateWin		:= 1
	}
	
	if (activateWin = 1)
		GoSub, restoreWin

; This whole process will repeat.
; Enjoy the script and pay it forward.
return

restoreWin:
	Sleep, 1000
	WinActivate, % "ahk_id " LastID
	Sleep, 3000
	WinActivate, % "ahk_id " LastID
	activateWin	:= 0
	Sleep, 500
return
