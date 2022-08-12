@echo ON
SET sharepath=\\GRUPOFW.COM.BR\NETLOGON\InstalaAgenteInventario
mkdir C:\Temp
:teamviewer (
echo %date% %time%
comp /M %sharepath%\teamviewer\teamviewer.msi C:\Temp\teamviewer.msi
IF %errorlevel% EQU 0 goto :zabbix
copy %sharepath%\teamviewer\teamviewer.msi C:\Temp\teamviewer.msi
copy %sharepath%\teamviewer\teamviewer.reg C:\Temp\teamviewer.reg
netsh advfirewall firewall add rule name="Teamviewer Host" dir=in action=allow protocol=TCP localport=5938
netsh advfirewall firewall add rule name="Teamviewer Host" dir=out action=allow protocol=TCP localport=5938
msiexec /i "C:\Temp\teamviewer.msi" /qn CUSTOMCONFIGID=6tdy4zv APITOKEN=15689852-ornJiHju0tILvgBVjTor ASSIGNMENTOPTIONS="--alias %COMPUTERNAME% --group FW --grant-easy-access" IMPORTREGFILE=1
goto zabbix ) > C:\Temp\teamviewer.log 2>&1
:zabbix (
IF exist "C:\Zabbix" goto :fusion 
echo %date% %time%
netsh advfirewall firewall del rule name="Zabbix Agent"
netsh advfirewall firewall add rule name="Zabbix Agent" dir=in action=allow protocol=TCP localport=10050
netsh advfirewall firewall add rule name="Zabbix Agent" dir=out action=allow protocol=TCP localport=10050
ROBOCOPY %sharepath%\zabbix C:\Zabbix /E
C:\Zabbix\zabbix_agentd.exe -i -c C:\Zabbix\zabbix_agentd.conf
sc start "Zabbix Agent" > C:\Temp\zabbix.log 2>&1
goto end ) > C:\Temp\zabbix.log 2>&1
:end
