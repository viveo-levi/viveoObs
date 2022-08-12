#### Script de instalação de agentes de Observabilidade ####
echo "Iniciando instalação agente Zabbix"
mkdir C:\Zabbix && cd C:\Zabbix
curl https://cdn.zabbix.com/zabbix/binaries/stable/6.2/6.2.1/zabbix_agent2-6.2.1-windows-amd64-openssl-static.zip -o zabbix.zip
Expand-Archive c:\Zabbix\zabbix.zip -DestinationPath c:\Zabbix\ && del C:\Zabbix\zabbix.zip
curl https://raw.githubusercontent.com/viveo-levi/viveoObs/main/zabbix_agent2_proxy.conf -o C:\Zabbix\conf\zabbix_agent2.conf
C:\Zabbix\bin\zabbix_agent2.exe --config C:\Zabbix\conf\zabbix_agent2.conf --install
