@echo off
set prog="C:\ruby200-x64\bin\ruby.exe C:\Users\Browserstack\Documents\gitrepos\servuby\src\servuby_main.rb"
:LOOP
tasklist /FI "IMAGENAME eq ruby.exe" 2>NUL | find /I /N "ruby.exe">NUL
if "%ERRORLEVEL%" NEQ "0" start "%prog%"
timeout /t 1 /nobreak>NUL
goto LOOP
