@echo off
set actual-remote="https://github.com/tumble1999/tbp-core"

git remote get-url --push origin>remote-tbp-url.txt
set /p remote-url=<remote-tbp-url.txt
del remote-tbp-url.txt
if not "%remote-url:"=%"=="%actual-remote:"=%" (
  if not exist .git (
    git init
  )
  git remote add origin "%actual-remote:"=%"
)
git pull
pause
