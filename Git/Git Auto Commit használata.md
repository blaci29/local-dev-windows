# Git Auto Commit Script v2.0 Windowsra

Ez egy fejlett batch fájl, ami automatizálja a Git commit és push folyamatot Windows rendszeren. A szkript ideális fejlesztőknek, akik gyakran commitolnak és pusholnak változtatásokat.

## Főbb funkciók
- Automatikusan hozzáadja az összes módosított fájlt (`git add -A`)
- Részletes commit üzenet az alábbiakkal:
  - Aktuális dátum és idő
  - Módosított fájlok száma
  - Módosított fájlok listája
  - Aktuális branch név
  - Opcionális egyedi üzenet
- Fejlett hibaellenőrzés és hibakezelés
- Debug mód részletes információkkal
- Támogatja a szóközöket tartalmazó fájlneveket
- Kezeli az átnevezett fájlokat
- Automatikus státusz ellenőrzés (csak változás esetén commitol)

## Telepítés

1. Add hozzá a következő sorokat a `.gitignore` fájlhoz:
   ```
   git-auto-commit.bat
   .git-status-temp.txt
   ```
2. Másold a `git-auto-commit.bat` fájlt a projekt gyökerébe
3. Ellenőrizd, hogy a projektben már inicializálva van-e a git:
   ```bash
   git status
   ```
4. Ha nincs git repository, inicializáld:
   ```bash
   git init
   git remote add origin <repository-url>
   ```

## Használati módok

1. **Alapértelmezett üzenettel**
   - Dupla kattintással vagy parancssorból:
   ```bash
   git-auto-commit.bat
   ```
   - Eredmény: "Automatikus frissites [dátum] | Modositott fajlok: X db | Fajlok: file1, file2 | Branch: main"

2. **Egyedi üzenettel**
   - Parancssorból:
   ```bash
   git-auto-commit.bat "Az én egyedi üzenetem"
   ```
   - Eredmény: "Automatikus frissites [dátum] | Modositott fajlok: X db | Fajlok: file1, file2 | Branch: main | Az én egyedi üzenetem"

## Hibaelhárítás

### "Nem git repository" hiba
- Ellenőrizd, hogy a `.git` mappa létezik-e
- Futtasd: `git init`

### "Branch név lekérdezése sikertelen" hiba
- Ellenőrizd, hogy a Git telepítve van-e és szerepel-e a PATH-ban
- Ellenőrizd a repository állapotát

### "Git parancs nem elérhető" hiba
- Ellenőrizd a Git telepítését
- Ellenőrizd, hogy a Git szerepel-e a PATH környezeti változóban

### "Nincs változás a repository-ban" üzenet
- Ez nem hiba, csak jelzi, hogy nincs mit commitolni

## Debug mód

A script beépített debug móddal rendelkezik, amely részletes információkat jelenít meg a végrehajtásról:
- Branch név ellenőrzése
- Dátum és idő információk
- Git státusz részletek
- Fájlok feldolgozása
- Commit üzenet összeállítása
- Végrehajtott parancsok

## Script tartalma

```batch
@echo off
:: ============================================================================
:: Git Auto Commit Script v2.0
:: ============================================================================
:: Használat:
::   1. A .gitignore fájlhoz adja hozzá a következő sorokat:
::      git-auto-commit.bat
::      .git-status-temp.txt
::
::   2. Másolja a git-auto-commit.bat fájlt a git projekt gyökerébe.
::
::   3. A script futtatása:
::      a) Kattintással: Kattintson duplán a git-auto-commit.bat fájlra.
::      b) Parancssorból: 
::         - Alapértelmezett üzenettel:
::           git-auto-commit.bat
::           Eredmény: "Automatikus frissítés [dátum] | Módosított fájlok: X db | Fájlok: file1, file2 | Branch: main"
::         - Saját üzenettel:
::           git-auto-commit.bat "Az én egyedi üzenetem"
::           Eredmény: "Automatikus frissítés [dátum] | Módosított fájlok: X db | Fájlok: file1, file2 | Branch: main | Az én egyedi üzenetem"
::
::   Megjegyzés: Ha az üzenet szóközöket tartalmaz, tegye idézőjelek közé!
:: ============================================================================

setlocal EnableDelayedExpansion

REM Debug információk
set "DEBUG=true"
set "STATUS_FILE=.git-status-temp.txt"

REM Paraméter ellenőrzése és feldolgozása
set "EXTRA_MSG="
if not "%~1"=="" (
    set "EXTRA_MSG= | %~1"
)

REM Ellenőrizzük, hogy git repo-ban vagyunk-e
if not exist ".git" (
    echo [HIBA] Nem git repository-ban vagy!
    exit /b 1
)

REM Branch név lekérdezése - javított verzió
for /f "tokens=*" %%i in ('git rev-parse --abbrev-ref HEAD 2^>nul') do (
    set "BRANCH_NAME=%%i"
)

if not defined BRANCH_NAME (
    echo [HIBA] Branch nev lekerdezese sikertelen
    echo [INFO] Ellenorzom a git telepiteset es a repository allapotot...
    
    REM Git elérhetőség ellenőrzése
    git --version >nul 2>&1
    if errorlevel 1 (
        echo [HIBA] A git parancs nem elerheto. Kerem ellenorizze, hogy a Git telepitve van-e es szerepel-e a PATH-ban.
        exit /b 1
    )
    
    REM Git repo ellenőrzése
    git rev-parse --git-dir >nul 2>&1
    if errorlevel 1 (
        echo [HIBA] Nem git repository vagy a .git mappa serult.
        exit /b 1
    )
    
    exit /b 1
)

if %DEBUG%==true echo [DEBUG] Branch nev: %BRANCH_NAME%

REM Dátum és idő lekérése
for /f "tokens=2 delims==" %%I in ('wmic os get localdatetime /value') do set datetime=%%I
set DATUM=%datetime:~0,4%-%datetime:~4,2%-%datetime:~6,2% %datetime:~8,2%:%datetime:~10,2%

echo [DEBUG] Datum: %DATUM%

REM Git státusz lekérése
git status --porcelain > "%STATUS_FILE%" 2>&1
if %errorlevel% neq 0 (
    echo [HIBA] Git status lekerdezese sikertelen
    exit /b 1
)

:: Ellenőrizzük, hogy van-e változás
for %%I in ("%STATUS_FILE%") do set size=%%~zI
if %size% == 0 (
    echo [INFO] Nincs változás a repository-ban.
    del "%STATUS_FILE%"
    exit /b 0
)

echo [DEBUG] Valtozasok merete: %size% byte

:: Változások összegyűjtése
set "file_list="
set "total_changes=0"

echo [DEBUG] Git status tartalom:
type "%STATUS_FILE%"
echo.

:: Teljes útvonalak megőrzése a fájlneveknél
for /f "usebackq tokens=1,2*" %%a in ("%STATUS_FILE%") do (
    set /a "total_changes+=1"
    
    echo [DEBUG] Feldolgozas alatt: Status=[%%a] File=[%%b] Extra=[%%c]
    
    :: Fájlnév feldolgozása - idézőjelek eltávolítása
    set "current_file=%%b"
    set "current_file=!current_file:"=!"
    
    if "%%c" NEQ "" (
        set "current_file=%%b %%c"
        set "current_file=!current_file:"=!"
        echo [DEBUG] Szokozos fajlnev: [!current_file!]
    )
    
    :: Átnevezés esetén csak az új nevet használjuk
    echo "!current_file!" | find "->" > nul
    if !errorlevel! equ 0 (
        echo [DEBUG] Atnevezes eszlelve: [!current_file!]
        for /f "tokens=3* delims= " %%x in ("!current_file!") do (
            set "current_file=%%x"
            if "%%y" NEQ "" set "current_file=%%x %%y"
            echo [DEBUG] Uj nev: [!current_file!]
        )
    )
    
    :: Fájl hozzáadása a listához
    if defined file_list (
        set "file_list=!file_list!, !current_file!"
    ) else (
        set "file_list=!current_file!"
    )
)

echo [DEBUG] Branch: %BRANCH_NAME%
echo [DEBUG] Osszes valtozas: %total_changes%
echo [DEBUG] File lista: [!file_list!]

:: Commit üzenet összeállítása (paraméterrel kiegészítve)
set "commit_msg=Automatikus frissites [%DATUM%] | Modositott fajlok: %total_changes% db | Fajlok: !file_list! | Branch: %BRANCH_NAME%!EXTRA_MSG!"
echo [DEBUG] Commit uzenet: [!commit_msg!]

:: Commit végrehajtása
git add -A
if %errorlevel% neq 0 (
    echo [HIBA] Git add parancs sikertelen
    del "%STATUS_FILE%"
    exit /b 1
)

git commit -m "!commit_msg!"
if %errorlevel% neq 0 (
    echo [HIBA] Git commit parancs sikertelen
    echo [DEBUG] Commit parancs: git commit -m "!commit_msg!"
    del "%STATUS_FILE%"
    exit /b 1
)

:: Push végrehajtása
echo [INFO] Push kezdese...
git push origin %BRANCH_NAME%
if %errorlevel% neq 0 (
    echo [HIBA] Git push parancs sikertelen
    echo [DEBUG] Push parancs: git push origin %BRANCH_NAME%
    del "%STATUS_FILE%"
    exit /b 1
)

echo [OK] Sikeres commit es push!
echo [INFO] Commit uzenet: !commit_msg!

:: Temp fájl törlése
del "%STATUS_FILE%"
if %errorlevel% neq 0 (
    echo [HIBA] Temp fajl torlese sikertelen
    exit /b 1
)

endlocal
```

## Licensz

Ez a szkript MIT licensz alatt áll. Szabadon használható, módosítható és terjeszthető.