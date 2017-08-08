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
function Test-cAdministrator {  
    $CurUser = [Security.Principal.WindowsIdentity]::GetCurrent();
    [boolean]$Privilege = (New-Object Security.Principal.WindowsPrincipal $CurUser).IsInRole([Security.Principal.WindowsBuiltinRole]::Administrator)  
    if (!([boolean]$Privilege)) {
        Write-Error "This script must be executed from an elevated PowerShell process" -Category PermissionDenied 
    }
    return $Privilege
}