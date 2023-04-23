Write-Host "Starting $PSCommandPath";

# check choco is installed
$chocoVersion = powershell choco -v;
IF (-not($chocoVersion)) {
    Write-Host "Chocolatey is missing."
    Write-Warning "Open a PowerShell console as an administrator and try running choco-installer.ps1.";
    Exit;
} ELSE {
    Write-Host "Chocolatey version $chocoVersion detected."
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
