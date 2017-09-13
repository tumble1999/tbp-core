@echo off
REM CHECK IF IN A TBP PROJECT
if not exist .tbp (
  goto :eof
)

REM LOAD PROJECT LIBRARIES
for /d %%L in ("lib\*") do (
  set path=%cd%\%%L;%path%
  set %cd%=path
  cd %%L
  start /wait load-libs.bat
  cd../..
)

for /d %%L in ("lib\*.tbpl") do (
  project-tools\compile %%L D L
  set file=%%L
  set path=%cd%\%file:0,-5%;%path%
  set %cd%=path
  cd %%L
  start /wait load-libs.bat
  cd../..
)

exit
