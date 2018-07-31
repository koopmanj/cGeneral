#region Tests if the current active process is running with admin privilege
<#
    .SYNOPSIS
    Tests if the current active process is running with admin privilege
#>
function Test-Administrator {  
    $user = [Security.Principal.WindowsIdentity]::GetCurrent();
    (New-Object Security.Principal.WindowsPrincipal $user).IsInRole([Security.Principal.WindowsBuiltinRole]::Administrator)  
}
#endregion

<#
.SYNOPSIS
    Function to copy modules
.DESCRIPTION
    Long description
.EXAMPLE
    Copy-cModule
.EXAMPLE
    Copy-cModule -force
.INPUTS
    Inputs to this cmdlet (if any)
.OUTPUTS
    Output from this cmdlet (if any)
.NOTES
    General notes
.COMPONENT
    The component this cmdlet belongs to
.ROLE
    The role this cmdlet belongs to
.FUNCTIONALITY
    The functionality that best describes this cmdlet
#>
function Copy-cModule {
    param(  
        #lookup for onedrive disk path in registry
        $OneDriveRegistryPath = 'hkcu:\Software\Microsoft\OneDrive\',
        #set onedrive profile path
        $OneDrivePath = (Get-ItemProperty -Path $OneDriveRegistryPath -Name UserFolder).UserFolder,
        #set onedrive scriptlocation path
        $OneDriveModulePath = "$OnedrivePath\Documenten\Scripting\Powershell\Modules",
        #query for all modules starting with a lower c
        $OneDriveModuleNames = (Get-ChildItem $OneDriveModulePath).where( {$_ -match '^c'}),
        $PowerShellModulePath = $($env:PSModulePath.Split(';').Where( {$_ -like '*Program Files\WindowsPowerShell*' })[0]),
        [switch]$force
    )
    
    begin {
        #Write-Verbose -Message "$env:COMPUTERNAME : Visible  OneDrive Modules`t: $($OneDriveModuleNames.name)"      -Verbose
    }
    
    process {
        if ($force) {
            Copy-Item $OneDriveModuleNames.FullName -Recurse -Destination $PowerShellModulePath -Verbose -Force    
        }
        else {
            Copy-Item $OneDriveModuleNames.FullName -Recurse -Destination $PowerShellModulePath -Verbose    
        }
    }
    
    end {
    }
}

<#
.SYNOPSIS
    Function to copy modules
.DESCRIPTION
    Long description
.EXAMPLE
    Copy-cModule
.EXAMPLE
    Copy-cModule -force
.INPUTS
    Inputs to this cmdlet (if any)
.OUTPUTS
    Output from this cmdlet (if any)
.NOTES
    General notes
.COMPONENT
    The component this cmdlet belongs to
.ROLE
    The role this cmdlet belongs to
.FUNCTIONALITY
    The functionality that best describes this cmdlet
#>
function Copy-cInitialSetting {
    param(  
        #lookup for onedrive disk path in registry
        $OneDriveRegistryPath = 'hkcu:\Software\Microsoft\OneDrive\',
        #set onedrive profile path
        $OneDrivePath = (Get-ItemProperty -Path $OneDriveRegistryPath -Name UserFolder).UserFolder,
        #set onedrive scriptlocation path
        $OneDriveModulePath = "$OnedrivePath\Documenten\Scripting\Powershell\Modules",
        #query for all modules starting with a lower c
        $OneDriveInitialFile = (Get-ChildItem $OneDriveModulePath).where( {$_ -match '^InitializeGenericSettings.ps1'}),
        [switch]$force
    )
    
    begin {
        #Write-Verbose -Message "$env:COMPUTERNAME : Visible  OneDrive File`t: $($OneDriveInitialFile.name)"      -Verbose
        $SrcLastWriteTime = (Get-ChildItem $OneDriveInitialFile.FullName).LastWriteTime
        $DestLastWriteTime = (Get-ChildItem "$($OneDriveInitialFile.directory)\cgeneral\build\$($OneDriveInitialFile.name)").LastWriteTime
    }
    
    process {
        if ($force) {
            Copy-Item $OneDriveInitialFile.FullName -Destination "$($OneDriveInitialFile.directory)\cgeneral\build" -Verbose -Force    
        }
        elseif ((Compare-Object -IncludeEqual $SrcLastWriteTime $DestLastWriteTime).sideindicator -ne '==') {
            Copy-Item $OneDriveInitialFile.FullName -Destination "$($OneDriveInitialFile.directory)\cgeneral\build" -Verbose -Force    
        }
        else {
            #skip if the source and destination writetime are equal
            Write-Verbose -Message "$env:COMPUTERNAME : Initial settings loaded from Onedrive path, and in sync with the cGeneral module path" -Verbose
        }
    }
}

#region Test if a newer version of sGeneral is at the OneDrive location, if so just copy it over
<#
.SYNOPSIS
    This part will copy the newest version of sGeneral over if a newer resides on the onedrive locations
.DESCRIPTION
    Long description
.EXAMPLE
    PS C:\> <example usage>
    Explanation of what the example does
.INPUTS
    Inputs (if any)
.OUTPUTS
    Output (if any)
.NOTES
    General notes
#>
function get-cModule {
    param(  
        #lookup for onedrive disk path in registry
        $OneDriveRegistryPath = 'hkcu:\Software\Microsoft\OneDrive\',
        #set onedrive profile path
        $OneDrivePath = (Get-ItemProperty -Path $OneDriveRegistryPath -Name UserFolder).UserFolder,
        #set onedrive scriptlocation path
        $OneDriveModulePath = "$OnedrivePath\Documenten\Scripting\Powershell\Modules",
        #query for all modules starting with a lower c
        $OneDriveModuleNames = (Get-ChildItem $OneDriveModulePath).where( {$_ -match '^c'}),
        $PowerShellModulePath = $($env:PSModulePath.Split(';').Where( {$_ -like '*Program Files\WindowsPowerShell*' })[0])
    )

    $DestinationModulePath = @()
    $OneDriveModuleNames.ForEach( {$DestinationModulePath += "$PowerShellModulePath\$PSItem"})
    $SourceWriteTimes = (Get-ChildItem $OneDriveModuleNames.FullName -Recurse).where( {$_.name -like '*.psm1*'}).LastWriteTime
    $DestinationWriteTimes = (Get-ChildItem $DestinationModulePath -Recurse).where( {$_.name -like '*.psm1*'}).LastWriteTime
    
        
    #Write-Verbose -Message "$env:COMPUTERNAME : Visible  OneDrive Modules`t: $($OneDriveModuleNames.name)"      -Verbose
    if (Test-Administrator) {
        for ($i = 0; $i -lt $SourceWriteTimes.Count; $i++) {
            $Result = ((Compare-Object -IncludeEqual $SourceWriteTimes[$i] $DestinationWriteTimes[$i] -ErrorVariable DestNotExists).sideindicator[$i] -ne '==')
 
            #Check if modules is present at source location
            if ($DestNotExists) {
                #copy them over if not they don't exist
                Write-Verbose -Message "$env:COMPUTERNAME : Copying files from Onedrive module, cause of non-existance at destination" -Verbose
                Copy-cModule
            }
            elseif ($Result -eq $error) {
                write-host $Result
                #copy them over if they are newer at the source
                Write-Verbose -Message "$env:COMPUTERNAME : Copying files from Onedrive module, cause of changes made within it's source" -Verbose
                Copy-cModule -force
            }
            else {        
                #skip if the source and destination writetime are equal
                Write-Verbose -Message "$env:COMPUTERNAME : $($($OneDriveModuleNames.name)[$i]) is in sync with the local module(s)" -Verbose
            }
        }
    }
    else {        
        #skip if the source and destination writetime are equal
        Write-Verbose -Message "$env:COMPUTERNAME : The process is not running elevated, start an administrative PID" -Verbose
    }
    
}
#endregion
Copy-cInitialSetting
Get-cModule
Set-Location -Path ((Get-ItemProperty -Path 'hkcu:\Software\Microsoft\OneDrive\' -Name UserFolder).UserFolder + "\Documenten\Scripting\Powershell\Modules")

$error.Clear()
Import-Module posh-git -ErrorVariable IpmoErr
if($Error)
{
    Find-Module posh-git | Install-Module -Verbose -Force
    #skip if the source and destination writetime are equal
    Write-Verbose -Message "$env:COMPUTERNAME : Installing module posh-git cause it was not found on disk" -Verbose
} else {
    Write-Verbose -Message "$env:COMPUTERNAME : posh-git inserted" -Verbose
} 

<#
    code below should executed to create powershell profile directory files, 
    so it should be called manual the first time
 #>
function Set-GeneralModulePointer {
    param(
        [string]$PowerShellModulePath = $($env:PSModulePath.Split(';').Where( {$_ -like '*Program Files\WindowsPowerShell*' })[0]),
        [string]$OneDriveRegistryPath = 'hkcu:\Software\Microsoft\OneDrive\',
        [string]$OneDrivePath = (Get-ItemProperty -Path $OneDriveRegistryPath -Name UserFolder).UserFolder,
        [string]$OneDriveModulePath = "$OnedrivePath\Documenten\Scripting\Powershell\Modules",
        
        $ProfileTypes = @{
            VisualStudioCode = "\Microsoft.VSCode_profile.ps1"
            Powershell       = "\Microsoft.PowerShell_profile.ps1"
            PowershellISE    = "\Microsoft.PowerShellISE_profile.ps1"
        }
    )

    try {
        [string]$TruncedProfile = $profile | Split-Path
        Write-Verbose -Message "$env:COMPUTERNAME : Profile path : $TruncedProfile" -Verbose

        [object]$OneDriveGeneralModuleScript = $OneDriveModulePath + '\InitializeGenericSettings.ps1'
        Write-Verbose -Message "$env:COMPUTERNAME : Onedrive path : $OneDriveGeneralModuleScript" -Verbose
        
        $ProfileTypes.Values.ForEach( {
                Write-Verbose -Message "$env:COMPUTERNAME : Test path : $TruncedProfile$PSItem" -Verbose
                
                if (Test-Path -Path $TruncedProfile$PSItem) {
                    #controleer of het bestand een verwijzing heeft naar dit bestand
                    $FileContent = Get-Content $TruncedProfile$PSItem
                    Write-Verbose -Message "$env:COMPUTERNAME : Content of the file : $FileContent" -Verbose

                    if ($FileContent | Select-String -Pattern $OneDriveGeneralModuleScript ) {
                        Write-Verbose -Message "$env:COMPUTERNAME : Pointers to this file are set within : $TruncedProfile$PSItem" -Verbose
                    }
                }
                else {
                    Write-Verbose -Message "$env:COMPUTERNAME : Create a new file : $TruncedProfile$PSItem" -Verbose
                    
                    #maak nieuw bestand en verwijs naar dit bestand
                    new-item -ItemType File -Path $TruncedProfile$PSItem
                    
                    Write-Verbose -Message "$env:COMPUTERNAME : $($TruncedProfile + $PSItem) : Add-Content $OneDriveGeneralModuleScript" -Verbose
                    $(". ""$OneDriveGeneralModuleScript""" ) > ($TruncedProfile + $PSItem )
                    
                    Write-Verbose -Message "$env:COMPUTERNAME : Created a new file : $TruncedProfile$PSItem `n Added content to the file : $($OneDriveGeneralModuleScript)" -Verbose
                }
                write-host $TruncedProfile$PSItem
            })
        
    }
    catch {
        
    }
    finally {
        
    }
}
#Set-GeneralModulePointer