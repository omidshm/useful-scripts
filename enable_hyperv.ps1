if (-not ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)) {
    Start-Process powershell.exe -ArgumentList "-NoProfile -ExecutionPolicy Bypass -File `"$PSCommandPath`"" -Verb RunAs
    exit
}

# Enable Hyper-V
Write-Host "Enabling Hyper-V and related features..." -ForegroundColor Yellow
dism.exe /Online /Enable-Feature:Microsoft-Hyper-V /All /NoRestart
dism.exe /Online /Enable-Feature:VirtualMachinePlatform /All /NoRestart
dism.exe /Online /Enable-Feature:Containers /All /NoRestart

# Start Docker Desktop
Write-Host "Starting Docker Desktop..." -ForegroundColor Yellow
Start-Process -FilePath "C:\Program Files\Docker\Docker\Docker Desktop.exe" -ErrorAction SilentlyContinue

Write-Host "Hyper-V has been enabled. Please restart your computer to apply changes." -ForegroundColor Green

# Wait for user to press a key
Write-Host "`nPress any key to close..." -ForegroundColor Cyan
$null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")