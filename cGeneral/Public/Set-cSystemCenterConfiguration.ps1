function Set-cSystemCenterConfiguration {
    param(
        $SystemCenterGroupName = 'OMSMG01',
        $SystemCenterGateWayHostname = "HOSTNAME"
    )

    if (!(Test-Path 'HKLM:\SOFTWARE\Microsoft\Microsoft Operations Manager\')) {
        New-Item -Path HKLM:\SOFTWARE\Microsoft -Name 'Microsoft Operations Manager' -ItemType directory -Force

    }

    if (!(Test-Path 'HKLM:\SOFTWARE\Microsoft\Microsoft Operations Manager\3.0')) {
        New-Item -Path 'HKLM:\SOFTWARE\Microsoft\Microsoft Operations Manager\' -Name '3.0' -ItemType directory -Force
    }

    if (!(Test-Path 'HKLM:\SOFTWARE\Microsoft\Microsoft Operations Manager\3.0\Agent Management Groups')) {
        New-Item -Path 'HKLM:\SOFTWARE\Microsoft\Microsoft Operations Manager\3.0' -Name 'Agent Management Groups' -ItemType directory -Force
    }

    if (!(Test-Path "HKLM:\SOFTWARE\Microsoft\Microsoft Operations Manager\3.0\Agent Management Groups\$SystemCenterGroupName")) {
        New-Item -Path 'HKLM:\SOFTWARE\Microsoft\Microsoft Operations Manager\3.0\Agent Management Groups' -Name $SystemCenterGroupName -ItemType directory -Force
    }

    if ((Get-ChildItem -Path "HKLM:\SOFTWARE\Microsoft\Microsoft Operations Manager\3.0\Agent Management Groups\$SystemCenterGroupName" -Recurse) -eq $null) {
        New-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Microsoft Operations Manager\3.0\Agent Management Groups\$SystemCenterGroupName" -Name IsServer                  -Value 00000000 -PropertyType dword
        New-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Microsoft Operations Manager\3.0\Agent Management Groups\$SystemCenterGroupName" -Name UseActiveDirectory        -Value 00000000 -PropertyType dword
        New-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Microsoft Operations Manager\3.0\Agent Management Groups\$SystemCenterGroupName" -Name AcceptIncomingConnections -Value 00000000 -PropertyType dword
        New-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Microsoft Operations Manager\3.0\Agent Management Groups\$SystemCenterGroupName" -Name RequireAuthentication     -Value 00000001 -PropertyType dword
        New-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Microsoft Operations Manager\3.0\Agent Management Groups\$SystemCenterGroupName" -Name RequireEncryption         -Value 00000001 -PropertyType dword
        New-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Microsoft Operations Manager\3.0\Agent Management Groups\$SystemCenterGroupName" -Name RequireValidation         -Value 00000001 -PropertyType dword
        New-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Microsoft Operations Manager\3.0\Agent Management Groups\$SystemCenterGroupName" -Name RequestCompression        -Value 00000001 -PropertyType dword
    }

    if (!(Test-Path "HKLM:\SOFTWARE\Microsoft\Microsoft Operations Manager\3.0\Agent Management Groups\$SystemCenterGroupName\Parent Health Services")) {
        New-Item -Path "HKLM:\SOFTWARE\Microsoft\Microsoft Operations Manager\3.0\Agent Management Groups\$SystemCenterGroupName" -Name 'Parent Health Services' -ItemType directory -Force
    }

    if (!(Test-Path "HKLM:\SOFTWARE\Microsoft\Microsoft Operations Manager\3.0\Agent Management Groups\$SystemCenterGroupName\Parent Health Services\0")) {
        New-Item -Path "HKLM:\SOFTWARE\Microsoft\Microsoft Operations Manager\3.0\Agent Management Groups\$SystemCenterGroupName\Parent Health Services" -Name '0' -ItemType directory -Force
    }

    if ((Get-ChildItem -Path "HKLM:\SOFTWARE\Microsoft\Microsoft Operations Manager\3.0\Agent Management Groups\$SystemCenterGroupName\Parent Health Services\0" -Recurse) -eq $null) {
        New-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Microsoft Operations Manager\3.0\Agent Management Groups\$SystemCenterGroupName\Parent Health Services\0" -Name AuthenticationName         -Value $SystemCenterGateWayHostname
        New-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Microsoft Operations Manager\3.0\Agent Management Groups\$SystemCenterGroupName\Parent Health Services\0" -Name NetworkName                -Value $SystemCenterGateWayHostname
        New-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Microsoft Operations Manager\3.0\Agent Management Groups\$SystemCenterGroupName\Parent Health Services\0" -Name Port                       -Value 0x0000165b             -PropertyType dword
        New-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Microsoft Operations Manager\3.0\Agent Management Groups\$SystemCenterGroupName\Parent Health Services\0" -Name CanEstablishConnectionTo   -Value 0x00000001             -PropertyType dword
        New-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Microsoft Operations Manager\3.0\Agent Management Groups\$SystemCenterGroupName\Parent Health Services\0" -Name MaxSendBytesPerSecond      -Value 0x000f4240             -PropertyType dword
        New-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Microsoft Operations Manager\3.0\Agent Management Groups\$SystemCenterGroupName\Parent Health Services\0" -Name NetworkTimeoutMilliseconds -Value 0xffffffff             -PropertyType dword
        New-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Microsoft Operations Manager\3.0\Agent Management Groups\$SystemCenterGroupName\Parent Health Services\0" -Name RetryAttempts              -Value 0x00000003             -PropertyType dword
        New-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Microsoft Operations Manager\3.0\Agent Management Groups\$SystemCenterGroupName\Parent Health Services\0" -Name RetryDelayMs               -Value 0x000003e8             -PropertyType dword
    }

    if (!(Test-Path "HKLM:\SOFTWARE\Microsoft\Microsoft Operations Manager\3.0\Machine Settings")) {
        New-Item -Path "HKLM:\SOFTWARE\Microsoft\Microsoft Operations Manager\3.0\" -Name 'Machine Settings' -ItemType directory -Force
    }

    if (!(Test-Path "HKLM:\SOFTWARE\Microsoft\Microsoft Operations Manager\3.0\Modules")) {
        New-Item -Path "HKLM:\SOFTWARE\Microsoft\Microsoft Operations Manager\3.0\" -Name 'Modules' -ItemType directory -Force
    }

    if (!(Test-Path "HKLM:\SOFTWARE\Microsoft\Microsoft Operations Manager\3.0\Modules\Global")) {
        New-Item -Path "HKLM:\SOFTWARE\Microsoft\Microsoft Operations Manager\3.0\Modules" -Name 'Global' -ItemType directory -Force
    }

    if (!(Test-Path "HKLM:\SOFTWARE\Microsoft\Microsoft Operations Manager\3.0\Modules\Global\NT Event Log DS")) {
        New-Item -Path "HKLM:\SOFTWARE\Microsoft\Microsoft Operations Manager\3.0\Modules\Global" -Name 'NT Event Log DS' -ItemType directory -Force
        New-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Microsoft Operations Manager\3.0\Modules\Global\NT Event Log DS" -Name EventBatchSize               -Value 0x00000064             -PropertyType dword
    }

    if (!(Test-Path "HKLM:\SOFTWARE\Microsoft\Microsoft Operations Manager\3.0\Setup")) {
        New-Item -Path "HKLM:\SOFTWARE\Microsoft\Microsoft Operations Manager\3.0\" -Name 'Setup' -ItemType directory -Force
        New-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Microsoft Operations Manager\3.0\Setup"                          -Name AgentVersion                 -Value "8.0.11049.0"
        New-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Microsoft Operations Manager\3.0\Setup"                          -Name InstallDirectory             -Value "C:\\Program Files\\Microsoft Monitoring Agent\\Agent\\"
        New-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Microsoft Operations Manager\3.0\Setup"                          -Name CurrentVersion               -Value "8.0.11049.0"
        New-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Microsoft Operations Manager\3.0\Setup"                          -Name Product                      -Value "Microsoft Monitoring Agent"
        New-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Microsoft Operations Manager\3.0\Setup"                          -Name InstalledOn                  -Value (get-date).tostring()
    }

    if (!(Test-Path "HKLM:\\SOFTWARE\Microsoft\Microsoft Operations Manager\3.0\Setup\AgentServerCompatibilityCheck")) {
        New-Item -Path "HKLM:\\SOFTWARE\Microsoft\Microsoft Operations Manager\3.0\Setup\" -Name 'AgentServerCompatibilityCheck' -ItemType directory -Force
    }

    if (!(Test-Path "HKLM:\\SYSTEM\ControlSet001\Services\HealthService\Parameters\Management Groups\$SystemCenterGroupName")) {
        New-Item -Path "HKLM:\\SYSTEM\ControlSet001\Services\HealthService\Parameters\Management Groups\" -Name $SystemCenterGroupName -ItemType directory -Force
        New-ItemProperty -Path "HKLM:\SYSTEM\ControlSet001\Services\HealthService\Parameters\Management Groups\$SystemCenterGroupName" -Name "Connector CLSID"                       -Value "{534E71F9-7970-42D6-921F-59CFB873855F}"
        New-ItemProperty -Path "HKLM:\SYSTEM\ControlSet001\Services\HealthService\Parameters\Management Groups\$SystemCenterGroupName" -Name maximumQueueSizeKb                      -Value 0x00003c00 -PropertyType dword
        New-ItemProperty -Path "HKLM:\SYSTEM\ControlSet001\Services\HealthService\Parameters\Management Groups\$SystemCenterGroupName" -Name MaximumForwardedVirtualQueuePercentage  -Value 0x00000000 -PropertyType dword
        New-ItemProperty -Path "HKLM:\SYSTEM\ControlSet001\Services\HealthService\Parameters\Management Groups\$SystemCenterGroupName" -Name SendDataSinglePriority                  -Value 0x00000001 -PropertyType dword
        New-ItemProperty -Path "HKLM:\SYSTEM\ControlSet001\Services\HealthService\Parameters\Management Groups\$SystemCenterGroupName" -Name WindowsAccountLockDownSD                -Value ([byte[]](0x01, 0x00, 0x04, 0x80, 0x30, 0x00, 0x00, 0x00, 0x40, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x14, 0x00, 0x00, 0x00, 0x02, 0x00, 0x1c, 0x00,
                0x01, 0x00, 0x00, 0x00, 0x00, 0x00, 0x14, 0x00, 0x01, 0x00, 0x00, 0x00, 0x01, 0x01, 0x00, 0x00, 0x00,
                0x00, 0x00, 0x05, 0x0b, 0x00, 0x00, 0x00, 0x01, 0x02, 0x00, 0x00, 0x00, 0x00, 0x00, 0x05, 0x20, 0x00, 0x00, 0x00, 0x20, 0x02, 0x00, 0x00, 0x01, 0x02,
                0x00, 0x00, 0x00, 0x00, 0x00, 0x05, 0x20, 0x00, 0x00, 0x00, 0x20, 0x02, 0x00, 0x00)) -PropertyType Binary
        New-ItemProperty -Path "HKLM:\SYSTEM\ControlSet001\Services\HealthService\Parameters\Management Groups\$SystemCenterGroupName" -Name ID                                      -Value "246496ee-fb2e-e520-4849-42116cdb6496"
    }

    if (!(Test-Path "HKLM:\\SYSTEM\ControlSet001\Services\HealthService\Parameters\Management Groups\$SystemCenterGroupName\AllowedSSIDs")) {
        New-Item -Path "HKLM:\\SYSTEM\ControlSet001\Services\HealthService\Parameters\Management Groups\$SystemCenterGroupName" -Name 'AllowedSSIDs' -ItemType directory -Force
        New-ItemProperty -Path "HKLM:\\SYSTEM\ControlSet001\Services\HealthService\Parameters\Management Groups\$SystemCenterGroupName\AllowedSSIDs" -Name RestrictSSIDs -Value 0x00000000 -PropertyType dword
    }

    if (!(Test-Path "HKLM:\\SYSTEM\ControlSet001\Services\HealthService\Parameters\Management Groups\$SystemCenterGroupName\SSDB")) {
        New-Item -Path "HKLM:\\SYSTEM\ControlSet001\Services\HealthService\Parameters\Management Groups\$SystemCenterGroupName\"                -Name 'SSDB'                                 -ItemType directory -Force
        New-Item -Path "HKLM:\\SYSTEM\ControlSet001\Services\HealthService\Parameters\Management Groups\$SystemCenterGroupName\SSDB"            -Name 'References'                           -ItemType directory -Force
        New-Item -Path "HKLM:\\SYSTEM\ControlSet001\Services\HealthService\Parameters\Management Groups\$SystemCenterGroupName\SSDB\References" -Name '63745834-3e54-936c-1b47-2d632054a177' -ItemType directory -Force
        New-Item -Path "HKLM:\\SYSTEM\ControlSet001\Services\HealthService\Parameters\Management Groups\$SystemCenterGroupName\SSDB\References" -Name '92f8f803-0763-f491-2480-274bfc4126f9' -ItemType directory -Force
        New-Item -Path "HKLM:\\SYSTEM\ControlSet001\Services\HealthService\Parameters\Management Groups\$SystemCenterGroupName\SSDB"            -Name 'SSIDs'                                -ItemType directory -Force
    }


    #[HKEY_LOCAL_MACHINE\SYSTEM\ControlSet001\Services\HealthService\Parameters\Management Groups\OMSMG01\SSDB\References\63745834-3e54-936c-1b47-2d632054a177]
    #@="01020202020202020202020202020202020202020200000000000000000000000000000000000000"

    #[HKEY_LOCAL_MACHINE\SYSTEM\ControlSet001\Services\HealthService\Parameters\Management Groups\OMSMG01\SSDB\References\92f8f803-0763-f491-2480-274bfc4126f9]
    #@="01020202020202020202020202020202020202020200000000000000000000000000000000000000"
}