param([Parameter(Mandatory=$true)] $JSONFILE)
function Create-ADUser() {
    param([Parameter(Mandatory=$true)] $usersobject)
    # Write-Output $usersobject
    $name = $usersobject.name
    $password = $usersobject.password
    # echo $name $password 
    $firstname, $lastname = $name.split(" ")
    $username = ($firstname[0] + $lastname).Tolower()
    $samAccountName = $username
    $prinicpalName = $username
    return $samAccountName,$name   
}
#pull out the name from the json object

$json = (Get-Content $JSONFILE | ConvertFrom-Json)
# Write-Host $json.users
#Write-Output $json.groups
# Write-Output $json.users
# Write-Output $json.users
Foreach ( $user in $json.users ){
    $samAccountname = Create-ADUser $user
    Write-Output "the sam account name of $name is $samAccountName"
    
}