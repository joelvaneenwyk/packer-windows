::
:: "alias" for 'ansible-playbook' that Packer can use for the Ansible provisioner when
:: running in cmd/powershell which redirects to WSL.
::
@echo off

set "args=%*"

:: Replace backslashes with slashes
call set args=%%args:\=/%%

:: Fix drive letters
call set args=%%args:C:=/windir/c%%
call set args=%%args:D:=/windir/d%%
call set args=%%args:E:=/windir/e%%

call set args=%%args:/"=%%
call set args=%%args:"'='%%
call set args=%%args:'"='%%
call set args=%%args:"=^'%%

"C:\Windows\System32\bash.exe" -c "ansible-playbook %args%"
