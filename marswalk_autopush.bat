@echo off
setlocal enabledelayedexpansion

:: ============================================================
::  MarsWalk Auto Push - 20 files per commit, push every 15 min
:: ============================================================

set SOURCE=C:\Users\DEV\Desktop\MarsWalk-main\MarsWalk-main
set REPO=C:\Users\DEV\Desktop\MARSWALKS101
set REMOTE=YOUR_GITHUB_REPO_URL_HERE

:: ---- Setup git if first time ----
cd /d "%REPO%"
if not exist ".git" (
    echo [SETUP] Initializing git...
    git init
    git config user.name "DevSuri20"
    git config user.email "devsuri120@gamil.com"
    git remote add origin %REMOTE%
    echo # MarsWalk > README.md
    git add README.md
    git commit -m "chore: initial commit"
    git branch -M main
    git push -u origin main
    echo [SETUP] Done. Starting file batches...
    echo.
)

:: ---- Build file list ----
set LISTFILE=%TEMP%\marsfiles_list.txt
if exist "%LISTFILE%" del "%LISTFILE%"
for /r "%SOURCE%" %%F in (*) do echo %%F>> "%LISTFILE%"

:: Count total
set TOTAL=0
for /f %%C in ('find /c /v "" ^< "%LISTFILE%"') do set TOTAL=%%C
echo Total files to push: %TOTAL%
echo.

:: ---- Loop through files in batches of 20 ----
set BATCH=0
set COUNT=0

for /f "usebackq delims=" %%F in ("%LISTFILE%") do (
    set FILEPATH=%%F
    set RELPATH=!FILEPATH:%SOURCE%\=!

    :: Make destination folder
    for %%D in ("%REPO%\!RELPATH!") do (
        if not exist "%%~dpD" mkdir "%%~dpD" 2>nul
    )

    :: Copy file
    xcopy "%%F" "%REPO%\!RELPATH!*" /Y /Q >nul 2>&1
    set /a COUNT+=1

    :: Every 20 files -> commit, push, wait
    if !COUNT! EQU 20 (
        set /a BATCH+=1
        echo --------------------------------------------------
        echo  Batch !BATCH! ready - committing 20 files...
        echo --------------------------------------------------
        git add .
        git commit -m "feat: batch !BATCH! - 20 files added"
        git push

        echo.
        echo [Waiting 15 minutes before next batch...]
        echo [Do NOT close this window!]
        timeout /t 900 /nobreak
        echo.
        set COUNT=0
    )
)

:: ---- Final leftover files (less than 20) ----
if !COUNT! GTR 0 (
    set /a BATCH+=1
    echo --------------------------------------------------
    echo  Final Batch !BATCH! - committing last !COUNT! files
    echo --------------------------------------------------
    git add .
    git commit -m "feat: final batch !BATCH! - remaining files"
    git push
)

:: ---- Done ----
echo.
echo ==================================================
echo  ALL DONE! Total batches pushed: !BATCH!
echo ==================================================
del "%LISTFILE%"
pause
