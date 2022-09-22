echo #### Script de instalação de agentes de Observabilidade ####
echo "Iniciando instalacao agente Zabbix"
mkdir C:\Zabbix && cd C:\Zabbix
curl https://cdn.zabbix.com/zabbix/binaries/stable/6.2/6.2.1/zabbix_agent2-6.2.1-windows-amd64-openssl-static.zip -o zabbix.zip
powershell Expand-Archive c:\Zabbix\zabbix.zip -DestinationPath c:\Zabbix\ && del C:\Zabbix\zabbix.zip
curl https://raw.githubusercontent.com/viveo-levi/viveoObs/main/zabbix_agent2.conf -o C:\Zabbix\conf\zabbix_agent2.conf
C:\Zabbix\bin\zabbix_agent2.exe --config C:\Zabbix\conf\zabbix_agent2.conf --install
sc query "Zabbix Agent 2" | find "RUNNING" || net start "Zabbix Agent 2"
echo "Finalizando instalacao agente Zabbix"
echo "Iniciando instalacao agente Elastic"
mkdir "%PROGRAMFILES%\Elastic"
cd "%PROGRAMFILES%\Elastic"
mkdir certs
curl https://midias.grupofw.com.br/ca.crt -o certs\ca.crt
curl https://artifacts.elastic.co/downloads/beats/elastic-agent/elastic-agent-8.1.1-windows-x86_64.zip -o elastic.zip
powershell Expand-Archive elastic.zip -DestinationPath . && del elastic.zip
cd elastic-agent-8.1.1-windows-x86_64
.\elastic-agent.exe install -f --url=https://vdcraoelmst01.viveo.corp:8220 --enrollment-token=SERWcE5vSUJlYUUxd21meGVELU86RGtRdGd3TlVTQVNQWnZUMFVqRGdBZw== --certificate-authorities="C:\Program Files\Elastic\certs\ca.crt"
sc query "Elastic Agent" | find "RUNNING" || net start "Elastic Agent"
del /s /f "%PROGRAMFILES%\Elastic\elastic-agent-8.1.1-windows-x86_64"
echo "Finalizando instalacao agente Elastic"
