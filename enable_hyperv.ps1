# Enable Hyper-V
Write-Host "Enabling Hyper-V and related features..." -ForegroundColor Yellow
dism.exe /Online /Enable-Feature:Microsoft-Hyper-V /All /NoRestart
dism.exe /Online /Enable-Feature:VirtualMachinePlatform /All /NoRestart
dism.exe /Online /Enable-Feature:Containers /All /NoRestart

# Start Docker Desktop
Write-Host "Starting Docker Desktop..." -ForegroundColor Yellow
Start-Process -FilePath "C:\Program Files\Docker\Docker\Docker Desktop.exe" -ErrorAction SilentlyContinue

Write-Host "Hyper-V has been enabled. Please restart your computer to apply changes." -ForegroundColor Green
