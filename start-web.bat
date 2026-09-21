@echo off
REM Sobe o MyAAC na porta 80. O cliente tem
REM http://127.0.0.1/login.php fixo no binario, entao sem isto
REM ele mostra "Connection refused" na tela de login.
set "PHP=%LOCALAPPDATA%\Microsoft\WinGet\Packages\PHP.PHP.8.3_Microsoft.Winget.Source_8wekyb3d8bbwe\php.exe"
if not exist "%PHP%" (
  echo PHP nao encontrado em: %PHP%
  pause
  exit /b 1
)
echo MyAAC em http://127.0.0.1/   ^(Ctrl+C encerra^)
"%PHP%" -S 0.0.0.0:80 -t "%~dp0myacc"
