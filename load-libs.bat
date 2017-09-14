rem @echo off
setlocal EnableDelayedExpansion
echo Loading Libraries...
REM CHECK IF IN A TBP PROJECT
if not exist .tbp (
  goto :eof
)


call if "%%PATH:%cd%=%%"=="%PATH%" (
  set PATH=%cd:"=%;%PATH%
)


for %%l in ("lib\*.tbpl") do (
  if not exist "%%~dpnl" (
    call "%~dp0compiler.bat" %%l D
  )
)


git submodule sync
git submodule update


rem LOAD PROJECT LIBRARIES
for /d %%l in ("lib\*") do (
  set lib=%%l
  call if "%%~$PATH:l"=="" (
    set PATH=!cd:"=!\%%~l;!PATH!
    echo PATH:!PATH!
  )
  cd !lib!

  if not "%cd:!lib!=%"=="%cd:"=%" (
    if exist lib/* (
      load-libs
    )
  )


  cd ../..
)
