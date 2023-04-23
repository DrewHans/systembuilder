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

Write-Host "Updating chocolatey to latest version."
choco upgrade chocolatey --yes

Write-Host "Updating all choco-installed software packages."
choco upgrade all --yes

Write-Host "Finished $PSCommandPath";
PAUSE;
