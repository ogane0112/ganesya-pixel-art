# Aseprite Script Installer
# Copies draw_cute_cat.lua and draw-book.lua to Aseprite scripts folder

# Aseprite scripts folder path (Windows standard location)
$asepriteScriptsPath = "C:\Users\ganesya\AppData\Roaming\Aseprite\scripts"

# Script files to install
$scriptFiles = @("draw_cute_cat.lua", "draw-book.lua")

Write-Host "==================================" -ForegroundColor Cyan
Write-Host "Aseprite Script Installer" -ForegroundColor Cyan
Write-Host "==================================" -ForegroundColor Cyan
Write-Host ""

# Check if all files exist
$allFilesExist = $true
foreach ($file in $scriptFiles) {
    $scriptPath = Join-Path $PSScriptRoot $file
    if (-not (Test-Path $scriptPath)) {
        Write-Host "Error: $file not found" -ForegroundColor Red
        Write-Host "Path: $scriptPath" -ForegroundColor Red
        $allFilesExist = $false
    } else {
        Write-Host "Found: $file" -ForegroundColor Green
    }
}

if (-not $allFilesExist) {
    exit 1
}

Write-Host ""
Write-Host "Install to: $asepriteScriptsPath" -ForegroundColor Yellow
Write-Host ""

# Create Aseprite scripts folder if it doesn't exist
if (-not (Test-Path $asepriteScriptsPath)) {
    Write-Host "Aseprite scripts folder not found. Creating..." -ForegroundColor Yellow
    try {
        New-Item -Path $asepriteScriptsPath -ItemType Directory -Force | Out-Null
        Write-Host "Folder created: $asepriteScriptsPath" -ForegroundColor Green
    } catch {
        Write-Host "Error: Failed to create folder" -ForegroundColor Red
        Write-Host $_.Exception.Message -ForegroundColor Red
        exit 1
    }
}

# Copy files
$successCount = 0
foreach ($file in $scriptFiles) {
    $scriptPath = Join-Path $PSScriptRoot $file
    try {
        Copy-Item -Path $scriptPath -Destination $asepriteScriptsPath -Force
        Write-Host "Installed: $file" -ForegroundColor Green
        $successCount++
    } catch {
        Write-Host "Error: Failed to copy $file" -ForegroundColor Red
        Write-Host $_.Exception.Message -ForegroundColor Red
    }
}

if ($successCount -eq $scriptFiles.Count) {
    Write-Host ""
    Write-Host "Success! All scripts installed." -ForegroundColor Green
    Write-Host ""
    Write-Host "Next steps:" -ForegroundColor Cyan
    Write-Host "1. Restart Aseprite" -ForegroundColor White
    Write-Host "2. Run scripts from File -> Scripts menu:" -ForegroundColor White
    Write-Host "   - draw_cute_cat" -ForegroundColor White
    Write-Host "   - draw-book" -ForegroundColor White
    Write-Host ""
} else {
    Write-Host ""
    Write-Host "Warning: Some scripts failed to install" -ForegroundColor Yellow
    exit 1
}
