# Install-UpdateHealthTools

The script checks if UpdateHealthTools is already installed via 
Get-WmiObject -Class Win32_Product | Where-Object {$_.Name -match “Microsoft Update Health Tools”}

If not found, it goes ahead to install the same.

Install-PackageProvider NuGet -Force
Install-Module pswindowsupdate -force
Install-WindowsUpdate -kbarticleid KB4023057 -acceptall

I have added logging function to the script. The log is generated at IME location.
The same log can be used for IME detection purposes.
