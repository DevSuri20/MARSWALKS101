# ============================================================
# MarsWalk - Push to GitHub with 20+ Meaningful Commits
# ============================================================
# HOW TO USE:
#   1. Replace YOUR_GITHUB_REPO_URL below with your new repo's URL
#   2. Run this script from PowerShell inside the project folder
# ============================================================

$REPO_URL = "YOUR_GITHUB_REPO_URL_HERE"   # <-- CHANGE THIS

$PROJECT_DIR = "c:\Users\DEV\Desktop\MarsWalk-main\MarsWalk-main"
Set-Location $PROJECT_DIR

Write-Host "==> Initializing git repository..." -ForegroundColor Cyan
git init
git config user.name  "DevSuri20"
git config user.email "devsuri120@gamil.com"

# ------------------------------------------------------------------
# COMMIT 1 - Root config files
# ------------------------------------------------------------------
Write-Host "`n[1/20] Initial project scaffold - root config files" -ForegroundColor Yellow
git add .gitignore .dockerignore .env.example
git commit -m "chore: initial project scaffold - add root config files"

# ------------------------------------------------------------------
# COMMIT 2 - Package files
# ------------------------------------------------------------------
Write-Host "`n[2/20] Add package.json and package-lock.json" -ForegroundColor Yellow
git add package.json package-lock.json
git commit -m "chore: add Node.js package manifest and lockfile"

# ------------------------------------------------------------------
# COMMIT 3 - Entry point server
# ------------------------------------------------------------------
Write-Host "`n[3/20] Add main server entry point" -ForegroundColor Yellow
git add server.js
git commit -m "feat: add Express server entry point (server.js)"

# ------------------------------------------------------------------
# COMMIT 4 - Deployment configs
# ------------------------------------------------------------------
Write-Host "`n[4/20] Add deployment configuration files" -ForegroundColor Yellow
git add Dockerfile render.yaml vercel.json
git commit -m "chore: add Dockerfile, Render, and Vercel deployment configs"

# ------------------------------------------------------------------
# COMMIT 5 - Documentation
# ------------------------------------------------------------------
Write-Host "`n[5/20] Add README and deployment docs" -ForegroundColor Yellow
git add README.md DEPLOYMENT.md
git commit -m "docs: add README and deployment documentation"

# ------------------------------------------------------------------
# COMMIT 6 - Backend app entry
# ------------------------------------------------------------------
Write-Host "`n[6/20] Add backend app.js" -ForegroundColor Yellow
git add backend/src/app.js
git commit -m "feat(backend): add Express app setup (app.js)"

# ------------------------------------------------------------------
# COMMIT 7 - Backend routes
# ------------------------------------------------------------------
Write-Host "`n[7/20] Add all backend route handlers" -ForegroundColor Yellow
git add backend/src/routes/
git commit -m "feat(backend): add API routes - cell, elevation, plan, point, ruby"

# ------------------------------------------------------------------
# COMMIT 8 - Gazetteer service
# ------------------------------------------------------------------
Write-Host "`n[8/20] Add gazetteer service" -ForegroundColor Yellow
git add backend/src/services/gazetteer.js
git commit -m "feat(backend): add Mars gazetteer service for location lookups"

# ------------------------------------------------------------------
# COMMIT 9 - Elevation service
# ------------------------------------------------------------------
Write-Host "`n[9/20] Add Mars elevation service" -ForegroundColor Yellow
git add backend/src/services/mars-elevation.js
git commit -m "feat(backend): add Mars elevation data service"

# ------------------------------------------------------------------
# COMMIT 10 - OpenRouter service
# ------------------------------------------------------------------
Write-Host "`n[10/20] Add OpenRouter AI service" -ForegroundColor Yellow
git add backend/src/services/openrouter.js
git commit -m "feat(backend): add OpenRouter AI API integration service"

# ------------------------------------------------------------------
# COMMIT 11 - Narration services
# ------------------------------------------------------------------
Write-Host "`n[11/20] Add point and route narration services" -ForegroundColor Yellow
git add backend/src/services/point-narration.js backend/src/services/route-narration.js
git commit -m "feat(backend): add AI narration services for points and routes"

# ------------------------------------------------------------------
# COMMIT 12 - Ruby AI brain
# ------------------------------------------------------------------
Write-Host "`n[12/20] Add Ruby AI brain and prompt engine" -ForegroundColor Yellow
git add backend/src/services/ruby-brain.js backend/src/services/ruby-prompt.js
git commit -m "feat(backend): add Ruby AI brain and prompt engineering module"

# ------------------------------------------------------------------
# COMMIT 13 - Ruby context and actions
# ------------------------------------------------------------------
Write-Host "`n[13/20] Add Ruby context manager and actions handler" -ForegroundColor Yellow
git add backend/src/services/ruby-context.js backend/src/services/ruby-actions.js
git commit -m "feat(backend): add Ruby AI context manager and action dispatcher"

# ------------------------------------------------------------------
# COMMIT 14 - Frontend HTML pages
# ------------------------------------------------------------------
Write-Host "`n[14/20] Add frontend HTML pages" -ForegroundColor Yellow
git add frontend/public/index.html frontend/public/dashboard.html
git commit -m "feat(frontend): add main landing page and dashboard HTML"

# ------------------------------------------------------------------
# COMMIT 15 - Additional HTML pages
# ------------------------------------------------------------------
Write-Host "`n[15/20] Add Jezero 3D, Ruby test and VR test pages" -ForegroundColor Yellow
git add frontend/public/jezero-3d.html frontend/public/ruby-test.html frontend/public/vr-test.html
git commit -m "feat(frontend): add Jezero 3D viewer, Ruby chat test, and VR test pages"

# ------------------------------------------------------------------
# COMMIT 16 - CSS stylesheets
# ------------------------------------------------------------------
Write-Host "`n[16/20] Add all CSS stylesheets" -ForegroundColor Yellow
git add frontend/public/css/
git commit -m "feat(frontend): add CSS stylesheets - home, map, ruby, jezero, vr"

# ------------------------------------------------------------------
# COMMIT 17 - Core JS modules (map & mission)
# ------------------------------------------------------------------
Write-Host "`n[17/20] Add map and mission planner JS" -ForegroundColor Yellow
git add frontend/public/js/map.js frontend/public/js/mission-planner.js frontend/public/js/home.js
git commit -m "feat(frontend): add interactive Mars map and mission planner JS"

# ------------------------------------------------------------------
# COMMIT 18 - Ruby widget and assistant JS
# ------------------------------------------------------------------
Write-Host "`n[18/20] Add Ruby AI assistant frontend JS" -ForegroundColor Yellow
git add frontend/public/js/ruby-assistant.js frontend/public/js/ruby-widget.js frontend/public/js/ruby-test.js
git commit -m "feat(frontend): add Ruby AI assistant widget and chat interface JS"

# ------------------------------------------------------------------
# COMMIT 19 - Briefing and 3D JS
# ------------------------------------------------------------------
Write-Host "`n[19/20] Add briefing and 3D viewer JS" -ForegroundColor Yellow
git add frontend/public/js/place-briefing.js frontend/public/js/route-briefing.js frontend/public/js/jezero-3d.js frontend/public/js/vr-test.js
git commit -m "feat(frontend): add place/route briefings and Jezero 3D/VR viewer JS"

# ------------------------------------------------------------------
# COMMIT 20 - Frontend data and assets
# ------------------------------------------------------------------
Write-Host "`n[20/20] Add frontend data files and assets" -ForegroundColor Yellow
git add frontend/public/data/ frontend/public/assets/
git commit -m "feat(frontend): add Mars location data, Jezero 3D scene, and media assets"

# ------------------------------------------------------------------
# COMMIT 21 - Python tools
# ------------------------------------------------------------------
Write-Host "`n[21/21] Add Python data download scripts and tools" -ForegroundColor Yellow
git add python/ tools/
git commit -m "feat(tools): add Python data download scripts and mascot preparation tool"

# ------------------------------------------------------------------
# COMMIT 22 - Final: check for any remaining untracked files
# ------------------------------------------------------------------
$remaining = git status --porcelain
if ($remaining) {
    Write-Host "`n[Bonus] Committing remaining files..." -ForegroundColor Magenta
    git add .
    git commit -m "chore: add remaining project files"
}

# ------------------------------------------------------------------
# Show final log
# ------------------------------------------------------------------
Write-Host "`n==> Commit history:" -ForegroundColor Cyan
git log --oneline

# ------------------------------------------------------------------
# Push to remote
# ------------------------------------------------------------------
Write-Host "`n==> Adding remote origin and pushing..." -ForegroundColor Cyan
git remote add origin $REPO_URL
git branch -M main
git push -u origin main

Write-Host "`n✅ Done! All commits pushed to: $REPO_URL" -ForegroundColor Green
