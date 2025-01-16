@echo off
echo Automatikus git commit és push folyamat...

:: Várakozás 2 másodpercet, hogy biztosan lássa a VS Code a változásokat
timeout /t 2 >nul

:: Git parancsok végrehajtása
git add .
git commit -m "Automatikus commit: %date% %time%"
git push origin main

echo Kész! A változtatások feltöltve.
pause
