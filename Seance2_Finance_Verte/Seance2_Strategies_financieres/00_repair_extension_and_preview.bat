@echo off
setlocal
cd /d "%~dp0"
where quarto >nul 2>nul
if errorlevel 1 (
  echo ERREUR: Quarto n'est pas reconnu dans le PATH.
  echo Installez Quarto: https://quarto.org/docs/get-started/
  pause
  exit /b 1
)

rem Ne pas se contenter de tester le dossier : une ancienne extraction peut
rem contenir une extension partielle sans resources\tinyyaml.lua.
set "LIVE_EXT=_extensions\r-wasm\live"
set "EXT_REPAIR=0"
if not exist "%LIVE_EXT%\live.lua" set "EXT_REPAIR=1"
if not exist "%LIVE_EXT%\resources\tinyyaml.lua" set "EXT_REPAIR=1"
if not exist "%LIVE_EXT%\resources\live-runtime.js" set "EXT_REPAIR=1"
if not exist "%LIVE_EXT%\templates\webr-editor.ojs" set "EXT_REPAIR=1"

if "%EXT_REPAIR%"=="1" (
  echo Extension Quarto Live absente ou incomplete. Reinstallation en cours...
  if exist "%LIVE_EXT%" rmdir /s /q "%LIVE_EXT%"
  quarto add r-wasm/quarto-live --no-prompt
  if errorlevel 1 (
    echo ERREUR: impossible d'installer l'extension r-wasm/quarto-live.
    echo Verifiez la connexion internet, puis relancez ce fichier.
    pause
    exit /b 1
  )
)

if not exist "%LIVE_EXT%\resources\tinyyaml.lua" (
  echo ERREUR: l'extension reste incomplete apres installation.
  echo Extrayez le package dans un nouveau dossier local puis relancez.
  pause
  exit /b 1
)

echo Extension Quarto Live verifiee.
quarto preview seance2_live_doc.qmd
pause
