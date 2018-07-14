; =============================================================================
; DO NOT MODIFY
; THIS IS AUTOMATICALLY GENERATED CODE
; Generated on 2018-07-13 22:20:37.857780
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
::au::auto

::bl::bool
::bk::break

::cc::calloc
::ca::case
::ch::char
::cl::class
::co::const
::ccs::const char*
::cx::constexpr
::coct::const_cast
::cn::continue

::dt::decltype
::de::default
::dl::delete
::db::double
::dyct::dynamic_cast

::en::enum
::et::explicit
::ep::export

::ff::false
::fl::float
::fr::free
::fd::friend

::il::inline
::ii::int
::i1::int16_t
::i3::int32_t
::i6::int64_t
::i8::int8_t

::ll::long

::mc::malloc
::mu::mutable

::ns::namespace
::nw::new
::nx::noexcept
::nn::NULL
::np::nullptr

::op::operator

::pr::private
::pd::protected
::pu::public

::rc::realloc
::rict::reinterpret_cast
::rq::requires
::rn::return

::sh::short
::sg::signed
::sf::sizeof
::sz::size_t
::sc::static
::scct::static_cast
::sr::struct
::sw::switch

::tp::template
::th::this
::trlc::thread_local
::tw::throw
::tt::true
::ty::try
::td::typedef
::ti::typeid
::tn::typename

::u1::uint16_t
::u3::uint32_t
::u6::uint64_t
::u8::uint8_t
::uo::union
::ug::unsigned
::us::using

::vt::virtual
::vd::void
::vo::volatile

::wch::wchar_t
::wh::while
