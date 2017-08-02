$Module = "$PSScriptRoot\..\cExample.psm1"
Remove-Module -Name $Module -Force -ErrorAction SilentlyContinue
Import-Module -Name $Module -Force -ErrorAction Stop

Describe 'cExample' {

    Context Verb-cNoun `    {
        It 'Verb-cNoun; should not throw' `        {
            {Verb-cNoun C:\ProgramData} | Should Not Throw
        }           It "Verb-cNoun -Files; should return a System.Object containing: Consumed, Size(MB), Name and Directory'" `        {
            {
                $Result = Verb-cNoun C:\ProgramData -Files -Top 1
                (($Result.GetType()).Fullname) | Should Be 'System.Management.Automation.PSCustomObject'
                (($Result | Get-Member).where({$_.MemberType -eq 'NoteProperty'}) | select -First 1).name | Should Match @("^([CONSUMED])\w.+")
                (($Result | Get-Member).where({$_.MemberType -eq 'NoteProperty'}) | select -Skip 1).name  | Should be @('Size(MB)','Name','Directory')
            } | Should Not Throw
        }
        It "Verb-cNoun; should return a System.Object containing: Consumed, Size(MB), Files and Directory'" `        {
            {
            } | Should Not Throw
        }
        
    }
}