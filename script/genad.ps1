param([Parameter(Mandatory=$true)] $JSONFILE)

function CreateADGroup() {
    param([Parameter(Mandatory=$true)] $groupObject)
    $name = $groupObject.name
    New-ADGroup -Name $name -GroupScope Global

}


function CreateADUser() {
    param([Parameter(Mandatory=$true)] $usersobject)
    # Write-Output $usersobject
    $name = $usersobject.name
    $password = $usersobject.password
    # echo $name $password 
    $firstname, $lastname = $name.split(" ")
    $username = ($firstname[0] + $lastname).Tolower()
    $samAccountName = $username
    $prinicpalName = $username
    
    #creating  the ad user
    New-ADUser "$name" -GivenName $firstname -Surname $lastname -SamAccountName $samAccountName -UserPrincipalName $prinicpalName@$Global:Domain -AccountPassword (ConvertTo-SecureString $password -AsPlainText -Force) -PassThru | Enable-ADAccount

    #add the user to the specific group
    foreach($group_name in $usersobject.groups) {
        try{
            Get-ADGroup -Identity "$group_name"
            Add-ADGroupMember -Identity $group_name -Members $username
        }
        catch [Microsoft.ActiveDirectory.Management.ADIdentityNotFoundException] 
        {
            Write-Warning "user $name not added to group $group_name because it doesnot exits"
        }
    }
}
$json = (Get-Content $JSONFILE) | ConvertFrom-Json
$Global:Domain = $json.domain 
Write-Output $Domain

foreach( $group in $json.groups ) {
    CreateADGroup $group
    
}
foreach ( $user in $json.users ){
    Create-ADUser $user 
     
}