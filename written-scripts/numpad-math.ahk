#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
#Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
#SingleInstance force

NumpadAdd & Numpad7::SendInput x
NumpadAdd & Numpad8::SendInput (
NumpadAdd & Numpad9::SendInput )
NumpadAdd & NumpadMult::SendInput {^}

NumpadAdd & Numpad4::SendInput {=}
NumpadAdd & Numpad5::SendInput <
NumpadAdd & Numpad6::SendInput >

NumpadAdd::SendInput {+}