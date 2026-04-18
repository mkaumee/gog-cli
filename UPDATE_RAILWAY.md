# Update Railway with Uninstall Scripts

Quick guide to add uninstall functionality to your Railway deployment.

## What Changed

Added uninstall scripts to your Railway project:
- `uninstall.sh` - macOS/Linux uninstaller
- `uninstall.ps1` - Windows uninstaller
- Updated `server.js` - Added uninstall endpoints

## Deploy Update

```bash
cd railway-project

# Add new files
git add uninstall.sh uninstall.ps1 server.js

# Commit
git commit -m "Add uninstall scripts"

# Push
git push origin main
```

Railway will auto-deploy in ~1-2 minutes.

## Verify Deployment

```bash
# Check info endpoint
curl gog-installer.up.railway.app/

# Should now show uninstall endpoints

# Test uninstall script
curl gog-installer.up.railway.app/uninstall.sh
```

## New Endpoints

After deployment, these will be available:

**Install:**
- `gog-installer.up.railway.app/install.sh`
- `gog-installer.up.railway.app/install.ps1`

**Uninstall:**
- `gog-installer.up.railway.app/uninstall.sh`
- `gog-installer.up.railway.app/uninstall.ps1`

## Desktop App Integration

### Install Button
```javascript
// macOS/Linux
"curl -fsSL gog-installer.up.railway.app/install.sh | bash"

// Windows
"iwr gog-installer.up.railway.app/install.ps1 | iex"
```

### Uninstall Button
```javascript
// macOS/Linux
"curl -fsSL gog-installer.up.railway.app/uninstall.sh | bash"

// Windows
"iwr gog-installer.up.railway.app/uninstall.ps1 | iex"
```

## Test Uninstall

If you have gog installed:

```bash
# macOS/Linux
curl -fsSL gog-installer.up.railway.app/uninstall.sh | bash

# Windows
iwr gog-installer.up.railway.app/uninstall.ps1 | iex
```

The script will:
1. Remove the binary
2. Ask if you want to remove credentials
3. Clean up config files (if you choose yes)

## Done! ✅

Your Railway deployment now has both install and uninstall functionality.
