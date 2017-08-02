<#
.SYNOPSIS 
 This function will provide a value $true or $false depending if the process is running elevated or not
.EXAMPLE  
 Test-cAdministrator True
.EXAMPLE  
 Test-cAdministrator False
.INPUTS
 None
.OUTPUTS
 $true or $false
#>
function Test-cAdministrator  
{  
    $user = [Security.Principal.WindowsIdentity]::GetCurrent();
    (New-Object Security.Principal.WindowsPrincipal $user).IsInRole([Security.Principal.WindowsBuiltinRole]::Administrator)  
}
Export-ModuleMember -Function Test-cAdministrator
