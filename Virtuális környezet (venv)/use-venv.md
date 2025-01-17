# Python Virtuális Környezet Használata Windows Rendszeren

## Mi az a virtuális környezet és miért használjuk?

A virtuális környezet (venv) egy izolált Python környezet, ami lehetővé teszi, hogy:
- Minden projekthez külön Python csomagokat telepíts
- Ne legyenek ütközések különböző projektek függőségei között
- Könnyebben megosztható legyen a projekt másokkal

## Részletes telepítési útmutató

### 1. Python telepítése
1. Látogass el a https://www.python.org/downloads/ oldalra
2. Kattints a "Download Python" gombra (válaszd a legújabb verziót)
3. Futtasd a letöltött telepítőt **rendszergazdaként** (jobb klikk -> Futtatás rendszergazdaként)
4. A telepítőben:
   - ✅ Pipáld be: "Add Python to PATH"
   - ✅ Pipáld be: "Install for all users"
   - Kattints az "Install Now" gombra
5. Várd meg a telepítés befejezését

> 💡 **Megjegyzés**: Ha több Python verzióval szeretnél dolgozni, vagy specific verzióra van szükséged, 
> nézd meg a [Python verziókezelés (pyenv)](../Python%20verziókezelés/pyenv.md) útmutatót.

### 2. VS Code vagy Cursor telepítése
1. VS Code: https://code.visualstudio.com/ vagy Cursor: https://cursor.sh/
2. Telepítsd az alkalmazást (alap beállítások megfelelőek)
3. Indítsd el az IDE-t
4. Telepítsd a Python bővítményt:
   - VS Code: Extensions menü (Ctrl+Shift+X) -> Keress rá: "Python" -> Install
   - Cursor: Általában előre telepítve van

### 3. PowerShell szkript futtatási jogosultság beállítása
1. Keresd meg a Windows Start menüben: "PowerShell"
2. Jobb klikk -> "Futtatás rendszergazdaként"
3. A megnyíló PowerShell ablakban másold be ezt a parancsot:
   ```powershell
   Set-ExecutionPolicy RemoteSigned
   ```
4. Amikor kérdezi, írd be: "Y" vagy "I" (igen)
5. Bezárhatod ezt az ablakot

## Projekt létrehozása és virtuális környezet beállítása

### 1. Projekt előkészítése
1. Nyisd meg a VS Code-ot vagy Cursor-t
2. File -> Open Folder -> Válaszd ki vagy hozd létre a projekt mappáját
3. Nyiss egy új **beépített** terminált az IDE-ben:
   - VS Code-ban: Terminal -> New Terminal (vagy Ctrl+Shift+ö)
   - Vagy használd a gyorsbillentyűt: Ctrl+Shift+ö
   - A terminál a VS Code/Cursor ablak alsó részében fog megjelenni
   - Ez már egy beépített terminál, nem kell külön PowerShell ablakot nyitni

> 💡 **Megjegyzés**: Ez már nem a Windows PowerShell különálló ablaka, hanem az IDE saját beépített terminálja, ami általában megbízhatóbban működik a virtuális környezetekkel.

### 2. Virtuális környezet létrehozása
1. A megnyílt terminálban írd be:
   ```powershell
   python -m venv venv
   ```
2. Zárd be az IDE-t, majd nyisd meg újra ugyanazt a mappát
3. Az IDE automatikusan felismeri a virtuális környezetet
4. Ha mégsem:
   - Nyomd meg: Ctrl+Shift+P
   - Írd be: "Python: Select Interpreter"
   - Válaszd ki a "venv" mappában lévő Python verziót

### 3. Környezet használata
Most már két módon is dolgozhatsz:

#### A. IDE beépített termináljával (ajánlott):
1. Nyiss új terminált (Ctrl+Shift+ö)
2. A terminál automatikusan aktiválja a környezetet
3. Ezt onnan látod, hogy a parancssor elején megjelenik a `(venv)`

#### B. Külön PowerShell ablakban:
1. Nyiss egy PowerShell ablakot
2. Navigálj a projekt mappájába (cd paranccsal)
3. Aktiváld a környezetet 

a) (cmd azaz command prompt):
   ```powershell
   .\venv\Scripts\activate
   ```
b) (PowerShell):
   ```powershell
   .\venv\Scripts\Activate.ps1
   ```de

### 4. Csomagok telepítése
A virtuális környezet aktiválása után:
```powershell
# Egy csomag telepítése
pip install requests

# Több csomag telepítése requirements.txt fájlból
pip install -r requirements.txt

# Telepített csomagok listázása
pip list

# Csomagok mentése requirements.txt fájlba
pip freeze > requirements.txt
```

### 5. Kilépés a környezetből
```powershell
deactivate
```

## Gyakori hibák és megoldások

### "python nem található" hiba
1. Nyisd meg a Windows beállításokat (Windows gomb + I)
2. Keress rá: "környezeti változók"
3. Kattints: "A rendszer környezeti változóinak módosítása"
4. Kattints: "Környezeti változók" gomb
5. A "Felhasználói változók" résznél keresd meg a "Path" sort
6. Ellenőrizd, hogy szerepel-e benne a Python mappája
   - Általában: C:\Users\[felhasználónév]\AppData\Local\Programs\Python\Python3x
   - És: C:\Users\[felhasználónév]\AppData\Local\Programs\Python\Python3x\Scripts

### "venv parancs nem található"
1. Ellenőrizd, hogy a megfelelő mappában vagy-e:
   ```powershell
   # Aktuális mappa kiírása
   pwd
   ```
2. Ha nem, navigálj oda:
   ```powershell
   cd "C:\teljes\elérési\út\a\projekt\mappához"
   ```

### VS Code/Cursor nem találja a Python interpretert
1. Ctrl+Shift+P
2. "Python: Select Interpreter"
3. Ha nem látod a venv-es Python-t:
   - Zárd be az IDE-t
   - Töröld a "venv" mappát
   - Nyisd meg újra az IDE-t
   - Hozd létre újra a virtuális környezetet

## Legjobb gyakorlatok

1. **Projekt struktúra:**
   ```
   projekt_mappa/
   ├── venv/           # Ezt ne verziókezeld!
   ├── requirements.txt # Ezt verziókezeld!
   ├── .gitignore      # Ebbe írd bele: venv/
   └── src/            # Python forrásfájlok
   ```

2. **Mindig aktiváld a környezetet** mielőtt:
   - Új csomagot telepítesz
   - Futtatod a programot
   - Fejlesztesz

3. **Requirements.txt kezelése:**
   - Új csomag telepítésekor frissítsd
   - Verziókezeld (add hozzá git-hez)
   - Írd bele a pontos verziókat

## Új fejlesztő csatlakozása a projekthez
1. Projekt klónozása
2. VS Code/Cursor megnyitása a projekt mappájában
3. Virtuális környezet létrehozása (lásd fent)
4. Függőségek telepítése:
   ```powershell
   pip install -r requirements.txt
   ```

## IDE-specifikus tippek

### VS Code
- A Python fájlok jobb felső sarkában látható a választott interpreter
- A beépített terminál automatikusan aktiválja a venv-et
- A debugging automatikusan a venv Python verzióját használja

### Cursor
- Hasonlóan működik, mint a VS Code
- Az AI-alapú kódkiegészítés figyelembe veszi a telepített csomagokat
- A beépített terminál itt is automatikusan kezeli a venv-et
