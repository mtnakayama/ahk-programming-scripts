; date.ahk
; Output the date in a commonly used format

#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
#Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

#SingleInstance force


; Output the date in dashed "extended" ISO 8601 format.
#F12::
SendInput %A_YYYY%-%A_MM%-%A_DD%
return

; Output the date in "basic" ISO 8601 format.
^#F12::
SendInput %A_YYYY%%A_MM%%A_DD%
return

; Output the date and time in ISO 8601 format.
!#F12::
SendInput %A_YYYY%-%A_MM%-%A_DD%T%A_Hour%:%A_Min%:%A_Sec%
return
