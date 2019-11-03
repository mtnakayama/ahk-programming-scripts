; Creates turns on CapsLock with Win+Backspace.\
; This is useful for Colemak layouts with remapped CapsLock keys.

#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
#Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

#SingleInstance force

; ======== Remap Keys ========
Tab::Tab
Tab & f::^z
Tab & w::^y
Tab & t::^f
Tab & [::Send, {{}{Enter}

Tab & l::^Left
Tab & u::Up
Tab & y::^Right

Tab & n::Left
Tab & e::Down
Tab & i::Right
Tab & o::Delete
Tab & Enter::Send, {End}{Enter}


Tab & h::Home
Tab & .::End
Tab & `;::Send, {End};{Enter}
