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

Write-Host "Installing software packages with choco."

choco install 7zip --yes
choco install bleachbit --yes
choco install brave --yes
choco install dbeaver --yes
choco install firefox --yes
choco install git --yes
choco install keepassxc --yes
choco install libreoffice-fresh --yes
choco install librewolf --yes
choco install mediainfo --yes
choco install microsoft-teams --yes
choco install microsoft-windows-terminal --yes
choco install postman --yes
choco install slack --yes
choco install visualstudiocode --yes
choco install vscodium --yes
choco install vlc --yes
choco install zoom --yes

Write-Host "Installing programming language packages with choco."

choco install dotnet --yes
choco install dotnetcore --yes
choco install nodejs --yes
choco install openjdk --yes
choco install python --yes
choco install rust --yes

Write-Host "Finished $PSCommandPath";
PAUSE;
