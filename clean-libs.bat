@echo on
REM CHECK IF IN A TBP PROJECT
if not exist .tbp (
  goto :eof
)

for /d %%l in ("lib\*") do (
  if exist %%l.tbpl (
    del %%L /q
  )
)
