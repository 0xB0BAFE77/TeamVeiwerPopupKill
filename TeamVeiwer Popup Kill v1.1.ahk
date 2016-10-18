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

; Run the scan every 2.25 seconds.
; 2.5 seconds is used to even out a max possible 5 second delay
; between each TVCheck interval.
SetTimer, TVCheck, 2000

return

;============================== Main Script ==============================

TVCheck:
	; If Sponsored Session and TeamViewer are not the current active window,
	; then set whatever is active as the "last window open".
	IfWinNotExist, Sponsored session
	{
		IfWinNotActive, TeamViewer
			LastID	:= WinExist("A")
	}
	
	; If Sponsoered Session popup is found, activate it and press enter.
	; Now activate whatever the last window was.
	IfWinExist, Sponsored session
	{
		MsgBox Found sponsred
		Sleep, 250
		WinActivate, Sponsored session
		Sleep, 250
		Send, {Enter}
		Sleep, 500
		WinActivate, % "ahk_id " LastID
	}
	
	; If TeamViewer window is found, force win close then activate last window.
	IfWinExist, TeamViewer
	{
		Winactivate, TeamViewer
		MsgBox Found Teamviewere
		Sleep, 250
		WinClose, TeamViewer
		Sleep, 500
		WinActivate, % "ahk_id " LastID
	}

; This whole process will repeat every 2.5 seconds.
; Enjoy the script and pay it forward.
return
