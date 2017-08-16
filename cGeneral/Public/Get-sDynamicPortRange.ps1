<#
.SYNOPSIS
    This function will present all rpc ports being configured for exchange of domain controller traffic
.DESCRIPTION
    This function will show all ports configured within the systems registry so we can ensure we open firewalls ports properly with a minimum set
.EXAMPLE
    PS C:\> Get-DynamicPortRange
    Will show NTDS, Netlogon, Internet, Dynamic ports
.EXAMPLE
    PS C:\> $providecredsofdc = get-credential
            invoke-command    -computername Nameofdomaincontroller -Credential $providecredsofdc -scriptblock ${function:get-DynamicPortRange}
    Will show NTDS, Netlogon, Internet, Dynamic ports of the specified system
.NOTES
    General notes
#>
function Get-sDynamicPortRange
{
    #Restricting Active Directory RPC traffic to a specific port
    #https://support.microsoft.com/en-us/help/224196/restricting-active-directory-rpc-traffic-to-a-specific-port
    $RestrictedADPortsRegKeys = @{
        NTDS     = 'hklm:\SYSTEM\CurrentControlSet\Services\NTDS\Parameters'
        NetLogon = 'hklm:\SYSTEM\CurrentControlSet\Services\Netlogon\Parameters'
    }

    $i = 0
    $OutputRestrictedADPortsRegKeys = @()
    [array]$RestrictedServicePorts = $RestrictedADPortsRegKeys.keys

    foreach ($item in $RestrictedADPortsRegKeys.Values)
    {
        try
        {
            $OutputRestrictedADPortsRegKeys += Get-ItemProperty $item -ErrorAction Stop | select *Port*
            Write-Verbose -Message "$env:COMPUTERNAME : RPC service : $($RestrictedServicePorts[$i]) : used a different port (range) : $(((($OutputRestrictedADPortsRegKeys[$i]|gm )|Where-Object ({$_.name -like '*Port*'}) | select Definition).Definition -split '=')[1])" -Verbose
        }
        catch
        {
            Write-Verbose -Message "$env:COMPUTERNAME : No keys set at specified path" -Verbose
        }
        $i++
    }
    #$OutputRestrictedADPortsRegKeys | fl

    #Restricting Internet (RPC) traffic to a specific port(range)
    #https://support.microsoft.com/en-us/help/154596/how-to-configure-rpc-dynamic-port-allocation-to-work-with-firewalls
    $RestrictedInternetPortsRegKeys = @{
        Internet = 'hklm:\SOFTWARE\Microsoft\Rpc\Internet'
    }

    $i = 0
    $OutputRestrictedInternetPortsRegKeys = @()
    [array]$RestrictedInternetPorts = $RestrictedInternetPortsRegKeys.keys

    foreach ($item in $RestrictedInternetPortsRegKeys.Values)
    {
        try
        {
            $OutputRestrictedInternetPortsRegKeys += Get-ItemProperty $item -ErrorAction Stop | select Ports
            Write-Verbose -Message "$env:COMPUTERNAME : RPC service : $($RestrictedInternetPorts[$i]) : used a different port (range) : $(((($OutputRestrictedInternetPortsRegKeys[$i]|gm )|Where-Object ({$_.name -like '*Ports*'}) | select Definition).Definition -split '=')[1])" -Verbose
        }
        catch
        {
            Write-Verbose -Message "$env:COMPUTERNAME : No keys set at specified path" -Verbose
        }
        $i++
    }
    #$OutputRestrictedInternetPortsRegKeys | fl    

    #Using default dynamic port range? In some case this range could overlap with domain rpc port ranges which will lead to ephemeral port notifications
    Write-Verbose -Message "$env:COMPUTERNAME : Displaying dynamic tcp/udp ports" -Verbose
    $Ipv4DynamicPortRangeTCP = netsh int ipv4 show dynamicport tcp
    $Ipv4DynamicPortRangeUDP = netsh int ipv4 show dynamicport udp

    $arr2 = @()
    $arr2 = $OutputRestrictedADPortsRegKeys + $OutputRestrictedInternetPortsRegKeys +$Ipv4DynamicPortRangeTCP + $Ipv4DynamicPortRangeUDP

    return $arr2 | fl
}