## cGeneral ##
This **cGeneral** module contains 4 functions that should provide assistance for automation purposes.

### Functions ###
The functions this modules contains coexist of the following names:

Get-cURL
New-cVerboseMessage
Rename-cContent
Test-cAdministrator



### Installation ###
The installation of this module can be achieved by registering a NuGet repository:

*register-psrepository -name reponame -sourcelocation "http://repourl/nuget" -publishLocation "http://repourl/nuget" -installationPolicy trusted*

*find-module -name cGeneral*

*-or*

*find-module -name cGeneral -repository reponame*


### Detailed information about the functions###

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
    
    PS C:\>Replace-Content -Path "D:\jko\_Jobs" -FindString "mx.internal.asp4all.nl" -ReplaceString 
    "smarthost-asd2.solvinity.net"
    
    
    
    
    
    
    
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
