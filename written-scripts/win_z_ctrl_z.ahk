; Creates turns on CapsLock with Win+Backspace.\
; This is useful for Colemak layouts with remapped CapsLock keys.

#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
#Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

#SingleInstance force

; ======== Remap Keys ========
#z::Send ^z
^!x::Send ^z
!Space::Send ^z
