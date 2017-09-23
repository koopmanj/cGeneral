<#
.Synopsis
   Replace content string within a file
.DESCRIPTION
   This function will query the specified path and replace the findstring with a value of the replacestring
.EXAMPLE
   Replace-Content -Path "D:\jko\_Jobs" -FindString "mx.internal.asp4all.nl" -ReplaceString "smarthost-asd2.*.net"
.NOTES
   General notes
.COMPONENT
   The component this cmdlet belongs to
.ROLE
   The role this cmdlet belongs to
.FUNCTIONALITY
   The functionality that best describes this cmdlet
#>
function Rename-cContent {
    param(
        [string]$Path          = "D:\jko\_Jobs",
        [string]$FindString    = "",
        [string]$ReplaceString = ""
    )

    $configFiles = Get-ChildItem $Path
    foreach ($file in $configFiles)
    {
        (Get-Content $file.PSPath) | Foreach-Object { $_ -replace $FindString, $ReplaceString} | Set-Content $file.PSPath
    }
}