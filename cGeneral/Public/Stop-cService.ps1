<#
.Synopsis
   Stop-cService will stop the (list) of services you provide, and configure them to the StartType state
.EXAMPLE
   Stop-cService -Service bits -StartType manual
#>
function Stop-cService
{
    param(
        [string[]]$Service,
        $StartType = 'manual'
    )

    foreach ($Svc in $Service)
    {
        Get-Service $Service | Stop-Service -Force -Verbose 
        Get-Service $Service | Set-Service -StartupType $StartType -Verbose
    }

}