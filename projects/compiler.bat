rem @if not "%1"=="debug" @echo off
setlocal EnableDelayedExpansion

if "%1"=="" (
  goto :incorrect-syntax
)

if "%2"=="D" (
  call :decompile %1
) else (
  if "%3"=="L" (
    set ext=.tbpl
  ) else (
    set ext=.tbp
  )
  call :compile %1 !ext! %4
)

goto :eof


:incorrect-syntax
echo Incorrect Syntax.
goto :eof


:compile
powershell -Command "Compress-Archive -U -Path %1\* -DestinationPath %1"
if "%3"=="i" (
rename %1.zip data%2
copy "%~dp0installer.bat" "%~n1-installer.bat"
mkdir "%~0installer-files"
move "%~dp1data%2" "%~0installer-files"
move "%~dp1%~n1-installer.bat" "%~0installer-files"
powershell -Command "Compress-Archive -U -Path '%~0installer-files\*' -DestinationPath %1"
del "%~0installer-files" /y
) else (
rename %1.zip %~n1%2
)
goto :eof

:decompile
rename %1 %~dpn1.zip
mkdir %~dpn1
powershell -Command "Expand-Archive -LiteralPath %~dpn1.zip -DestinationPath %~dpn1"
goto :eof
