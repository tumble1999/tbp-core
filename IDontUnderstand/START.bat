@echo off
cd ..
if not exist .git (
  git init
)
call tbp.bat
