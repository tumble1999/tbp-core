@echo off
echo Loading Libraries...
REM CHECK IF IN A TBP PROJECT
if not exist .tbp (
  goto :eof
)

for %%l in ("lib\*.tbpl") do (
  %~dp0compiler %%l D
)

git submodule sync
git submodule update

rem LOAD PROJECT LIBRARIES
for /d %%l in ("lib\*") do (
    set PATH=!cd:"=!\%%~l;!PATH!
    cd %%l
    load-libs
    cd ../..
)
