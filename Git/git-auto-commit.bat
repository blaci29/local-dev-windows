@echo off
echo Automatikus git commit és push folyamat...

:: Hibaellenőrző függvény
:check_error
if %errorlevel% neq 0 (
    echo Hiba tortent! Hibakod: %errorlevel%
    pause
    exit /b %errorlevel%
)

:: Aktuális branch lekérése
for /f "delims=" %%i in ('git branch --show-current') do set current_branch=%%i
if "%current_branch%"=="" (
    echo Nem talalhato git repository!
    pause
    exit /b 1
)

echo Aktualis branch: %current_branch%

:: Várakozás 2 másodpercet
timeout /t 2 >nul
call :check_error

:: Módosított fájlok listájának lekérése
for /f "delims=" %%i in ('git status --porcelain') do set changed_files=%%i
call :check_error

:: Git parancsok végrehajtása
git add .
call :check_error

git commit -m "Automatikus commit: %date% %time% | Módosított fájlok: %changed_files% | Branch: %current_branch%"
call :check_error

git push origin %current_branch%
call :check_error

echo Kesz! A valtoztatasok feltoltve a(z) %current_branch% branch-re.
pause
