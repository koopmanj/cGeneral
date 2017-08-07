<#
.Synopsis
   Remove-cSoftwarePackage will require the itemproperties DisplayName and UninstallString to successfully uninstall a package, it can be achieved easily by executing Get-cSoftwarePackage
.DESCRIPTION
   Remove-cSoftwarePackage has a whatif statement, that will return what arguments will be executed if whatif was not supplied, ofc it will erase your package from disk.
.EXAMPLE
   Remove-cSoftwarePackage -whatif
.EXAMPLE
  Remove-cSoftwarePackage
#>
function Remove-cSoftwarePackage {
    param(
        $InstalledSoftware = (Get-cSoftwarePackage),
        [switch]$Whatif
    )

    foreach ($SoftwarePackage in $InstalledSoftware) {
        Write-Verbose -Message "$env:COMPUTERNAME : Removing package : $SoftwarePackage" -Verbose
        

        switch ($SoftwarePackage.DisplayName) {
            'Microsoft SQL Server 2012 Express LocalDB' {
                if ($Whatif) {
                    $SoftwarePackage = $SoftwarePackage.UninstallString.Replace('/I{', '/X{') + " /qb /norestart"
                    Write-Output "$env:COMPUTERNAME : Removing package -whatif : $SoftwarePackage"
                    Write-Output "$env:COMPUTERNAME : Start-Process cmd -ArgumentList /c $SoftwarePackage -Wait will be initiated"
                }
                else {
                    $SoftwarePackage = $SoftwarePackage.UninstallString.Replace('/I{', '/X{') + " /qb /norestart"
                    Start-Process cmd -ArgumentList "/c $SoftwarePackage" -Wait
                    Write-Output "$env:COMPUTERNAME : Uninstalled Package : $($SoftwarePackage |out-string) " -Verbose
                }
            }
            Default {
                if ($Whatif) {
                    $SoftwarePackage = $SoftwarePackage.UninstallString + " /qb /norestart"
                    Write-Output "$env:COMPUTERNAME : Removing package -whatif : $SoftwarePackage"
                    Write-Output "$env:COMPUTERNAME : Start-Process cmd -ArgumentList /c $SoftwarePackage -Wait will be initiated"
                }
                else {
                    $SoftwarePackage = $SoftwarePackage.UninstallString + " /qb /norestart"
                    $Executable = ($SoftwarePackage -split '( --lang)')[0]
                    $Arguments  = ($SoftwarePackage -split '(.exe")')[2]
                    Start-Process $Executable $Arguments
                    #Start-Process cmd -ArgumentList "/c $SoftwarePackage" -Wait
                    Write-Output "$env:COMPUTERNAME : Uninstalled Package : $($SoftwarePackage |out-string) " -Verbose
                }
            }
        }
    }
}