$passFile = ".\pass.txt"
$securePassword = Get-Content $passFile | ConvertTo-SecureString -AsPlainText -Force
$username = "EVIL\Administrator"
$IP = "192.168.25.22"
$cred = New-Object System.Management.Automation.PSCredential -ArgumentList $username, $securePassword
# $oldSession = Get-PSSession
# if ($oldSession -eq "Broken") {
#     $oldId = $oldSession.Id
#     Remove-PSSession -Id $oldId
# }

New-PSSession -ComputerName $IP -Credential $cred
$newSession = Get-PSSession

# if ($newSession.State -eq "Opened") {
#     $newId = $newSession.Id
#     Write-Host $newId
#     # Write-Output $id.GetType()
#     Enter-PSSession -Id $newId
# }
$id = $newSession.Id
Enter-PSSession -Id $id
