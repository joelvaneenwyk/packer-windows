@echo off

setlocal EnableDelayedExpansion

set _python_user_root=C:\Users\%USERNAME%\AppData\Roaming\Python\Python310
set _python_root=C:\Users\%USERNAME%\AppData\Local\Programs\Python\Python310
set _python=%_python_root%\python.exe
set PATH=%PATH%;%~dp0bin;C:\Program Files\Oracle\VirtualBox;%_python_root%\Scripts;%_python_user_root%\Scripts

set _option=%~1
if "%_option%"=="" set _option=windows_7.pkr.hcl
if "%~1"=="" (
    set _filter=virtualbox-iso.*
) else (
    set _filter=hyperv-iso
)
shift

cd /d "%~dp0templates"

echo ##[cmd] packer build -only=!_filter! "!_option!" %1 %2 %3 %4 %5 %6 %7 %8 %9
packer build -only=!_filter! "!_option!" %1 %2 %3 %4 %5 %6 %7 %8 %9
