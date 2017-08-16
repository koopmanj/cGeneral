## cGeneral ##
This **cGeneral** module contains 13 functions that should provide assistance for automation purposes.

### Functions ###
The functions this modules contains coexist of the following names:

Add-cADForestTrust
Get-cADUser
Get-cRemoteProgram
Get-cSoftwarePackage
Get-cURL
Get-sDynamicPortRange
New-cVerboseMessage
Remove-cSoftwarePackage
Rename-cContent
Set-cSystemCenterConfiguration
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
    Add-cADForestTrust
    
SYNOPSIS
    Create a trust between the authoritative domain and customers, initiated at customer dc
    
    
SYNTAX
    Add-cADForestTrust [-DomainControllerCustomerForest] <String> [-DomainControllerCustomerForestCredentials] <PSCredential> [-AuthoritativeAdminCredentials] <PSCredential> 
    [-AuthoritativeForest] <String> [-TrustDirection] <String> [<CommonParameters>]
    
    
DESCRIPTION
    This will establish a trust from the customer domain and establisch a trust with the specified one
    

PARAMETERS
    -DomainControllerCustomerForest <String>
        
        Required?                    true
        Position?                    1
        Default value                
        Accept pipeline input?       false
        Accept wildcard characters?  false
        
    -DomainControllerCustomerForestCredentials <PSCredential>
        
        Required?                    true
        Position?                    2
        Default value                (Get-Credential -UserName (whoami.exe) -Message 'Provide credentials for customer domain')
        Accept pipeline input?       false
        Accept wildcard characters?  false
        
    -AuthoritativeAdminCredentials <PSCredential>
        
        Required?                    true
        Position?                    3
        Default value                (Get-Credential -UserName (whoami.exe) -Message 'Provide credentials for authoritative domain')
        Accept pipeline input?       false
        Accept wildcard characters?  false
        
    -AuthoritativeForest <String>
        
        Required?                    true
        Position?                    4
        Default value                
        Accept pipeline input?       false
        Accept wildcard characters?  false
        
    -TrustDirection <String>
        
        Required?                    true
        Position?                    5
        Default value                Outbound
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
    
    PS C:\>Add-ADForestTrust   -DomainControllerCustomerForest 'winxxxxvm' `
    
    -DomainControllerCustomerForestCredentials (Get-Credential -UserName ('customer\'+(whoami.exe).split('\')[1]) `
                        -Message 'Provide credentials for the incoming forest domain, so the customer domain credentials') `
                        -AuthoritativeForest 'supportasp.local' `
                        -AuthoritativeAdminCredentials (Get-Credential -UserName (whoami.exe) -Message 'Provide credentials for authoritative domain') `
                        -TrustDirection 'Outbound'
    
    
    
    
    -------------------------- EXAMPLE 2 --------------------------
    
    PS C:\>Add-ADForestTrust   -DomainControllerCustomerForest 'win****vm'
    
    -DomainControllerCustomerForestCredentials (Get-Credential -UserName qurrent\user -Message 'Provide credentials for the incoming forest domain, so the customer domain credentials') 
                        -AuthoritativeForest 'supportasp.local' -AuthoritativeAdminCredentials (Get-Credential -UserName jkoopman-a -Message 'Provide credentials for authoritative domain') 
                        -TrustDirection 'Outbound'
    
    
    
    
    
RELATED LINKS

---

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
    Get-cRemoteProgram
    
SYNOPSIS
    Generates a list of installed programs on a computer
    
    
SYNTAX
    Get-cRemoteProgram [[-ComputerName] <String[]>] [[-Property] <String[]>] [-ExcludeSimilar] [-SimilarWord <Int32>] [-WhatIf] [-Confirm] [<CommonParameters>]
    
    
DESCRIPTION
    This function generates a list by querying the registry and returning the installed programs of a local or remote computer.
    

PARAMETERS
    -ComputerName <String[]>
        The computer to which connectivity will be checked
        
        Required?                    false
        Position?                    1
        Default value                $env:COMPUTERNAME
        Accept pipeline input?       true (ByValue, ByPropertyName)
        Accept wildcard characters?  false
        
    -Property <String[]>
        Additional values to be loaded from the registry. Can contain a string or an array of string that will be attempted to retrieve from the registry for each program entry
        
        Required?                    false
        Position?                    1
        Default value                
        Accept pipeline input?       false
        Accept wildcard characters?  false
        
    -ExcludeSimilar [<SwitchParameter>]
        This will filter out similar programnames, the default value is to filter on the first 3 words in a program name. If a program only consists of less words it is excluded and it 
        will not be filtered. For example if you Visual Studio 2015 installed it will list all the components individually, using -ExcludeSimilar will only display the first entry.
        
        Required?                    false
        Position?                    named
        Default value                False
        Accept pipeline input?       false
        Accept wildcard characters?  false
        
    -SimilarWord <Int32>
        This parameter only works when ExcludeSimilar is specified, it changes the default of first 3 words to any desired value.
        
        Required?                    false
        Position?                    named
        Default value                0
        Accept pipeline input?       false
        Accept wildcard characters?  false
        
    -WhatIf [<SwitchParameter>]
        
        Required?                    false
        Position?                    named
        Default value                
        Accept pipeline input?       false
        Accept wildcard characters?  false
        
    -Confirm [<SwitchParameter>]
        
        Required?                    false
        Position?                    named
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
    
    
        Name       : Get-RemoteProgram
        Author     : Jaap Brasser
        Version    : 1.3
        DateCreated: 2013-08-23
        DateUpdated: 2016-08-26
        Blog       : http://www.jaapbrasser.com
    
    -------------------------- EXAMPLE 1 --------------------------
    
    PS C:\>Get-RemoteProgram
    
    Description:
    Will generate a list of installed programs on local machine
    
    
    
    
    -------------------------- EXAMPLE 2 --------------------------
    
    PS C:\>Get-RemoteProgram -ComputerName server01,server02
    
    Description:
    Will generate a list of installed programs on server01 and server02
    
    
    
    
    -------------------------- EXAMPLE 3 --------------------------
    
    PS C:\>Get-RemoteProgram -ComputerName Server01 -Property DisplayVersion,VersionMajor
    
    Description:
    Will gather the list of programs from Server01 and attempts to retrieve the displayversion and versionmajor subkeys from the registry for each installed program
    
    
    
    
    -------------------------- EXAMPLE 4 --------------------------
    
    PS C:\>'server01','server02' | Get-RemoteProgram -Property Uninstallstring
    
    Description
    Will retrieve the installed programs on server01/02 that are passed on to the function through the pipeline and also retrieves the uninstall string for each program
    
    
    
    
    -------------------------- EXAMPLE 5 --------------------------
    
    PS C:\>'server01','server02' | Get-RemoteProgram -Property Uninstallstring -ExcludeSimilar -SimilarWord 4
    
    Description
    Will retrieve the installed programs on server01/02 that are passed on to the function through the pipeline and also retrieves the uninstall string for each program. Will only display 
    a single entry of a program of which the first four words are identical.
    
    
    
    
    
RELATED LINKS
    http://www.jaapbrasser.com

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
        Default value                ('HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall', 'HKLM:\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall')
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
    Get-sDynamicPortRange
    
SYNOPSIS
    This function will present all rpc ports being configured for exchange of domain controller traffic
    
    
SYNTAX
    Get-sDynamicPortRange [<CommonParameters>]
    
    
DESCRIPTION
    This function will show all ports configured within the systems registry so we can ensure we open firewalls ports properly with a minimum set
    

PARAMETERS
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
    
    PS C:\>Get-DynamicPortRange
    
    Will show NTDS, Netlogon, Internet, Dynamic ports
    
    
    
    
    -------------------------- EXAMPLE 2 --------------------------
    
    PS C:\>$providecredsofdc = get-credential
    
    invoke-command    -computername Nameofdomaincontroller -Credential $providecredsofdc -scriptblock ${function:get-DynamicPortRange}
    Will show NTDS, Netlogon, Internet, Dynamic ports of the specified system
    
    
    
    
    
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
    Remove-cSoftwarePackage will require the itemproperties DisplayName and UninstallString to successfully uninstall a package, it can be achieved easily by executing Get-cSoftwarePackage
    
    
SYNTAX
    Remove-cSoftwarePackage [[-InstalledSoftware] <Object>] [-Whatif] [<CommonParameters>]
    
    
DESCRIPTION
    Remove-cSoftwarePackage has a whatif statement, that will return what arguments will be executed if whatif was not supplied, ofc it will erase your package from disk.
    

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


CommonParameters         : False
WorkflowCommonParameters : False
details                  : @{name=Set-cSystemCenterConfiguration; noun=; verb=}
Syntax                   : @{syntaxItem=System.Object[]}
parameters               : @{parameter=System.Object[]}
inputTypes               : @{inputType=}
returnValues             : @{returnValue=}
aliases                  : None
                           
remarks                  : None
alertSet                 : 
description              : 
examples                 : 
Synopsis                 : 
                           Set-cSystemCenterConfiguration [[-SystemCenterGroupName] <Object>] [[-SystemCenterGateWayHostname] <Object>]
                           
ModuleName               : cGeneral
nonTerminatingErrors     : 
xmlns:command            : http://schemas.microsoft.com/maml/dev/command/2004/10
xmlns:dev                : http://schemas.microsoft.com/maml/dev/2004/10
xmlns:maml               : http://schemas.microsoft.com/maml/2004/10
Name                     : Set-cSystemCenterConfiguration
Category                 : Function
Component                : 
Role                     : 
Functionality            : 

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
