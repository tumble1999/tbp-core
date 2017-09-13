@echo on
REM CHECK IF IN A TBP PROJECT
if not exist .tbp (
  goto :eof
)

git submodule sync
git submodule update

rem LOAD PROJECT LIBRARIES
for /d %%l in ("lib\*") do (
echo %%l
  set path=!cd!\%%l;!path!
  cd %%l
  call load-libs.bat
  uncd %%l
)

for %%l in ("lib\*.tbpl") do (
  echo %%l
  pause
  compiler %%l D
  set path=!cd!\%%~nl;!path!
  cd %%~nl
  call load-libs.bat
  uncd %%~nl
)
