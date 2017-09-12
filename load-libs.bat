@if not "%1"=="debug" @echo off
REM CHECK IF IN A TBP PROJECT
if not exist .tbp (
  goto :eof
)
pause

REM LOAD PROJECT LIBRARIES
if "%~dp0"=="%cd:"=%" (
  for /d %%L in ("lib\*") do (
    set path=%cd%\%%L
    set %cd%=path
    cd %%L
    start /wait load-libs.bat
    cd../..
  )
)
