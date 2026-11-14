@echo off
setlocal enabledelayedexpansion

:: ================================================================
::  MARSWALK AUTO PUSHER
::  - Copies 20 files at a time from SOURCE into this repo folder
::  - Commits after every 20 files
::  - Pushes to GitHub then waits 15 minutes
::  - Repeats until all files are done
::
::  STEP 1: Change REMOTE_URL below to your GitHub repo link
::  STEP 2: Double-click this file or run it from CMD
:: ================================================================

set "REMOTE_URL=YOUR_GITHUB_REPO_URL_HERE"
set "SOURCE=C:\Users\DEV\Desktop\MarsWalk-main\MarsWalk-main"
set "REPO=C:\Users\DEV\Desktop\MARSWALKS101"

echo.
echo  =============================================
echo   MarsWalk Auto Pusher
echo  =============================================
echo.

:: Go to repo folder
cd /d "%REPO%"

:: First time setup
if not exist ".git" (
    echo [1/3] Setting up Git...
    git init
    git config user.name "DevSuri20"
    git config user.email "devsuri120@gamil.com"
    git remote add origin "%REMOTE_URL%"
    echo [2/3] Making first commit...
    echo # MarsWalk > README.md
    git add README.md
    git commit -m "chore: init repo"
    git branch -M main
    echo [3/3] Pushing to GitHub...
    git push -u origin main
    echo.
    echo  Setup done! Starting file batches now...
    echo.
)

:: Write all file paths to a temp list
set "LIST=%TEMP%\mw_files.txt"
if exist "%LIST%" del "%LIST%"
for /r "%SOURCE%" %%F in (*) do echo %%F>>"%LIST%"

:: Count total files
set TOTAL=0
for /f %%N in ('find /c /v "" ^<"%LIST%"') do set TOTAL=%%N
echo  Found %TOTAL% files to push.
echo.

set BATCH=0
set COUNT=0

for /f "usebackq delims=" %%F in ("%LIST%") do (

    :: Get relative path by stripping source prefix
    set "ABS=%%F"
    set "REL=!ABS:%SOURCE%\=!"

    :: Create folder if needed
    for %%D in ("%REPO%\!REL!") do (
        if not exist "%%~dpD" md "%%~dpD" >nul 2>&1
    )

    :: Copy the file
    xcopy "%%F" "%REPO%\!REL!*" /Y /Q >nul 2>&1

    set /a COUNT+=1

    :: Every 20 files: commit, push, wait 15 mins
    if !COUNT! EQU 20 (
        set /a BATCH+=1
        echo --------------------------------------------------
        echo  BATCH !BATCH! ^| Committing 20 files...
        echo --------------------------------------------------
        git add .
        git commit -m "feat: batch !BATCH! - add 20 files"
        echo  Pushing to GitHub...
        git push
        echo.
        echo  Waiting 15 minutes for next batch...
        echo  ^(Keep this window open^)
        echo.
        timeout /t 900 /nobreak >nul
        set COUNT=0
    )
)

:: Commit any leftover files (less than 20 at the end)
if !COUNT! GTR 0 (
    set /a BATCH+=1
    echo --------------------------------------------------
    echo  FINAL BATCH !BATCH! ^| Committing last !COUNT! files
    echo --------------------------------------------------
    git add .
    git commit -m "feat: final batch !BATCH! - remaining files"
    echo  Pushing to GitHub...
    git push
)

if exist "%LIST%" del "%LIST%"

echo.
echo  =============================================
echo   ALL DONE! Pushed in !BATCH! commits.
echo  =============================================
echo.
pause
