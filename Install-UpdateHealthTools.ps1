﻿<#
.SYNOPSIS
  ScriptName: Install-UpdateHealthTools.ps1
.DESCRIPTION
  The script checks if UpdateHealthTools is already installed. If not, it will install the same.
.OUTPUT
  Log file stored in C:\ProgramData\Microsoft\IntuneManagementExtension\Logs folder.
.NOTES
  Version:        1.0
  Author:         Joymalya Basu Roy
  Creation Date:  28-06-2021
#>
# Logging Preparation

$ScriptName = "Install-UpdateHealthTools"
$Log_FileName = "$ScriptName.log"
$Log_Path = "C:\ProgramData\Microsoft\IntuneManagementExtension\Logs\"
$TestPath = "$Log_Path\$Log_Filename"
$BreakingLine="- - "*10
$SubBreakingLine=". . "*10
$SectionLine="* * "*10

If(!(Test-Path $TestPath))
{
New-Item -Path $Log_Path -Name $Log_FileName -ItemType "File" -Force
}

function Write-Log {
    [CmdletBinding()]
    param(
        [Parameter()]
        [string]$Message
    )
$timestamp = Get-Date -Format "dddd MM/dd/yyyy HH:mm:ss"
Add-Content -Path $TestPath -Value "$timestamp : $Message"
}

# Start logging [Same file can be used for IME detection]

Write-Log "Begin script..."
Write-Log $SectionLine

#Check for the presence of Update Health Tools

$UHS = Get-WmiObject -Class Win32_Product | Where-Object {$_.Name -match “Microsoft Update Health Tools”}
if (-not[string]::IsNullOrEmpty($UHS))

{
    Write-Log "Update Health Tool already exist on this device"
}

else
{

    Write-Log "Update Health Tool was not found"
    Write-Log "Initiating install via Windows Update"
 
    Try {
        Install-PackageProvider NuGet -Force
        Install-Module pswindowsupdate -force
        Install-WindowsUpdate -kbarticleid KB4023057 -acceptall
        }
  Catch {
        $_ | Write-Log
        }
}

Write-Log "End of script execution..."
