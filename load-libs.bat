@echo off
echo Loading Libraries...
REM CHECK IF IN A TBP PROJECT
if not exist .tbp (
  goto :eof
)

for %%l in ("lib\*.tbpl") do (
  compiler %%l D
)

git submodule sync
git submodule update

rem LOAD PROJECT LIBRARIES
for /d %%l in ("lib\*") do (
  if "%~$PATH:1"=="" (
    set path=!cd!\%%l;!path!
    cd %%l
    load libs
    cd ../..
  )
)
