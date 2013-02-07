#NoTrayIcon
#SingleInstance Force
#NoEnv
SendMode Input

iniFilename := GetScriptBaseName()
iniFilename = %iniFilename%.ini

IniRead, defaultActualSize, %iniFilename%, Preference, actual_size, 0

#If WinActive("ahk_class ShImgVw:CPreviewWnd") or WinActive("ahk_class Photo_Lightweight_Viewer")
{
    Hotkey, MButton, L_MButton
    Hotkey, WheelUp, L_WheelUp
    Hotkey, WheelDown, L_WheelDown
    Hotkey, ^WheelUp, L_CtrlWheelUp
    Hotkey, ^WheelDown, L_CtrlWheelDown
    Hotkey, A, L_A
    Hotkey, F, L_F
    Hotkey, ^A, L_CtrlA
}

return

GetScriptBaseName()
{
    SplitPath, A_ScriptFullPath,,,,baseName, 
    Return baseName
}

PostAction()
{
    Global
    if defaultActualSize = 1
    {
        Send, ^!{0}
    }
    else
    {
        Send, ^{0}
    }
}

ToggleDefaultActualSize()
{
    Global
    if defaultActualSize = 0
    {
        defaultActualSize := 1
    }
    else
    {
        defaultActualSize := 0
    }
    IniWrite, %defaultActualSize%, %iniFilename%, Preference, actual_size
}

L_MButton:
	if WinActive("ahk_class ShImgVw:CPreviewWnd")
	{
		WinGet, WndSize, MinMax, ahk_class ShImgVw:CPreviewWnd
    }
    else if WinActive("ahk_class Photo_Lightweight_Viewer")
    {
        WinGet, WndSize, MinMax, ahk_class Photo_Lightweight_Viewer
    }
    
    if WndSize = 0
    {
        Send, {Alt}
        Send, {Space}
        Send, X
    }
    else
    {
        Send, {Alt}
        Send, {Space}
        Send, R
    }
return

L_WheelUp:
    if WinActive("ahk_class ShImgVw:CPreviewWnd")
	{
		Send, {PgUp}
	}
    else if WinActive("ahk_class Photo_Lightweight_Viewer")
	{
		Send, {Left}
	}
    PostAction()
return

L_WheelDown:
    if WinActive("ahk_class ShImgVw:CPreviewWnd")
	{
		Send, {PgDn}
	}
    else if WinActive("ahk_class Photo_Lightweight_Viewer")
	{
		Send, {Right}
	}
    PostAction()
return

L_CtrlWheelUp:
	Send, {WheelUp}
return

L_CtrlWheelDown:
	Send, {WheelDown}
return

L_A:
    Send, ^!{0}
return

L_F:
    Send, ^{0}
return

L_CtrlA:
    ToggleDefaultActualSize()
return