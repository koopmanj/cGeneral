<#.Synopsis
        Create a trust between the authoritative domain and customers, initiated at customer dc
        .DESCRIPTION
        This will establish a trust from the customer domain and establisch a trust with the specified one
        .EXAMPLE
        Add-ADForestTrust   -DomainControllerCustomerForest 'winxxxxvm' `
                            -DomainControllerCustomerForestCredentials (Get-Credential -UserName ('customer\'+(whoami.exe).split('\')[1]) `
                            -Message 'Provide credentials for the incoming forest domain, so the customer domain credentials') `
                            -AuthoritativeForest 'supportasp.local' `
                            -AuthoritativeAdminCredentials (Get-Credential -UserName (whoami.exe) -Message 'Provide credentials for authoritative domain') `
                            -TrustDirection 'Outbound'
        .EXAMPLE
        Add-ADForestTrust   -DomainControllerCustomerForest 'win****vm' 
                            -DomainControllerCustomerForestCredentials (Get-Credential -UserName qurrent\user -Message 'Provide credentials for the incoming forest domain, so the customer domain credentials') 
                            -AuthoritativeForest 'supportasp.local' -AuthoritativeAdminCredentials (Get-Credential -UserName jkoopman-a -Message 'Provide credentials for authoritative domain') 
                            -TrustDirection 'Outbound'
#>
Function Add-cADForestTrust {
    param(
        [parameter(Mandatory = $true)]
        [String]$DomainControllerCustomerForest,
        
        [parameter(Mandatory = $true)]
        [pscredential]$DomainControllerCustomerForestCredentials = (Get-Credential -UserName (whoami.exe) -Message 'Provide credentials for customer domain'),
        
        [parameter(Mandatory = $true)]
        [pscredential]$AuthoritativeAdminCredentials = (Get-Credential -UserName (whoami.exe) -Message 'Provide credentials for authoritative domain'),
                    
        [parameter(Mandatory = $true)]
        [String]$AuthoritativeForest,
        
        [parameter(Mandatory = $true)]
        [ValidateSet('Inbound', 'Outbound', 'Bidirectional')]
        [String]$TrustDirection = 'Outbound'
		
    )
    Function New-ADForestTrust {                                                                                                                                                            
        Param
        (
            [parameter(Mandatory = $true)]
            [String]$AuthoritativeForest, #= ((whoami.exe).split('\')[0]+'.local'),
            [parameter(Mandatory = $true)]
            [pscredential]$AuthoritativeAdminCredentials = (Get-Credential -UserName (whoami.exe) -Message 'Provide credentials for authoritative domain'),
            [parameter(Mandatory = $true)]
            [ValidateSet('Inbound', 'Outbound', 'Bidirectional')]
            [String]$TrustDirection = 'Outbound'
        )

        $remoteConnection = New-Object -TypeName System.DirectoryServices.ActiveDirectory.DirectoryContext -ArgumentList ('Forest', $AuthoritativeForest, $AuthoritativeAdminCredentials.UserName, $AuthoritativeAdminCredentials.GetNetworkCredential().Password)
    
        if ($null -ne (Resolve-DnsName $AuthoritativeForest)) {
            $AuthoritativeDNSEntries = (Resolve-DnsName $AuthoritativeForest)
            $GlobalAuthoritativeDNSEntries = $AuthoritativeDNSEntries | Where-Object -FilterScript {
                $_.ipaddress -notlike '*10.25*'
            }
            
            if (($null = Test-NetConnection -ComputerName ($GlobalAuthoritativeDNSEntries).ipaddress[0] -Port 135 -WarningAction SilentlyContinue).TcpTestSucceeded -eq $true) {
                $remoteForestConnection = [System.DirectoryServices.ActiveDirectory.Forest]::GetForest($remoteConnection)
                $localForest = [System.DirectoryServices.ActiveDirectory.Forest]::GetCurrentForest()

                try {
                    $null = $localForest.GetTrustRelationship($remoteForestConnection)
                    Write-Verbose -Message ($env:computername + ': Trust exists with: ' + $AuthoritativeForest) -Verbose
                }
                catch {
                    try {
                        $localForest.CreateTrustRelationship($remoteForestConnection, $TrustDirection)
                        Write-Verbose -Message ($env:computername + ': Established a successfull trust with: ' + $AuthoritativeForest) -Verbose
                    }
                    catch [System.Exception] {
                        Write-Error -Message "$env:computername : Establishing trust-direction: $TrustDirection for :  $remoteForestConnection failed"
                    }
                }
            }
            else {
                Write-Error -Message "$env:computername : Connection (TCP 135) failed to : $AuthoritativeForest"
            }
        }
        else {
            Write-Error -Message "$env:computername : Resolving $AuthoritativeForest failed"
        }
    }

    #Creating a new active directory forest trust
    Invoke-Command  -ComputerName $DomainControllerCustomerForest -Credential $DomainControllerCustomerForestCredentials `
        -ArgumentList $AuthoritativeForest, $AuthoritativeAdminCredentials, $TrustDirection -ScriptBlock ${function:New-ADForestTrust}
}