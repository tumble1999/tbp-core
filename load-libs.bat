@echo off
REM CHECK IF IN A TBP PROJECT
if not exist .tbp (
  goto :eof
)

rem LOAD PROJECT LIBRARIES
for /d %%L in ("lib\*") do (
  set lib=%%L
  set path=!cd!\!lib!;!path!
  cd !lib!
  call load-libs.bat
  cd ../..
)

for /d %%L in ("lib\*.tbpl") do (
  set lib=%%L
  project-tools\compile !lib! D L
  set path=!cd!\!lib:0,-5!;!path!
  cd !lib!
  call load-libs.bat
  cd ../..
)
