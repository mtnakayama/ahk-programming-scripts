#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
#Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

#SingleInstance force

; ======== Add Hotstring EndChars ========
#Hotstring EndChars -()[]{}':;/\,.?!`n `t*<>&

; ======== Toggle Script Key ========
EnableScript := True
#c::
    Suspend, Permit
    EnableScript := not EnableScript
    if (EnableScript) {
        Suspend, Off
        TrayMessage := "Enabled"
    }
    else {
        Suspend, On
        TrayMessage := "Suspended"
    }
    TrayTip, Python Hotstrings, %TrayMessage%, 1, 0x11
    Return

; ======== Hoststrings ========
::af::AFTER
::al::ALTER
::bf::BEFORE
::bl::BOOLEAN
::co::CONSTRAINT
::cr::CREATE
::de::DELETE
::fn::FUNCTION
::fo::FOREIGN KEY
::ii::INT
::ir::INSERT
::nn::NOT NULL
::pr::PRIMARY KEY
::rf::REFERENCES
::tb::TABLE
::tg::TRIGGER
::ud::UPDATE
::vc::VARCHAR

