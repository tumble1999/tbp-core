@echo off
cd ..
if not exist .git (
  git init
)
call update.bat
pause
