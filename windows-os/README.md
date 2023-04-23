# windows-os systembuilder

This systembuilder is for Windows 10. These scripts may not work on future versions.

### Step 1: Install Chocolatey

Open powershell as admin and run this command:
`powershell -executionpolicy bypass -File .\choco-installer.ps1`

This should install [chocolatey](https://chocolatey.org/) on your machine.

Close powershell when finished.

### Step 2: Install Software Packages

Open powershell as admin and run this command:
`powershell -executionpolicy bypass -File .\installer.ps1`

This should install the software and programming language packages we want.

### Optional: Reverse scroll wheel direction

On Linux I use natural scrolling and would really love to have it on Windows, so I wrote this script.

Open powershell as admin and run the following command:
`powershell -executionpolicy bypass -File .\enable-natural-scrolling.ps1`

This will make changes in the system registry.
After it finishes, reboot the system and the scroll wheel direction should be reversed.
Note, system updates may revert this change. If that happens, run the script again.
