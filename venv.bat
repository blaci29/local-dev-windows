@echo off
:: Virtuális környezet aktiválása VSCode terminálban vagy új ablakban
:: Használat:
::   venv.bat    - Aktiválás a jelenlegi terminálban
::   venv.bat -n - Új PowerShell ablakban

:: Virtuális környezet ellenőrzése
if not exist .\venv\Scripts\Activate.ps1 (
    echo [HIBA] Nem található a virtuális környezet!
    echo Hozz létre egy virtuális környezetet: python -m venv venv
    pause
    exit /b 1
)

:: Új ablak esetén
if "%1"=="-n" (
    start powershell -NoExit -Command "& { .\venv\Scripts\Activate.ps1 }"
    exit /b 0
)

:: VSCode terminálban aktiválás
echo A virtuális környezet aktiválásához futtasd a következő parancsot:
echo .\venv\Scripts\Activate.ps1
echo Vagy használd a "venv.bat -n" parancsot új ablakhoz.