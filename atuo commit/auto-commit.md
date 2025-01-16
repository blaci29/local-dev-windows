# Automatikus Git Commit és Push Szkript

Ez a szkript automatikusan végrehajtja a git add, commit és push műveleteket, dátumozott commit üzenettel.

## Tartalomjegyzék
1. [Telepítés](#telepítés)
2. [Használat](#használat)
3. [Testreszabás](#testreszabás)
4. [Hibaelhárítás](#hibaelhárítás)
5. [Licensz](#licensz)

## Telepítés

1. Másold a `git-auto-commit` mappát a projekt gyökerébe
2. Ellenőrizd, hogy a projektben már inicializálva van-e a git:
   ```bash
   git status
   ```
3. Ha nincs git repository, inicializáld:
   ```bash
   git init
   git remote add origin <repository-url>
   ```

## Használat

1. Nyiss egy parancssort a projekt könyvtárában
2. Futtasd a szkriptet:
   ```bash
   git-auto-commit.bat
   ```
3. A szkript:
   - Hozzáadja az összes változtatást (`git add .`)
   - Létrehoz egy dátumozott commitot
   - Feltölti a változtatásokat a távoli repository-ba

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

## Licensz

Ez a szkript MIT licensz alatt áll. Szabadon használható, módosítható és terjeszthető.

```

docs/git-auto-commit/git-auto-commit.bat
```batch
<<<<<<< SEARCH
