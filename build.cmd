
@ECHO OFF
SETLOCAL EnableDelayedExpansion

SET BUILD_DIR=build

DEL /Q %BUILD_DIR%\*.*
FOR /R %%I IN (languages\*.yml) DO (CALL :generate_files "%%I")

GOTO :eof


REM subroutine
:generate_files
    ECHO "%1 > %BUILD_DIR%\%~n1.ahk"
    python generate_ahk.py dictionary.yml %1 "%BUILD_DIR%\%~n1.ahk"
GOTO :eof
