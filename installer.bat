@echo off
setlocal EnableDelayedExpansion
rem extracts data.tbp

set name=%~n0
set name=%name:-installer=%
mkdir %name%

copy data.tbp data.zip
powershell -Command "Expand-Archive -LiteralPath data.zip -DestinationPath %name%"
del data.zip /q
