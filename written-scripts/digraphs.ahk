; Swaps commonly used symbols to easy to reach places.

#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
#Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

#SingleInstance force


; ======== Remap Keys ========
::sr::{!}
::ts::{#}


::uy::{+}
::uyuy::{+}{+}
::lu::&
::lulu::&&
::ei::*
::eiei::**

:o:ne::;{Enter}
