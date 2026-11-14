@echo off
setlocal enabledelayedexpansion

:: ================================================================
::  MARSWALK SMART AUTO PUSHER
::  - Skips already pushed files (resume-safe after laptop off)
::  - 20 files per batch, pushes every 30 minutes
::  - Commit messages use Mars/space names + actual file names
:: ================================================================

set "REMOTE_URL=YOUR_GITHUB_REPO_URL_HERE"
set "SOURCE=C:\Users\DEV\Desktop\MarsWalk-main\MarsWalk-main"
set "REPO=C:\Users\DEV\Desktop\MARSWALKS101"

:: ---- Mars / Space themed commit prefixes (cycles through) ----
set "M[1]=mission-jezero"
set "M[2]=olympus-mons"
set "M[3]=valles-marineris"
set "M[4]=perseverance"
set "M[5]=curiosity-rover"
set "M[6]=red-planet"
set "M[7]=hellas-basin"
set "M[8]=terra-cimmeria"
set "M[9]=deimos-orbit"
set "M[10]=phobos-flyby"
set "M[11]=syrtis-major"
set "M[12]=elysium-rise"
set "M[13]=acidalia-plains"
set "M[14]=arcadia-plateau"
set "M[15]=amazonis-delta"
set "M[16]=borealis-basin"
set "M[17]=chryse-landing"
set "M[18]=cydonia-mesa"
set "M[19]=tharsis-shield"
set "M[20]=ruby-on-mars"

echo.
echo  =============================================
echo   MarsWalk Smart Auto Pusher
echo   (Resume-safe ^ Mars-themed commits)
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
    git commit -m "chore(mission-control): initialize marswalk repository"
    git branch -M main
    git push -u origin main
    echo [SETUP] Done!
    echo.
)

echo  Scanning for files not yet pushed...
echo.

set BATCH=0
set COUNT=0
set SKIPPED=0
set COPIED=0
set "FILENAMES="

for /r "%SOURCE%" %%F in (*) do (
    set "ABS=%%F"
    set "REL=!ABS:%SOURCE%\=!"

    :: Skip if already in repo
    if exist "%REPO%\!REL!" (
        set /a SKIPPED+=1
    ) else (
        :: Create folder and copy
        for %%D in ("%REPO%\!REL!") do (
            if not exist "%%~dpD" md "%%~dpD" >nul 2>&1
        )
        xcopy "%%F" "%REPO%\!REL!*" /Y /Q >nul 2>&1
        set /a COUNT+=1
        set /a COPIED+=1

        :: Collect file names for commit message (first 3 only)
        if !COUNT! LEQ 3 (
            for %%N in ("%%F") do (
                if "!FILENAMES!"=="" (
                    set "FILENAMES=%%~nxN"
                ) else (
                    set "FILENAMES=!FILENAMES!, %%~nxN"
                )
            )
        )
        if !COUNT! EQU 4 set "FILENAMES=!FILENAMES! ..."

        echo  + !REL!

        :: Every 20 files -> commit with Mars name + file names
        if !COUNT! EQU 20 (
            set /a BATCH+=1

            :: Pick Mars name (cycle through 1-20)
            set /a "MIDX=(!BATCH%-1)%%20+1"
            set "MARSNAME=!M[!MIDX!]!"

            echo.
            echo  --------------------------------------------------
            echo   BATCH !BATCH! ^| [!MARSNAME!]
            echo   Files: !FILENAMES!
            echo  --------------------------------------------------

            git add .
            git commit -m "feat(!MARSNAME!): add !FILENAMES!"
            echo  Pushing to GitHub...
            git push

            echo.
            echo  Waiting 30 minutes before next batch...
            echo  ^(Safe to stop - will resume from here next run^)
            echo.
            timeout /t 1800 /nobreak >nul

            set COUNT=0
            set "FILENAMES="
        )
    )
)

:: ---- Final leftover files ----
if !COUNT! GTR 0 (
    set /a BATCH+=1
    set /a "MIDX=(!BATCH%-1)%%20+1"
    set "MARSNAME=!M[!MIDX!]!"

    echo.
    echo  --------------------------------------------------
    echo   FINAL BATCH !BATCH! ^| [!MARSNAME!]
    echo   Files: !FILENAMES!
    echo  --------------------------------------------------

    git add .
    git commit -m "feat(!MARSNAME!): add !FILENAMES! + remaining files"
    echo  Pushing to GitHub...
    git push
)

echo.
if !COPIED! EQU 0 (
    echo  =============================================
    echo   All files already pushed! Nothing to do.
    echo  =============================================
) else (
    echo  =============================================
    echo   DONE! !COPIED! files pushed in !BATCH! commits.
    echo   Skipped !SKIPPED! already-pushed files.
    echo  =============================================
)
echo.
pause
