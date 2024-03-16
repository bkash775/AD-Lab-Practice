# 01 Installing the Domain Controller
1. Use `sconfig` to:
    - change the hostname
    - change the IP address to static
    - change the DNS server to VMware IP

2. Install the Active Directory Windows features using powershell
```powershell
Install-windowsFeature -Name AD-Domain-Services -IncludeManagementTools
```


