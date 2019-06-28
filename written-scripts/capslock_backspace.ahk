#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
#Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

#SingleInstance force


; ======== Remap Keys ========
#InputLevel, 50
CapsLock::Backspace
#CapsLock::CapsLock
#Backspace::CapsLock
#InputLevel, 0
