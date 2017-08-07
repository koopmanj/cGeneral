## cGeneral ##
This **cGeneral** module contains 9 functions that should provide assistance for automation purposes.

### Functions ###
The functions this modules contains coexist of the following names:

Get-cADUser
Get-cSoftwarePackage
Get-cURL
New-cVerboseMessage
Remove-cSoftwarePackage
Rename-cContent
Start-cService
Stop-cService
Test-cAdministrator



### Installation ###
The installation of this module can be achieved by registering a NuGet repository:

*register-psrepository -name reponame -sourcelocation "http://repourl/nuget" -publishLocation "http://repourl/nuget" -installationPolicy trusted*

*find-module -name cGeneral*

*-or*

*find-module -name cGeneral -repository reponame*


### Detailed information about the functions###

NAME
    Get-cADUser
    
SYNOPSIS
    Get-cADUser query domain for the provided group, and return the group users
    
    
SYNTAX
    Get-cADUser [[-DomainGroup] <String>] [<CommonParameters>]
    
    
DESCRIPTION
    

PARAMETERS
    -DomainGroup <String>
        
        Required?                    false
        Position?                    1
        Default value                
        Accept pipeline input?       false
        Accept wildcard characters?  false
        
    <CommonParameters>
        This cmdlet supports the common parameters: Verbose, Debug,
        ErrorAction, ErrorVariable, WarningAction, WarningVariable,
        OutBuffer, PipelineVariable, and OutVariable. For more information, see 
        about_CommonParameters (http://go.microsoft.com/fwlink/?LinkID=113216). 
    
INPUTS
    
OUTPUTS
    
    -------------------------- EXAMPLE 1 --------------------------
    
    PS C:\>Get-cADUser -DomainGroup ''
    
    
    
    
    
    
    
RELATED LINKS

---

NAME
    Get-cSoftwarePackage
    
SYNOPSIS
    Get-cSoftwarePackage will query the microsoft registry and search for the software(parametervalue) you provide.
    
    
SYNTAX
    Get-cSoftwarePackage [[-SoftwarePackageName] <Object[]>] [[-SoftwareRegPaths] <Object[]>] [<CommonParameters>]
    
    
DESCRIPTION
    Get-cSoftwarePackage will accept multiple input param values and search the host for matching software
    

PARAMETERS
    -SoftwarePackageName <Object[]>
        
        Required?                    false
        Position?                    1
        Default value                ('Veeam Agent for Microsoft Windows', 'Microsoft SQL Server 2012 Express LocalDB', 'Battle.net')
        Accept pipeline input?       false
        Accept wildcard characters?  false
        
    -SoftwareRegPaths <Object[]>
        
        Required?                    false
        Position?                    2
        Default value                ('HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall', 
        'HKLM:\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall')
        Accept pipeline input?       false
        Accept wildcard characters?  false
        
    <CommonParameters>
        This cmdlet supports the common parameters: Verbose, Debug,
        ErrorAction, ErrorVariable, WarningAction, WarningVariable,
        OutBuffer, PipelineVariable, and OutVariable. For more information, see 
        about_CommonParameters (http://go.microsoft.com/fwlink/?LinkID=113216). 
    
INPUTS
    
OUTPUTS
    
    -------------------------- EXAMPLE 1 --------------------------
    
    PS C:\>Get-cSoftwarePackage
    
    
    
    
    
    
    
RELATED LINKS

---

NAME
    Get-cURL
    
SYNOPSIS
    Uniform while loop to wget or iwr an url.
    
    
SYNTAX
    Get-cURL [[-Url] <Object>] [[-Times] <Object>] [<CommonParameters>]
    
    
DESCRIPTION
    

PARAMETERS
    -Url <Object>
        Provide the url being tested.
        
        Required?                    false
        Position?                    1
        Default value                https://www.google.com
        Accept pipeline input?       false
        Accept wildcard characters?  false
        
    -Times <Object>
        The amount of times this provided URL will be queried.
        
        Required?                    false
        Position?                    2
        Default value                5
        Accept pipeline input?       false
        Accept wildcard characters?  false
        
    <CommonParameters>
        This cmdlet supports the common parameters: Verbose, Debug,
        ErrorAction, ErrorVariable, WarningAction, WarningVariable,
        OutBuffer, PipelineVariable, and OutVariable. For more information, see 
        about_CommonParameters (http://go.microsoft.com/fwlink/?LinkID=113216). 
    
INPUTS
    
OUTPUTS
    
    
RELATED LINKS

---

NAME
    New-cVerboseMessage
    
SYNOPSIS
    Displays a standardized verbose message.
    
    
SYNTAX
    New-cVerboseMessage [-Message] <Object> [<CommonParameters>]
    
    
DESCRIPTION
    

PARAMETERS
    -Message <Object>
        String containing the key of the localized message.
        
        Required?                    true
        Position?                    1
        Default value                
        Accept pipeline input?       false
        Accept wildcard characters?  false
        
    <CommonParameters>
        This cmdlet supports the common parameters: Verbose, Debug,
        ErrorAction, ErrorVariable, WarningAction, WarningVariable,
        OutBuffer, PipelineVariable, and OutVariable. For more information, see 
        about_CommonParameters (http://go.microsoft.com/fwlink/?LinkID=113216). 
    
INPUTS
    
OUTPUTS
    System.String
    
    
    
RELATED LINKS

---

NAME
    Remove-cSoftwarePackage
    
SYNOPSIS
    Remove-cSoftwarePackage will require the itemproperties DisplayName and UninstallString to successfully uninstall a package, it can be achieved easily by 
    executing Get-cSoftwarePackage
    
    
SYNTAX
    Remove-cSoftwarePackage [[-InstalledSoftware] <Object>] [-Whatif] [<CommonParameters>]
    
    
DESCRIPTION
    Remove-cSoftwarePackage has a whatif statement, that will return what arguments will be executed if whatif was not supplied, ofc it will erase your package 
    from disk.
    

PARAMETERS
    -InstalledSoftware <Object>
        
        Required?                    false
        Position?                    1
        Default value                (Get-cSoftwarePackage)
        Accept pipeline input?       false
        Accept wildcard characters?  false
        
    -Whatif [<SwitchParameter>]
        
        Required?                    false
        Position?                    named
        Default value                False
        Accept pipeline input?       false
        Accept wildcard characters?  false
        
    <CommonParameters>
        This cmdlet supports the common parameters: Verbose, Debug,
        ErrorAction, ErrorVariable, WarningAction, WarningVariable,
        OutBuffer, PipelineVariable, and OutVariable. For more information, see 
        about_CommonParameters (http://go.microsoft.com/fwlink/?LinkID=113216). 
    
INPUTS
    
OUTPUTS
    
    -------------------------- EXAMPLE 1 --------------------------
    
    PS C:\>Remove-cSoftwarePackage -whatif
    
    
    
    
    
    
    -------------------------- EXAMPLE 2 --------------------------
    
    PS C:\>Remove-cSoftwarePackage
    
    
    
    
    
    
    
RELATED LINKS

---

NAME
    Rename-cContent
    
SYNOPSIS
    Replace content string within a file
    
    
SYNTAX
    Rename-cContent [[-Path] <String>] [[-FindString] <String>] [[-ReplaceString] <String>] [<CommonParameters>]
    
    
DESCRIPTION
    This function will query the specified path and replace the findstring with a value of the replacestring
    

PARAMETERS
    -Path <String>
        
        Required?                    false
        Position?                    1
        Default value                D:\jko\_Jobs
        Accept pipeline input?       false
        Accept wildcard characters?  false
        
    -FindString <String>
        
        Required?                    false
        Position?                    2
        Default value                
        Accept pipeline input?       false
        Accept wildcard characters?  false
        
    -ReplaceString <String>
        
        Required?                    false
        Position?                    3
        Default value                
        Accept pipeline input?       false
        Accept wildcard characters?  false
        
    <CommonParameters>
        This cmdlet supports the common parameters: Verbose, Debug,
        ErrorAction, ErrorVariable, WarningAction, WarningVariable,
        OutBuffer, PipelineVariable, and OutVariable. For more information, see 
        about_CommonParameters (http://go.microsoft.com/fwlink/?LinkID=113216). 
    
INPUTS
    
OUTPUTS
    
NOTES
    
    
        General notes
    
    -------------------------- EXAMPLE 1 --------------------------
    
    PS C:\>Replace-Content -Path "D:\jko\_Jobs" -FindString "mx.internal.asp4all.nl" -ReplaceString "smarthost-asd2.solvinity.net"
    
    
    
    
    
    
    
RELATED LINKS

---

NAME
    Start-cService
    
SYNOPSIS
    Start-cService will start the (list) of services you provide, and configure them to the StartType state
    
    
SYNTAX
    Start-cService [[-Service] <String[]>] [[-StartType] <Object>] [<CommonParameters>]
    
    
DESCRIPTION
    

PARAMETERS
    -Service <String[]>
        
        Required?                    false
        Position?                    1
        Default value                
        Accept pipeline input?       false
        Accept wildcard characters?  false
        
    -StartType <Object>
        
        Required?                    false
        Position?                    2
        Default value                automatic
        Accept pipeline input?       false
        Accept wildcard characters?  false
        
    <CommonParameters>
        This cmdlet supports the common parameters: Verbose, Debug,
        ErrorAction, ErrorVariable, WarningAction, WarningVariable,
        OutBuffer, PipelineVariable, and OutVariable. For more information, see 
        about_CommonParameters (http://go.microsoft.com/fwlink/?LinkID=113216). 
    
INPUTS
    
OUTPUTS
    
    -------------------------- EXAMPLE 1 --------------------------
    
    PS C:\>Start-cService -Service bits -StartType automatic
    
    
    
    
    
    
    
RELATED LINKS

---

NAME
    Stop-cService
    
SYNOPSIS
    Stop-cService will stop the (list) of services you provide, and configure them to the StartType state
    
    
SYNTAX
    Stop-cService [[-Service] <String[]>] [[-StartType] <Object>] [<CommonParameters>]
    
    
DESCRIPTION
    

PARAMETERS
    -Service <String[]>
        
        Required?                    false
        Position?                    1
        Default value                
        Accept pipeline input?       false
        Accept wildcard characters?  false
        
    -StartType <Object>
        
        Required?                    false
        Position?                    2
        Default value                manual
        Accept pipeline input?       false
        Accept wildcard characters?  false
        
    <CommonParameters>
        This cmdlet supports the common parameters: Verbose, Debug,
        ErrorAction, ErrorVariable, WarningAction, WarningVariable,
        OutBuffer, PipelineVariable, and OutVariable. For more information, see 
        about_CommonParameters (http://go.microsoft.com/fwlink/?LinkID=113216). 
    
INPUTS
    
OUTPUTS
    
    -------------------------- EXAMPLE 1 --------------------------
    
    PS C:\>Stop-cService -Service bits -StartType manual
    
    
    
    
    
    
    
RELATED LINKS

---

NAME
    Test-cAdministrator
    
SYNOPSIS
    This function will provide a value $true or $false depending if the process is running elevated or not
    
    
SYNTAX
    Test-cAdministrator [<CommonParameters>]
    
    
DESCRIPTION
    

PARAMETERS
    <CommonParameters>
        This cmdlet supports the common parameters: Verbose, Debug,
        ErrorAction, ErrorVariable, WarningAction, WarningVariable,
        OutBuffer, PipelineVariable, and OutVariable. For more information, see 
        about_CommonParameters (http://go.microsoft.com/fwlink/?LinkID=113216). 
    
INPUTS
    None
    
    
OUTPUTS
    $true or $false
    
    
    -------------------------- EXAMPLE 1 --------------------------
    
    PS C:\>Test-cAdministrator True
    
    
    
    
    
    
    -------------------------- EXAMPLE 2 --------------------------
    
    PS C:\>Test-cAdministrator False
    
    
    
    
    
    
    
RELATED LINKS

---



### Detailed folder structure###
+---build
+---cGeneral
|   +---Private
|   \---Public
\---Tests
    +---integration
    \---unit


### Contributing ###
*Koopman & Co Engineering*

### Links ###
**[Git cGeneral Repo](git@github.com:koopmanj/cGeneral.git)**
