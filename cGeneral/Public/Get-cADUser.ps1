<#
.Synopsis
   Get-cADUser query domain for the provided group, and return the group users
.EXAMPLE
   Get-cADUser -DomainGroup ''
#>
Function Get-cADUser
{
    param(
        [string]$DomainGroup
    )

    try
    {
        $GroupMembers = (Get-ADGroup -Filter {name -like $DomainGroup} -Properties Member).member | Get-ADUser
        if($GroupMembers -eq $null)
        {
            $GroupMembers = ((Get-ADGroup -Filter {name -like $DomainGroup} -Properties Member).member   ).name
        }
    }
    catch
    {
        Write-Error $Error[0] | Format-List -Force
    }

    return $GroupMembers
}