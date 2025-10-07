@echo off
setlocal enabledelayedexpansion

echo === Pandoc + pandoc-crossref Setup ===
echo.

:: ---------------------------------------------------------
:: a) Pandoc installieren
:: ---------------------------------------------------------
where pandoc >nul 2>&1
if %errorlevel%==0 (
    for /f "delims=" %%p in ('where pandoc') do set PANDOC_PATH=%%p
    echo Pandoc bereits gefunden unter: %PANDOC_PATH%
    set /p INSTALL_PANDOC="Pandoc trotzdem neu installieren? (y/n): "
    if /I "%INSTALL_PANDOC%"=="y" (
        echo Installiere Pandoc ...
        winget install --source winget --exact --id JohnMacFarlane.Pandoc
    ) else (
        echo Überspringe Pandoc-Installation.
    )
) else (
    set /p INSTALL_PANDOC="Pandoc nicht gefunden. Installieren? (y/n): "
    if /I "%INSTALL_PANDOC%"=="y" (
        winget install --source winget --exact --id JohnMacFarlane.Pandoc
    ) else (
        echo Überspringe Pandoc.
    )
)
echo.

:: ---------------------------------------------------------
:: b) pandoc-crossref herunterladen
:: ---------------------------------------------------------
set "TARGET=%USERPROFILE%\AppData\Local\Pandoc"
set "XREF=%TARGET%\pandoc-crossref.exe"

if exist "%XREF%" (
    echo pandoc-crossref bereits vorhanden unter: %XREF%
    set /p INSTALL_XREF="Trotzdem neu herunterladen und installieren? (y/n): "
) else (
    set /p INSTALL_XREF="pandoc-crossref nicht gefunden. Installieren? (y/n): "
)

if /I "%INSTALL_XREF%"=="y" (
    if not exist "%TARGET%" mkdir "%TARGET%"
    echo Lade pandoc-crossref...
    curl -L -o "%TEMP%\pandoc-crossref.7z" ^
        https://github.com/lierdakil/pandoc-crossref/releases/latest/download/pandoc-crossref-Windows-X64.7z

    echo Entpacke nach %TARGET%...

    "C:\Program Files\7-Zip\7z.exe" x "%TEMP%\pandoc-crossref.7z" -o"%TARGET%" -y

) else (
    echo Überspringe pandoc-crossref.
)
echo.

:: ---------------------------------------------------------
:: c) Git Bash .bashrc anpassen
:: ---------------------------------------------------------
set /p UPDATE_BASHRC="~/.bashrc fuer Git Bash mit PATH-Erweiterung aktualisieren? (y/n): "
if /I "%UPDATE_BASHRC%"=="y" (
    set "BASHRC=%USERPROFILE%\.bashrc"

    if not exist "%BASHRC%" (
        type nul > "%BASHRC%"
    )

    if exist "%BASHRC%" (
        findstr /C:"/c/Users/$USERNAME/AppData/Local/Pandoc" "%BASHRC%" >nul 2>&1
        if errorlevel 1 (
            echo export PATH="$PATH:/c/Users/$USERNAME/AppData/Local/Pandoc" >> "%BASHRC%"
            echo Pfad-Erweiterung zu %BASHRC% hinzugefuegt.
        ) else (
            echo Pfad-Erweiterung bereits vorhanden.
        )
    )
) else (
    echo Überspringe .bashrc-Anpassung.
)

echo.
echo === Setup fertig ===
echo.

:: ---------------------------------------------------------
:: d) Versionen ausgeben
:: ---------------------------------------------------------
echo Pandoc-Version:
where pandoc >nul 2>&1 && pandoc --version || echo Pandoc nicht im PATH gefunden.
echo.
echo pandoc-crossref-Version:
if exist "%TARGET%\pandoc-crossref.exe" (
    "%TARGET%\pandoc-crossref.exe" --version
) else (
    echo pandoc-crossref nicht gefunden.
)

pause
