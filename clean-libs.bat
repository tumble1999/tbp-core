@echo off
REM CHECK IF IN A TBP PROJECT
if not exist .tbp (
  goto :eof
)

for %%l in ("lib\*.tbpl") do (
  if exist %%~dpnl (
    del "%%~dpnl" /q
  )
)
