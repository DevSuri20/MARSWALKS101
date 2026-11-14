@echo off
setlocal enabledelayedexpansion

:: ================================================================
::  MARSWALK SMART AUTO PUSHER
::  - Skips files already pushed (safe to stop and resume anytime)
::  - Copies 20 untracked files at a time
::  - Commits + pushes every batch
::  - Waits 30 minutes between batches
::
::  STEP 1: Set your GitHub repo URL below
::  STEP 2: Run from CMD - safe to stop/resume anytime
:: ================================================================

set "REMOTE_URL=YOUR_GITHUB_REPO_URL_HERE"
set "SOURCE=C:\Users\DEV\Desktop\MarsWalk-main\MarsWalk-main"
set "REPO=C:\Users\DEV\Desktop\MARSWALKS101"

echo.
echo  =============================================
echo   MarsWalk Smart Auto Pusher
echo   (Resume-safe: skips already pushed files)
echo  =============================================
echo.

cd /d "%REPO%"

:: ---- First time git setup ----
if not exist ".git" (
    echo [SETUP] Initializing git...
    git init
    git config user.name "DevSuri20"
    git config user.email "devsuri120@gamil.com"
    git remote add origin "%REMOTE_URL%"
    echo # MarsWalk > README.md
    git add README.md
    git commit -m "chore: init repo"
    git branch -M main
    git push -u origin main
    echo [SETUP] Done!
    echo.
)

:MAINLOOP

echo  Scanning for files not yet pushed...
echo.

set BATCH=0
set COUNT=0
set SKIPPED=0
set COPIED=0

:: Loop through ALL source files
for /r "%SOURCE%" %%F in (*) do (
    set "ABS=%%F"
    set "REL=!ABS:%SOURCE%\=!"

    :: Check if file already exists in repo (already pushed before)
    if exist "%REPO%\!REL!" (
        set /a SKIPPED+=1
    ) else (
        :: File not in repo yet - copy it
        for %%D in ("%REPO%\!REL!") do (
            if not exist "%%~dpD" md "%%~dpD" >nul 2>&1
        )
        xcopy "%%F" "%REPO%\!REL!*" /Y /Q >nul 2>&1
        set /a COUNT+=1
        set /a COPIED+=1
        echo  + Copied: !REL!

        :: Every 20 new files -> commit, push, wait 30 mins
        if !COUNT! EQU 20 (
            set /a BATCH+=1
            echo.
            echo  --------------------------------------------------
            echo   BATCH !BATCH! ^| Committing 20 new files...
            echo  --------------------------------------------------
            git add .
            git commit -m "feat: batch !BATCH! - add 20 files"
            echo  Pushing to GitHub...
            git push
            echo.
            echo  Waiting 30 minutes before next batch...
            echo  ^(Safe to leave running - will resume from here^)
            echo.
            timeout /t 1800 /nobreak >nul
            set COUNT=0
        )
    )
)

:: ---- Commit any remaining leftover files ----
if !COUNT! GTR 0 (
    set /a BATCH+=1
    echo.
    echo  --------------------------------------------------
    echo   FINAL BATCH !BATCH! ^| Committing !COUNT! files
    echo  --------------------------------------------------
    git add .
    git commit -m "feat: final batch !BATCH! - remaining files"
    echo  Pushing to GitHub...
    git push
)

echo.
if !COPIED! EQU 0 (
    echo  =============================================
    echo   All files are already pushed! Nothing to do.
    echo  =============================================
) else (
    echo  =============================================
    echo   DONE! Pushed !COPIED! files in !BATCH! commits.
    echo   Skipped !SKIPPED! already-pushed files.
    echo  =============================================
)
echo.
pause
