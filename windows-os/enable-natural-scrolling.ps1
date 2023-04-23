Write-Host "Starting $MyInvocation.MyCommand.Name";

# GetCurrent() returns a WindowsIdentity object that represents the current Windows user
$CurrentWindowsIdentity = [System.Security.Principal.WindowsIdentity]::GetCurrent();

# Create a new object of type WindowsPrincipal, and pass the Windows Identity to it's constructor
$CurrentWindowsPrincipal = New-Object System.Security.Principal.WindowsPrincipal($CurrentWindowsIdentity);

# check user is running this script with admin privileges
if ($CurrentWindowsPrincipal.IsInRole([System.Security.Principal.WindowsBuiltInRole]::Administrator)) {
    Write-Host "This script is running with administrative privileges" -ForegroundColor Green;
} else {
    Write-Warning "Insufficient permissions to run this script." -ForegroundColor Red;
    Write-Warning "Open the PowerShell console as an administrator and try running this script again." -ForegroundColor Red;
    Exit;
}

Write-Host "Enabling natural scrolling for the mouse scrollwheel (will take effect after reboot).";

Get-PnpDevice -Class Mouse -PresentOnly -Status OK | ForEach-Object {
    "$($_.Name): $($_.DeviceID)";

    # set FlipFlopWheel DWORD to 1 (0 is default scroll direction, 1 is reversed direction [aka natural scrolling])
    Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Enum\$($_.DeviceID)\Device Parameters" -Name FlipFlopWheel -Value 1;
}

Write-Host "Finished $MyInvocation.MyCommand.Name";

# source 1: https://dotnet-helpers.com/powershell/how-to-check-if-a-powershell-script-is-running-with-admin-privileges/
# source 2: https://answers.microsoft.com/en-us/windows/forum/all/reverse-mouse-wheel-scroll/657c4537-f346-4b8b-99f8-9e1f52cd94c2
