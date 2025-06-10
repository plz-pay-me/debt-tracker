@echo off
set /p msg=Enter commit message: 

:: Optional: auto-stash dirty changes
git diff --quiet || (
    echo Stashing changes...
    git stash -u
    set stash=1
)

:: Pull with rebase
git pull --rebase origin main
if errorlevel 1 (
    echo Pull failed. Aborting.
    exit /b 1
)

:: Restore stash if it existed
if defined stash (
    echo Restoring stashed changes...
    git stash pop
)

:: Add and commit
git add .

git diff --cached --quiet
if %errorlevel%==0 (
    echo No changes to commit.
    exit /b 0
)

git commit -m "%msg%"
git push origin main