Set-ExecutionPolicy Bypass -Scope Process -Force;

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

Write-Host "Installing chocolatey"

[System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072;

iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'));

Write-Host "Installed chocolatey version $(choco -v)"

Write-Host "Finished $PSCommandPath";
PAUSE;
