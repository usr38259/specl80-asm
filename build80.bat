@echo off
if '%1' == '' goto usage
tasm %1,,
if ERRORLEVEL 1 goto asme
tlink /n /x %1.obj,
if ERRORLEVEL 1 goto lnke
if EXIST %1.bin del %1.bin
exe2bin %1.exe %1.bin
if ERRORLEVEL 1 goto bine
if NOT EXIST %1.bin goto bine
echo.
echo Done. Assembling '%1.asm' is successful.
echo.
goto exit
:asme
echo Error when assembling `%1.asm`.
goto exit
:lnke
echo Error when linking `%1.obj`.
goto exit
:bine
echo Error when creating `%1.bin`.
goto exit
:usage
echo Build Intel 8080 assembly with MACROS80.INC helper
echo Usage:
echo build80 file-name
echo File name must not have an extension.
:exit
