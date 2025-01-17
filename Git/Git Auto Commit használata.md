# Git Auto Commit Script Windowsra

Ez egy egyszerű batch fájl, ami automatizálja a Git commit és push folyamatot Windows rendszeren. A szkript ideális fejlesztőknek, akik gyakran kell commitoljanak és pusholjanak változtatásokat.

## Főbb funkciók
- Automatikusan hozzáadja az összes módosított fájlt (`git add .`)
- Létrehoz egy commitot az aktuális dátummal, idővel és branch névvel
- Automatikusan észleli az aktuális git branchet
- Minden git művelet után hibaellenőrzés történik
- Felsorolja a módosított fájlokat a commit üzenetben
- Automatikusan feltölti a változtatásokat a távoli repositoryba (`git push`)
- 2 másodperces várakozás a VS Code változások észlelése érdekében
- Egyszerű testreszabási lehetőségek

## Telepítés

1. Másold a `git-auto-commit.bat` fájlt a projekt gyökerébe
2. Ellenőrizd, hogy a projektben már inicializálva van-e a git:
   ```bash
   git status
   ```
3. Ha nincs git repository, inicializáld:
   ```bash
   git init
   git remote add origin <repository-url>
   ```

## Használati módok

1. **Kattintással indítás**
   - A fájlra duplán kattintva azonnal elindul
   - A script végén `pause` parancs miatt látható az eredmény

2. **VS Code projekt gyökerében**
   - Helyezd a fájlt a projekt gyökerébe
   - VS Code terminálból futtatható: `.\git-auto-commit.bat`

3. **Manuális futtatás**
   - Parancssorból indítható a fájl elérési útjával
   - Pl.: `C:\projektek\my_project\git-auto-commit.bat`

## Testreszabás

### Branch név módosítása
Szerkeszd a `git-auto-commit.bat` fájlt:
```batch
git push origin main  # main helyett írd be a branch neved
```

### Commit üzenet módosítása
Szerkeszd a `git-auto-commit.bat` fájlt:
```batch
git commit -m "Automatikus commit: %date% %time%"
```

## Hibaelhárítás

### "Not a git repository" hiba
- Futtasd: `git init`

### "No remote origin" hiba
- Állítsd be a remote-t:
  ```bash
  git remote add origin <repository-url>
  ```

### "Everything up-to-date" üzenet
- Nincsenek változtatások a commitoláshoz

### Permission denied hiba
- Ellenőrizd, hogy rendelkezel-e írási jogosultsággal a repositoryhoz

## Licensz

Ez a szkript MIT licensz alatt áll. Szabadon használható, módosítható és terjeszthető.

## Script tartalma

```batch
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