@if not "%1"=="debug" @echo off
setlocal enabledelayedexpansion

if ""%1"=="" (
  goto :incorrect-syntax
)

if "%3"=="P" (
  set ext=.tbp
  goto :type-chosen
)
if "%3"=="L" (
  set ext=.tbpl
  goto :type-chosen
) else (
  set ext=%~x1
  if not defined ext (
    set ext=.tpb
  ) else (
    if not %ext%==.tbp* (
      echo Incorrect file format.
      goto :eof
    )
  )

)
:type-chosen

if "%3"=="C" (
  goto :compile
)
if "%3"=="D" (
  goto :decompile
) else (
  if "%~x1"=="" (
    goto :compile
  ) else (
    goto :decompile
  )
)

goto :eof


:incorrect-syntax
echo Incorrect Syntax.
goto :eof


:compile
powershell -Command "Compress-Archive -U -Path %1\* -DestinationPath %1"
rename %1.zip %1%ext%
goto :eof

:decompile
rename %1 %~dpn1.zip
mkdir %~dpn1
powershell -Command "Expand-Archive -LiteralPath %~dpn1.zip -DestinationPath %~dpn1"
goto :eof
