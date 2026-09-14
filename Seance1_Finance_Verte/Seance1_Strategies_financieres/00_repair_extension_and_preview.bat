@echo off
cd /d "%~dp0"
where quarto >nul 2>nul
if errorlevel 1 (
  echo ERREUR: Quarto n'est pas reconnu dans le PATH.
  echo Installez Quarto: https://quarto.org/docs/get-started/
  pause
  exit /b 1
)
if not exist "_extensions\r-wasm\live" quarto add r-wasm/quarto-live --no-prompt
quarto preview seance1_live_doc.qmd
pause
