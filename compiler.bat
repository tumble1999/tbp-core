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
set comDir=%~dp1
if "%~5"=="ci" (
  set comDir="%~1\ci\"
) else (
  if "%~4"=="ci" set comDir="%~1\ci\"
)
powershell -Command "Compress-Archive -U -Path "%~1\*" -DestinationPath %comDir:"=%%~n1"
if "%~4"=="i" (
  rename "%comDir:"=%%~n1.zip" data!ext:"=!
  mkdir "%~dp0installer-files"
  move "%comDir:"=%data!ext:"=!" "%~dp0installer-files"
  copy "%~dp0installer.bat" "%~dp0installer-files\%~n1-installer.bat"
  powershell -Command "Compress-Archive -U -Path '%~dp0installer-files\*' -DestinationPath '%comDir:"=%%~n1'"
  del "%~dp0installer-files\*" /q
) else (
  rename "%comDir:"=%%~n1.zip" %~n1!ext:"=!
)
goto :eof

:decompile
copy %1 "%~dpn1.zip"
mkdir "%~dpn1"
powershell -Command "Expand-Archive -LiteralPath %~dpn1.zip -DestinationPath %~dpn1"
del "%~dpn1.zip" /q
goto :eof
