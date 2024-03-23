# 01 Installing the Domain Controller
1. Use `sconfig` to:
    - change the hostname
    ```powershell
    Rename-Computer -NewName <computername>
    ```
    - change the IP address to static
    - change the DNS server to VMware IP

2. Install the Active Directory Windows features using powershell
```powershell
Install-windowsFeature -Name AD-Domain-Services -IncludeManagementTools
```


# 02 Joined the Domain Controller 
1. change the dnsseveraddress to our DC1:XCorp.com
    ```powershell
    Get-NetIPAddress -InterfaceIndex <no>
    Get-DNSClientSererAddress -InterfaceIndex <no>
    Set-DNSClientSererAddress -InterfaceIndex <no> -ServerAddress <ip of DC1>
    ```
2. Joind the DC1
    ```powershell
    Add-Computer -DomainName XCorp.com -Crendtial (Get-Credential) -Force -Restart
    ```
    

    