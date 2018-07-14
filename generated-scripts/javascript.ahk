; =============================================================================
; DO NOT MODIFY
; THIS IS AUTOMATICALLY GENERATED CODE
; Generated on 2018-07-13 23:33:00.366125
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
::us::'use strict';

::ar::Array

::bk::break

::ca::case
::ct::catch
::cl::class
::cg::console.log
::pt::console.log
::co::const
::cn::continue

::dg::debugger
::de::default
::dl::delete
::dc::document

::el::else
::ep::export
::ex::extends

::ff::false
::fy::finally
::fn::function

::im::import
::iof::instanceof

::le::let

::ma::Math

::nw::new
::nn::null

::ob::Object

::pp::prototype

::rn::return

::sp::super
::sw::switch

::th::this
::tw::throw
::tt::true
::ty::try
::tf::typeof

::ud::undefined

::vr::var
::vd::void

::wn::window
::wt::with

::yd::yield
