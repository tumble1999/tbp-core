@echo off
REM CHECK IF IN A TBP PROJECT
if not exist .tbp (
  goto :eof
)

for /d %%l in ("lib\*") do (
  if exist "%%~dpnl.tbpl" (
    del %%l /q
  )
)
