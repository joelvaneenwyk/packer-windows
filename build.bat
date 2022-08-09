@echo off

setlocal EnableDelayedExpansion

set _python_user_root=C:\Users\%USERNAME%\AppData\Roaming\Python\Python310
set _python_root=C:\Users\%USERNAME%\AppData\Local\Programs\Python\Python310
set _python=%_python_root%\python.exe
set PATH=%PATH%;C:\Program Files\Oracle\VirtualBox;%_python_root%\Scripts;%_python_user_root%\Scripts

:: "%_python%" -m pip install --upgrade pip
:: "%_python%" -m pip install --user ansible

echo ##[cmd] packer build -only=virtualbox-iso "%~dp0windows_7.json"
packer build -only=virtualbox-iso "%~dp0windows_7.json"
