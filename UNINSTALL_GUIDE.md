# Uninstall Guide

## For Users

### macOS / Linux

```bash
curl -fsSL gog-installer.up.railway.app/uninstall.sh | bash
```

Or manually:
```bash
# Remove binary
sudo rm /usr/local/bin/gog

# Remove config and credentials (optional)
rm -rf ~/.config/gogcli
```

### Windows

```powershell
iwr gog-installer.up.railway.app/uninstall.ps1 | iex
```

Or manually:
```powershell
# Remove binary (check these locations)
Remove-Item "$env:USERPROFILE\gog.exe"
Remove-Item "$env:LOCALAPPDATA\Programs\gogcli\gog.exe"
Remove-Item "C:\Windows\System32\gog.exe"

# Remove config and credentials (optional)
Remove-Item "$env:APPDATA\gogcli" -Recurse -Force
```

## What Gets Removed

### Binary
- macOS/Linux: `/usr/local/bin/gog`
- Windows: Various locations (script checks common paths)

### Config & Credentials (Optional)
- macOS/Linux: `~/.config/gogcli/`
- Windows: `%APPDATA%\gogcli\`

Contains:
- OAuth refresh tokens
- Account aliases
- Configuration settings

## Desktop App Integration

### Uninstall Button

**macOS/Linux:**
```javascript
const { exec } = require('child_process');

function uninstallCLI() {
  exec('curl -fsSL gog-installer.up.railway.app/uninstall.sh | bash', 
    (error, stdout, stderr) => {
      if (error) {
        console.error('Uninstall failed:', error);
        return;
      }
      console.log('CLI uninstalled successfully');
    }
  );
}
```

**Windows:**
```javascript
function uninstallCLI() {
  exec('powershell -Command "iwr gog-installer.up.railway.app/uninstall.ps1 | iex"',
    (error, stdout, stderr) => {
      if (error) {
        console.error('Uninstall failed:', error);
        return;
      }
      console.log('CLI uninstalled successfully');
    }
  );
}
```

## Uninstall Script Features

### Interactive
- Asks before removing config/credentials
- Shows what's being removed
- Provides feedback on success/failure

### Safe
- Only removes gog-related files
- Doesn't touch other system files
- Handles missing files gracefully

### Clean
- Removes binary
- Optionally removes config
- Optionally removes credentials

## Deploy Uninstall Scripts

The uninstall scripts are already in your `railway-project/` folder. To deploy:

```bash
cd railway-project
git add uninstall.sh uninstall.ps1 server.js
git commit -m "Add uninstall scripts"
git push origin main
```

Railway will auto-deploy and the uninstall endpoints will be available at:
- `gog-installer.up.railway.app/uninstall.sh`
- `gog-installer.up.railway.app/uninstall.ps1`

## Test Uninstall

```bash
# Test the endpoint exists
curl gog-installer.up.railway.app/uninstall.sh

# Test actual uninstall (if you have it installed)
curl -fsSL gog-installer.up.railway.app/uninstall.sh | bash
```

## User Instructions

Add to your documentation:

```markdown
## Uninstall

**macOS/Linux:**
```bash
curl -fsSL gog-installer.up.railway.app/uninstall.sh | bash
```

**Windows:**
```powershell
iwr gog-installer.up.railway.app/uninstall.ps1 | iex
```

The uninstaller will:
1. Remove the gog binary
2. Ask if you want to remove stored credentials
3. Clean up configuration files (if requested)
```

## Complete Removal

If you want to ensure everything is removed:

**macOS/Linux:**
```bash
# Remove binary
sudo rm -f /usr/local/bin/gog

# Remove all config and credentials
rm -rf ~/.config/gogcli

# Remove keyring entries (if using system keyring)
# macOS: Check Keychain Access app for "gogcli" entries
# Linux: Check with `secret-tool search service gogcli`
```

**Windows:**
```powershell
# Remove binary
Remove-Item "$env:USERPROFILE\gog.exe" -ErrorAction SilentlyContinue
Remove-Item "$env:LOCALAPPDATA\Programs\gogcli\gog.exe" -ErrorAction SilentlyContinue
Remove-Item "C:\Windows\System32\gog.exe" -ErrorAction SilentlyContinue

# Remove all config and credentials
Remove-Item "$env:APPDATA\gogcli" -Recurse -Force -ErrorAction SilentlyContinue

# Remove keyring entries
# Check Windows Credential Manager for "gogcli" entries
```
