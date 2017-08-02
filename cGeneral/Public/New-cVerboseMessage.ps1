<#
    .SYNOPSIS
    Displays a standardized verbose message.

    .PARAMETER Message
    String containing the key of the localized message.
#>
function New-cVerboseMessage {
    [CmdletBinding(
        #SupportsShouldProcess=$true,
        ConfirmImpact="High"
    )]
    [CmdletBinding()]
    [Alias()]
    [OutputType([String])]
    Param
    (
        [Parameter(Mandatory=$true)]
        $Message
    )
    Write-Verbose -Message "$env:COMPUTERNAME : $(Get-Date -format yyyy-MM-dd_HH:mm:ss) : $Message" -Verbose -whatif
}