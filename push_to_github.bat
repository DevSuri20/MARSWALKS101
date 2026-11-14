@echo off
:: ============================================================
:: MarsWalk - Push to GitHub with 20+ Meaningful Commits
:: ============================================================
:: HOW TO USE:
::   1. Replace YOUR_GITHUB_REPO_URL below with your new repo URL
::   2. Double-click this file OR run it from CMD
:: ============================================================

set REPO_URL=YOUR_GITHUB_REPO_URL_HERE

cd /d "c:\Users\DEV\Desktop\MarsWalk-main\MarsWalk-main"

echo ==> Initializing git repository...
git init
git config user.name "DevSuri20"
git config user.email "devsuri120@gamil.com"

:: ------------------------------------------------------------------
:: COMMIT 1 - Root config files
:: ------------------------------------------------------------------
echo.
echo [1/21] Initial scaffold - root config files
git add .gitignore .dockerignore .env.example
git commit -m "chore: initial project scaffold - add root config files"

:: ------------------------------------------------------------------
:: COMMIT 2 - Package files
:: ------------------------------------------------------------------
echo.
echo [2/21] Add package.json and lockfile
git add package.json package-lock.json
git commit -m "chore: add Node.js package manifest and lockfile"

:: ------------------------------------------------------------------
:: COMMIT 3 - Entry point server
:: ------------------------------------------------------------------
echo.
echo [3/21] Add main server entry point
git add server.js
git commit -m "feat: add Express server entry point (server.js)"

:: ------------------------------------------------------------------
:: COMMIT 4 - Deployment configs
:: ------------------------------------------------------------------
echo.
echo [4/21] Add deployment configuration files
git add Dockerfile render.yaml vercel.json
git commit -m "chore: add Dockerfile, Render, and Vercel deployment configs"

:: ------------------------------------------------------------------
:: COMMIT 5 - Documentation
:: ------------------------------------------------------------------
echo.
echo [5/21] Add README and deployment docs
git add README.md DEPLOYMENT.md
git commit -m "docs: add README and deployment documentation"

:: ------------------------------------------------------------------
:: COMMIT 6 - Backend app entry
:: ------------------------------------------------------------------
echo.
echo [6/21] Add backend app.js
git add backend/src/app.js
git commit -m "feat(backend): add Express app setup (app.js)"

:: ------------------------------------------------------------------
:: COMMIT 7 - Backend routes
:: ------------------------------------------------------------------
echo.
echo [7/21] Add all backend route handlers
git add backend/src/routes/
git commit -m "feat(backend): add API routes - cell, elevation, plan, point, ruby"

:: ------------------------------------------------------------------
:: COMMIT 8 - Gazetteer service
:: ------------------------------------------------------------------
echo.
echo [8/21] Add gazetteer service
git add backend/src/services/gazetteer.js
git commit -m "feat(backend): add Mars gazetteer service for location lookups"

:: ------------------------------------------------------------------
:: COMMIT 9 - Elevation service
:: ------------------------------------------------------------------
echo.
echo [9/21] Add Mars elevation service
git add backend/src/services/mars-elevation.js
git commit -m "feat(backend): add Mars elevation data service"

:: ------------------------------------------------------------------
:: COMMIT 10 - OpenRouter service
:: ------------------------------------------------------------------
echo.
echo [10/21] Add OpenRouter AI service
git add backend/src/services/openrouter.js
git commit -m "feat(backend): add OpenRouter AI API integration service"

:: ------------------------------------------------------------------
:: COMMIT 11 - Narration services
:: ------------------------------------------------------------------
echo.
echo [11/21] Add point and route narration services
git add backend/src/services/point-narration.js backend/src/services/route-narration.js
git commit -m "feat(backend): add AI narration services for points and routes"

:: ------------------------------------------------------------------
:: COMMIT 12 - Ruby AI brain
:: ------------------------------------------------------------------
echo.
echo [12/21] Add Ruby AI brain and prompt engine
git add backend/src/services/ruby-brain.js backend/src/services/ruby-prompt.js
git commit -m "feat(backend): add Ruby AI brain and prompt engineering module"

:: ------------------------------------------------------------------
:: COMMIT 13 - Ruby context and actions
:: ------------------------------------------------------------------
echo.
echo [13/21] Add Ruby context manager and actions handler
git add backend/src/services/ruby-context.js backend/src/services/ruby-actions.js
git commit -m "feat(backend): add Ruby AI context manager and action dispatcher"

:: ------------------------------------------------------------------
:: COMMIT 14 - Frontend HTML pages
:: ------------------------------------------------------------------
echo.
echo [14/21] Add frontend HTML pages
git add frontend/public/index.html frontend/public/dashboard.html
git commit -m "feat(frontend): add main landing page and dashboard HTML"

:: ------------------------------------------------------------------
:: COMMIT 15 - Additional HTML pages
:: ------------------------------------------------------------------
echo.
echo [15/21] Add Jezero 3D, Ruby test and VR test pages
git add frontend/public/jezero-3d.html frontend/public/ruby-test.html frontend/public/vr-test.html
git commit -m "feat(frontend): add Jezero 3D viewer, Ruby chat test, and VR test pages"

:: ------------------------------------------------------------------
:: COMMIT 16 - CSS stylesheets
:: ------------------------------------------------------------------
echo.
echo [16/21] Add all CSS stylesheets
git add frontend/public/css/
git commit -m "feat(frontend): add CSS stylesheets - home, map, ruby, jezero, vr"

:: ------------------------------------------------------------------
:: COMMIT 17 - Core JS modules
:: ------------------------------------------------------------------
echo.
echo [17/21] Add map and mission planner JS
git add frontend/public/js/map.js frontend/public/js/mission-planner.js frontend/public/js/home.js
git commit -m "feat(frontend): add interactive Mars map and mission planner JS"

:: ------------------------------------------------------------------
:: COMMIT 18 - Ruby widget and assistant JS
:: ------------------------------------------------------------------
echo.
echo [18/21] Add Ruby AI assistant frontend JS
git add frontend/public/js/ruby-assistant.js frontend/public/js/ruby-widget.js frontend/public/js/ruby-test.js
git commit -m "feat(frontend): add Ruby AI assistant widget and chat interface JS"

:: ------------------------------------------------------------------
:: COMMIT 19 - Briefing and 3D JS
:: ------------------------------------------------------------------
echo.
echo [19/21] Add briefing and 3D viewer JS
git add frontend/public/js/place-briefing.js frontend/public/js/route-briefing.js frontend/public/js/jezero-3d.js frontend/public/js/vr-test.js
git commit -m "feat(frontend): add place/route briefings and Jezero 3D/VR viewer JS"

:: ------------------------------------------------------------------
:: COMMIT 20 - Frontend data and assets
:: ------------------------------------------------------------------
echo.
echo [20/21] Add frontend data files and assets
git add frontend/public/data/ frontend/public/assets/
git commit -m "feat(frontend): add Mars location data, Jezero 3D scene, and media assets"

:: ------------------------------------------------------------------
:: COMMIT 21 - Python tools
:: ------------------------------------------------------------------
echo.
echo [21/21] Add Python scripts and tools
git add python/ tools/
git commit -m "feat(tools): add Python data download scripts and mascot preparation tool"

:: ------------------------------------------------------------------
:: Catch any remaining untracked files
:: ------------------------------------------------------------------
git add .
git diff --cached --quiet
if errorlevel 1 (
    echo.
    echo [Bonus] Committing remaining files...
    git commit -m "chore: add any remaining project files"
)

:: ------------------------------------------------------------------
:: Show final log
:: ------------------------------------------------------------------
echo.
echo ==> Commit history:
git log --oneline

:: ------------------------------------------------------------------
:: Push to GitHub
:: ------------------------------------------------------------------
echo.
echo ==> Adding remote and pushing to GitHub...
git remote add origin %REPO_URL%
git branch -M main
git push -u origin main

echo.
echo Done! All commits pushed to: %REPO_URL%
pause
