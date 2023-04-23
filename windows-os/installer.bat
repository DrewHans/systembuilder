:: check choco is installed
where /q choco
IF ERRORLEVEL 1 (
    ECHO Chocolatey is missing. Attempting install now.
    :: Install choco .exe and add choco to PATH
    @powershell -NoProfile -ExecutionPolicy Bypass -Command "iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))" && SET "PATH=%PATH%;%ALLUSERSPROFILE%\chocolatey\bin"
) ELSE (
    ECHO Chocolatey detected.
)

ECHO Installing software packages with choco.

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

ECHO Installing programming language packages with choco.

choco install dotnet --yes
choco install dotnetcore --yes
choco install nodejs --yes
choco install openjdk --yes
choco install python --yes
choco install rust --yes
