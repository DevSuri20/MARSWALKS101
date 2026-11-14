@echo off
setlocal enabledelayedexpansion

:: ============================================================
:: MarsWalk Auto-Push Script
:: Copies 20 files per batch from SOURCE to REPO,
:: commits each batch, waits 15 mins, then pushes.
:: ============================================================

set SOURCE=C:\Users\DEV\Desktop\MarsWalk-main\MarsWalk-main
set REPO=C:\Users\DEV\Desktop\MARSWALKS101

:: Go into the repo
cd /d "%REPO%"

:: Initialize git if not already done
if not exist ".git" (
    echo ==> Initializing git repo in %REPO%...
    git init
    git config user.name "DevSuri20"
    git config user.email "devsuri120@gamil.com"
)

:: ============================================================
:: BUILD THE FILE LIST (all files from source, skipping .git)
:: ============================================================
set LISTFILE=%TEMP%\marsfiles.txt
if exist "%LISTFILE%" del "%LISTFILE%"

for /r "%SOURCE%" %%F in (*) do (
    echo %%F>> "%LISTFILE%"
)

:: Count total files
set TOTAL=0
for /f %%C in ('find /c /v "" ^< "%LISTFILE%"') do set TOTAL=%%C
echo ==> Total files found: %TOTAL%

:: ============================================================
:: PROCESS IN BATCHES OF 20
:: ============================================================
set BATCH=0
set COUNT=0
set COPIED=0

:: Read file list line by line
for /f "usebackq delims=" %%F in ("%LISTFILE%") do (
    set FILEPATH=%%F

    :: Strip the SOURCE prefix to get relative path
    set RELPATH=!FILEPATH:%SOURCE%\=!

    :: Get destination directory
    for %%D in ("!FILEPATH!") do set DESTDIR=%REPO%\!RELPATH!
    :: Remove filename to get just the folder
    set DESTDIR=%REPO%\!RELPATH!

    :: Create destination folder structure
    for %%D in ("%REPO%\!RELPATH!") do (
        if not exist "%%~dpD" mkdir "%%~dpD" 2>nul
    )

    :: Copy the file
    xcopy "%%F" "%REPO%\!RELPATH!*" /Y /Q >nul 2>&1
    if errorlevel 0 (
        set /a COPIED+=1
        set /a COUNT+=1
    )

    :: Every 20 files -> commit + wait 15 mins
    if !COUNT! EQU 20 (
        set /a BATCH+=1
        echo.
        echo ============================================================
        echo  BATCH !BATCH! - Committing !COPIED! files so far...
        echo ============================================================
        git add .
        git commit -m "feat: batch !BATCH! - add files !COPIED!-of-%TOTAL% [auto-push]"

        echo.
        echo ==> Pushing batch !BATCH! to GitHub...
        git push

        echo.
        echo ==> Waiting 15 minutes before next batch...
        echo     (Do NOT close this window)
        timeout /t 900 /nobreak

        set COUNT=0
    )
)

:: ============================================================
:: FINAL COMMIT - leftover files (less than 20)
:: ============================================================
if !COUNT! GTR 0 (
    set /a BATCH+=1
    echo.
    echo ============================================================
    echo  FINAL BATCH !BATCH! - Committing remaining !COUNT! files
    echo ============================================================
    git add .
    git commit -m "feat: final batch !BATCH! - remaining project files [auto-push]"

    echo.
    echo ==> Pushing final batch to GitHub...
    git push
)

:: ============================================================
:: DONE
:: ============================================================
echo.
echo ============================================================
echo  ALL DONE! Total files pushed: !COPIED!
echo  Total commits made: !BATCH!
echo ============================================================
del "%LISTFILE%"
pause
