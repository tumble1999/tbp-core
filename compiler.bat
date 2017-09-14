@echo off
setlocal EnableDelayedExpansion

if "%~1"=="" (
  goto :incorrect-syntax
)

if "%2"=="D" (
  call :decompile "%~1"
) else (
  if "%3"=="L" (
    set ext=.tbpl
  ) else (
    set ext=.tbp
  )
  goto :compile
)

goto :eof


:incorrect-syntax
echo Incorrect Syntax.
echo compiler.bat [folder/file] [operation C or D] [type P or L] [i]
goto :eof


:compile
set compDir=%~dp1
if "%5"=="ci" set comDir=%~dp1\ci
powershell -Command "Compress-Archive -U -Path "%compDir%%~n1\*" -DestinationPath %1"
if "%~4"=="i" (
  rename "%compDir%%~n1.zip" data!ext:"=!
  mkdir "%~dp0installer-files"
  move "%compDir%data!ext:"=!" "%~dp0installer-files"
  copy "%~dp0installer.bat" "%~dp0installer-files\%~n1-installer.bat"
  powershell -Command "Compress-Archive -U -Path '%~dp0installer-files\*' -DestinationPath '%compDir%%~n1'"
  del "%~dp0installer-files\*" /q
) else (
  if "%4"=="ci" set comDir=%~dp1\ci
  rename "%compDir%%~n1.zip" %~n1!ext:"=!
)
goto :eof

:decompile
copy %1 "%~dpn1.zip"
mkdir "%~dpn1"
powershell -Command "Expand-Archive -LiteralPath %~dpn1.zip -DestinationPath %~dpn1"
del "%~dpn1.zip" /q
goto :eof
