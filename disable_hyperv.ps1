if (-not ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)) {
    Start-Process powershell.exe -ArgumentList "-NoProfile -ExecutionPolicy Bypass -File `"$PSCommandPath`"" -Verb RunAs
    exit
}

# Stop all running WSL instances
Write-Host "Stopping all WSL instances..." -ForegroundColor Yellow
wsl --shutdown

# Stop Docker Desktop
Write-Host "Stopping Docker Desktop..." -ForegroundColor Yellow
Stop-Process -Name "Docker Desktop" -Force -ErrorAction SilentlyContinue

# Disable Hyper-V
Write-Host "Disabling Hyper-V and related features..." -ForegroundColor Yellow
dism.exe /Online /Disable-Feature:Microsoft-Hyper-V /NoRestart
dism.exe /Online /Disable-Feature:VirtualMachinePlatform /NoRestart
dism.exe /Online /Disable-Feature:Containers /NoRestart

Write-Host "Hyper-V has been disabled. Please restart your computer to apply changes." -ForegroundColor Green

# Wait for user to press a key
Write-Host "`nPress any key to close..." -ForegroundColor Cyan
$null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")