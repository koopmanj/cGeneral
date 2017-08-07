<#
.Synopsis
   Start-cService will start the (list) of services you provide, and configure them to the StartType state
.EXAMPLE
   Start-cService -Service bits -StartType automatic
#>
function Start-cService
{
    param(
        [string[]]$Service,
        $StartType = 'automatic'
    )

    foreach ($Svc in $Service)
    {
        Get-Service $Svc | Start-Service -Verbose 
        Get-Service $Svc | Set-Service -StartupType $StartType -Verbose
        
    }

}
