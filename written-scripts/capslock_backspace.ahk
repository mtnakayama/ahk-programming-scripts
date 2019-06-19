#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
#Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

#SingleInstance force

; ======== Toggle Script ========
EnableScript := True
#CapsLock::
    Suspend, Permit
    EnableScript := not EnableScript
    if (EnableScript) {
        Suspend, Off
        TrayMessage := "Enabled"
    }
    else {
        Suspend, On
        TrayMessage := "Suspended"
    }
    TrayTip, CapsLock-Backspace, %TrayMessage%, 1, 0x11
    Return


; ======== Remap Keys ========
CapsLock::Backspace
+CapsLock::CapsLock
