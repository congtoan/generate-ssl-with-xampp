@echo off
setlocal enabledelayedexpansion

REM Get the current directory
set "script_dir=%~dp0"

set /p domain="Enter Domain: "
set "openssl_conf=%script_dir%cert-config.conf"

if not exist "%script_dir%%domain%" mkdir "%script_dir%%domain%"

REM Create a temporary configuration file
set "temp_conf=%script_dir%%domain%\temp.conf"

REM Copy cert-config.conf to the temporary file
copy "%openssl_conf%" "%temp_conf%"

REM Replace {{DOMAIN}} with the actual domain name in the temporary file
(for /f "tokens=*" %%A in (%temp_conf%) do (
    set "line=%%A"
    set "line=!line:{{DOMAIN}}=%domain%!"
    echo !line!
)) > "%script_dir%%domain%\cert-config.conf"

REM Delete the temporary configuration file
del "%temp_conf%"

REM Generate the certificate and key
"%script_dir%..\bin\openssl" req -config "%script_dir%%domain%\cert-config.conf" -new -sha256 -newkey rsa:2048 -nodes -keyout "%script_dir%%domain%\server.key" -x509 -days 365 -out "%script_dir%%domain%\server.crt" -batch

REM Delete actual cert config file
del "%script_dir%%domain%\cert-config.conf"

REM Install the certificate to the Trusted Root Certification Authorities store
certutil -addstore -f "Root" "%script_dir%%domain%\server.crt"

echo.
echo The certificate was created and installed.
echo -----
echo.
pause
