Write-Host "Starting $PSCommandPath";

# GetCurrent() returns a WindowsIdentity object that represents the current Windows user
$CurrentWindowsIdentity = [System.Security.Principal.WindowsIdentity]::GetCurrent();

# Create a new object of type WindowsPrincipal, and pass the Windows Identity to it's constructor
$CurrentWindowsPrincipal = New-Object System.Security.Principal.WindowsPrincipal($CurrentWindowsIdentity);

# check user is running this script with admin privileges
if ($CurrentWindowsPrincipal.IsInRole([System.Security.Principal.WindowsBuiltInRole]::Administrator)) {
    Write-Host "This script is running with administrative privileges";
} else {
    Write-Warning "Insufficient permissions to run this script.";
    Write-Warning "Open the PowerShell console as an administrator and try running this script again.";
    Exit;
}

# check choco is installed
$chocoVersion = powershell choco -v;
IF (-not($chocoVersion)) {
    Write-Host "Chocolatey is missing. Attempting install now."
    powershell -NoProfile -ExecutionPolicy Bypass -Command "iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))" && SET "PATH=%PATH%;%ALLUSERSPROFILE%\chocolatey\bin";
} ELSE {
    Write-Host "Chocolatey version $chocoVersion detected."
}

Write-Host "Finished $PSCommandPath";
PAUSE;
