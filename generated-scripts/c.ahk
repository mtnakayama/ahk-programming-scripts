; =============================================================================
; DO NOT MODIFY
; THIS IS AUTOMATICALLY GENERATED CODE
; Generated on 2018-07-13 22:08:22.354215
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
::df::{#}define
::ei::{#}endif
::ifd::{#}ifdef
::ifn::{#}ifndef
::im::{#}include
::ic::{#}include

::at::assert

::bl::bool
::bk::break

::cc::calloc
::ca::case
::ch::char
::co::const
::ccs::const char*
::cn::continue

::de::default
::db::double

::en::enum

::ff::false
::fl::float
::fr::free

::il::inline
::ii::int
::i1::int16_t
::i3::int32_t
::i6::int64_t
::i8::int8_t

::ll::long

::mc::malloc

::nn::NULL

::rc::realloc
::rn::return

::sh::short
::sg::signed
::sf::sizeof
::sz::size_t
::sc::static
::sr::struct
::sw::switch

::tt::true
::td::typedef

::u1::uint16_t
::u3::uint32_t
::u6::uint64_t
::u8::uint8_t
::uo::union
::ug::unsigned

::vd::void
::vo::volatile

::wh::while
