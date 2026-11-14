@echo off
:: ============================================================
:: Run this ONCE before auto_push.bat
:: Sets up the MARSWALKS101 repo with your GitHub remote
:: ============================================================

set REPO=C:\Users\DEV\Desktop\MARSWALKS101
set REMOTE_URL=YOUR_GITHUB_REPO_URL_HERE

cd /d "%REPO%"

echo ==> Setting up git in %REPO%...
git init
git config user.name "DevSuri20"
git config user.email "devsuri120@gamil.com"

echo ==> Adding GitHub remote...
git remote remove origin 2>nul
git remote add origin %REMOTE_URL%

echo ==> Creating initial empty commit...
echo # MarsWalk > README.md
git add README.md
git commit -m "chore: initial commit"
git branch -M main
git push -u origin main

echo.
echo ==> Setup complete! Now run auto_push.bat
pause
