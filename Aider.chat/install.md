# Aider.chat telepítési útmutató

## Telepítés Windows rendszeren

1. Telepítés indítása:
   ```powershell
   python -m pip install aider-install
   ```

2. Telepítés ellenőrzése:
   ```powershell
   python -m pip uninstall aider-install
   ```
   - Ha a következő fájlokat listázza, akkor a telepítés sikeres volt:
     ```
     Would remove:
     c:\users\blaci\.pyenv\pyenv-win\versions\3.13.1\lib\site-packages\aider_install-0.1.3.dist-info\*
     c:\users\blaci\.pyenv\pyenv-win\versions\3.13.1\lib\site-packages\aider_install\*
     c:\users\blaci\.pyenv\pyenv-win\versions\3.13.1\scripts\aider-install.exe
     ```
   - Ne töröld a fájlokat, csak ellenőrizd a telepítést!

3. Aider futtatása:
   ```powershell
   c:\users\blaci\.pyenv\pyenv-win\versions\3.13.1\scripts\aider-install.exe
   ```

4. PATH beállítása:
   - Ha a telepítés után hibaüzenetet kapsz a PATH hiányáról, futtasd a kírt parancsot.

5. Virtuális környezetben használat:
   - Aider használható virtuális környezetben is:
   ```powershell
   python -m venv venv
   .\venv\Scripts\Activate.ps1
   python -m pip install aider-install
   ```

   5. A /help parancshoz előbb telepíteni kell az alábbi csomagot:
   ```powershell
   python.exe -m pip install --upgrade --upgrade-strategy only-if-needed aider-chat[help] --extra-index-url https://download.pytorch.org/whl/cpu
   ```

## Hibaelhárítás

- **Hiba: 'python' nem ismert parancs**
  - Telepítsd a Python-t: https://www.python.org/downloads/
  - Ellenőrizd, hogy a Python szerepel-e a PATH-ban:
    ```powershell
    python --version
    ```

- **Hiba: Permission denied**
  - Próbáld meg adminisztrátorként futtatni a parancsokat
  - Vagy használd a `--user` kapcsolót:
    ```powershell
    python -m pip install --user aider-install
    ```

- **Hiba: Nem található a virtuális környezet**
  - Ellenőrizd, hogy létezik-e a `venv` könyvtár
  - Ha nem, hozd létre újra:
    ```powershell
    python -m venv venv
    ```

## További információk

- Aider hivatalos dokumentációja: https://aider.chat/docs/
- Python virtuális környezet használata: https://docs.python.org/3/library/venv.html
- Pyenv telepítés és használat: https://github.com/pyenv-win/pyenv-win#installation
