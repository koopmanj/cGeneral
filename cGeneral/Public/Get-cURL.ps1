<#
    .SYNOPSIS
    Uniform while loop to wget or iwr an url.

    .PARAMETER Url
    Provide the url being tested.

    .PARAMETER Times
    The amount of times this provided URL will be queried.

#>
function Get-cURL {
    param(
        $Url   = 'https://www.google.com',
        $Times = 5
    )
    
    $i = 0
    
    While ($i -lt $Times) #While ($true)
    {
        $Request = New-Object System.Net.WebClient
        $Request.UseDefaultCredentials = $true
        $Start = Get-Date
        #$PageRequest = $Request.DownloadString($URL)
        $TimeTaken = ((Get-Date) - $Start).TotalMilliseconds 
        $Request.Dispose()
        New-VerboseMessage -Message "$Start : $([int]$($TimeTaken/1000))" -Verbose
        $i ++
    
        Write-Verbose -Message 'sleep 5 s' -Verbose
        Start-sleep 5 -Verbose
    }
}