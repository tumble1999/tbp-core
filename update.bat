@echo off
set actual-remote="https://github.com/tumble1999/tbp-core.git"

git remote get-url --push origin>%temp%/remote-tbp-url
set /p remote-url=<%temp%/remote-tbp-url
if not "%remote-url%"=="%actual-remote:"=%" (
  if not exist .git (
    git init
  )
  git remote add origin "%actual-remote:"=%"
)
git pull
