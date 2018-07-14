; =============================================================================
; DO NOT MODIFY
; THIS IS AUTOMATICALLY GENERATED CODE
; Generated on 2018-07-13 20:56:12.044657
; With 'generate_ahk.py'
; =============================================================================

#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
#Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

#SingleInstance force

OldEndChars := Hotstring("EndChars")
NewEndChars := OldEndChars . "*"  ; Make '*' trigger hotstring replacement
Hotstring("EndChars", NewEndChars)

; ======== Hoststrings ========
::ab::abstract
::at::assert

::bl::boolean
::bk::break
::bt::byte
::u8::byte

::ca::case
::ct::catch
:c:ch::char
:c:Ch::Character
::cl::class
::cn::continue

::de::default
::db::double

::el::else
::en::enum

::ff::false
::fi::final
::co::final
::fy::finally
::fl::float

::ie::implements
::im::import
::iof::instanceof
:c:ii::int
:c:Ii::Integer
::ia::interface

::ll::long

::nv::native
::nw::new

::pk::package
::pr::private
::pd::protected
::pu::public

::rn::return

::sh::short
::sc::static
::st::String
::sp::super
::sw::switch
::sn::syncronized

::th::this
::tw::throw
::tws::throws
::ts::transient
::ty::try

::vd::void
::vo::volatile

::wh::while
