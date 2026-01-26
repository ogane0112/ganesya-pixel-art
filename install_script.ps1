# Aseprite Script Installer
# Copies draw_cute_cat.lua to Aseprite scripts folder

# Aseprite scripts folder path (Windows standard location)
$asepriteScriptsPath = "C:\Users\ganesya\AppData\Roaming\Aseprite\scripts"

# Script file path
$scriptFile = Join-Path $PSScriptRoot "draw_cute_cat.lua"

Write-Host "==================================" -ForegroundColor Cyan
Write-Host "Aseprite Script Installer" -ForegroundColor Cyan
Write-Host "==================================" -ForegroundColor Cyan
Write-Host ""

# Check if file exists
if (-not (Test-Path $scriptFile)) {
    Write-Host "Error: draw_cute_cat.lua not found" -ForegroundColor Red
    Write-Host "Path: $scriptFile" -ForegroundColor Red
    exit 1
}

Write-Host "Script file: $scriptFile" -ForegroundColor Green
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

# Copy file
try {
    Copy-Item -Path $scriptFile -Destination $asepriteScriptsPath -Force
    Write-Host "Success! Script installed." -ForegroundColor Green
    Write-Host ""
    Write-Host "Next steps:" -ForegroundColor Cyan
    Write-Host "1. Restart Aseprite" -ForegroundColor White
    Write-Host "2. Run File -> Scripts -> draw_cute_cat" -ForegroundColor White
    Write-Host ""
} catch {
    Write-Host "Error: Failed to copy file" -ForegroundColor Red
    Write-Host $_.Exception.Message -ForegroundColor Red
    exit 1
}
