@echo off
REM CHECK IF IN A TBP PROJECT
if not exist %cd%\.tbp (
  goto :eof
)

for %%l in ("lib\*.tbpl") do (
  if exist %%~dpnl (
    rmdir "%%~dpnl" /q /s
  )
)
