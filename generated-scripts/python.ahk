; =============================================================================
; DO NOT MODIFY
; THIS IS AUTOMATICALLY GENERATED CODE
; Generated on 2018-07-13 22:48:53.752552
; With 'generate_ahk.py'
; =============================================================================

#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
#Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

#SingleInstance force

OldEndChars := Hotstring("EndChars")
NewEndChars := OldEndChars . "*<>"  ; Make '*<>' trigger hotstring replacement
Hotstring("EndChars", NewEndChars)

; ======== Hoststrings ========
::pr::@property

::at::assert

::bk::break

::cl::class
::cn::continue

::df::def

::ex::except
::ct::except

::ff::False
::fy::finally

::gl::global

::im::import

::lm::lambda

::nn::None
::nl::nonlocal
::nt::not

::ob::Object

::ps::pass
::nop::pass
::pt::print

::ra::raise
::tw::raise
::rn::return

::th::self
::sf::self
::st::str
::sp::super

::tt::True
::ty::try

::wh::while
::wt::with

::yd::yield

::nit::__init__
