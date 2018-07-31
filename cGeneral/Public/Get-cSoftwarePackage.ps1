<#
.Synopsis
   Get-cSoftwarePackage will query the microsoft registry and search for the software(parametervalue) you provide.
.DESCRIPTION
   Get-cSoftwarePackage will accept multiple input param values and search the host for matching software
.EXAMPLE
   Get-cSoftwarePackage
#>
function Get-cSoftwarePackage {
    param(
        [object[]]$SoftwarePackageName = ('Veeam Agent for Microsoft Windows', 'Microsoft SQL Server 2012 Express LocalDB', 'Battle.net'),
        [object[]]$SoftwareRegPaths = ('HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall', 'HKLM:\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall')
    )

    #Query for install software reg paths
    $InstalledSoftware = Get-ChildItem -Path $InstalledSoftwareRegPaths
    
    #Quering all installed packages
    $InstalledPackages = @()
    foreach ($SoftwarePackage in $UninstallSoftwarePackageName) {
        Write-Verbose -Message "$env:COMPUTERNAME : Lookup for package : $SoftwarePackage" -Verbose
        $InstalledPackages += ($InstalledSoftware | Get-ItemProperty | Where-Object {$_.displayname -match $SoftwarePackage})
        if($InstalledPackages.DisplayName -notmatch $SoftwarePackage){
            Write-Warning -Message "$env:COMPUTERNAME : No package found : $SoftwarePackage" -Verbose        
        }
    }
    Write-Verbose -Message "$env:COMPUTERNAME : Packages found : $($InstalledPackages.DisplayName|out-string)" -Verbose
    
    return $InstalledPackages
}