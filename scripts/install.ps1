# PowerShell install script for gog CLI
$ErrorActionPreference = "Stop"

$REPO = "steipete/gogcli"
$VERSION = if ($env:GOG_VERSION) { $env:GOG_VERSION } else { "latest" }

# Determine architecture
$ARCH = if ([Environment]::Is64BitOperatingSystem) { "amd64" } else { "386" }
if ([System.Runtime.InteropServices.RuntimeInformation]::OSArchitecture -eq [System.Runtime.InteropServices.Architecture]::Arm64) {
    $ARCH = "arm64"
}

$BINARY = "gogcli_${VERSION}_windows_${ARCH}.zip"

# Construct download URL
if ($VERSION -eq "latest") {
    $URL = "https://github.com/$REPO/releases/latest/download/$BINARY"
} else {
    $URL = "https://github.com/$REPO/releases/download/v$VERSION/$BINARY"
}

Write-Host "📦 Downloading gog CLI..." -ForegroundColor Cyan
Write-Host "   OS: Windows"
Write-Host "   Arch: $ARCH"
Write-Host "   Version: $VERSION"

# Create installation directory
$INSTALL_DIR = "$env:LOCALAPPDATA\Programs\gogcli"
New-Item -ItemType Directory -Force -Path $INSTALL_DIR | Out-Null

# Download to temp location
$TMP_ZIP = "$env:TEMP\gog.zip"
try {
    Invoke-WebRequest -Uri $URL -OutFile $TMP_ZIP -UseBasicParsing
    
    # Extract
    Expand-Archive -Path $TMP_ZIP -DestinationPath $INSTALL_DIR -Force
    
    # Clean up
    Remove-Item $TMP_ZIP -Force
    
    # Add to PATH if not already there
    $UserPath = [Environment]::GetEnvironmentVariable("Path", "User")
    if ($UserPath -notlike "*$INSTALL_DIR*") {
        Write-Host "🔧 Adding to PATH..." -ForegroundColor Yellow
        [Environment]::SetEnvironmentVariable(
            "Path",
            "$UserPath;$INSTALL_DIR",
            "User"
        )
        $env:Path = "$env:Path;$INSTALL_DIR"
    }
    
    Write-Host ""
    Write-Host "✅ gog installed to $INSTALL_DIR\gog.exe" -ForegroundColor Green
    Write-Host ""
    Write-Host "🎉 Installation complete!" -ForegroundColor Green
    Write-Host ""
    Write-Host "Get started:"
    Write-Host "  gog auth add your-email@gmail.com"
    Write-Host ""
    Write-Host "For help:"
    Write-Host "  gog --help"
    Write-Host ""
    Write-Host "⚠️  You may need to restart your terminal for PATH changes to take effect." -ForegroundColor Yellow
    
} catch {
    Write-Host "❌ Installation failed: $_" -ForegroundColor Red
    exit 1
}
