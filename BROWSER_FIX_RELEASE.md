# Browser Fix - v1.0.1 Release

## What Was Fixed

Changed Windows browser opening from `rundll32` to `cmd /c start` for more reliable automatic browser opening.

## Create GitHub Release

1. Go to: https://github.com/mkaumee/gog-cli/releases/new

2. Choose tag: `v1.0.1`

3. Release title: `v1.0.1 - Fix Browser Auto-Open`

4. Description:
```markdown
## v1.0.1 - Fix Browser Auto-Open

### Fixed
- Improved Windows browser auto-open reliability
- Changed from `rundll32` to `cmd /c start` for opening browser
- Browser should now open automatically more consistently on Windows

### Installation

**macOS/Linux:**
```bash
curl -fsSL gog-installer.up.railway.app/install.sh | bash
```

**Windows:**
```powershell
iwr gog-installer.up.railway.app/install.ps1 | iex
```

### Features
- Gmail: Send, search, manage emails
- Calendar: Manage events and invitations
- Drive: Upload, download, organize files
- Docs: Create and edit documents

### Uninstall

**macOS/Linux:**
```bash
curl -fsSL gog-installer.up.railway.app/uninstall.sh | bash
```

**Windows:**
```powershell
iwr gog-installer.up.railway.app/uninstall.ps1 | iex
```
```

5. **Upload binaries** - Drag all 6 files from `dist/` folder:
   - gog-windows-amd64.exe
   - gog-windows-arm64.exe
   - gog-linux-amd64
   - gog-linux-arm64
   - gog-darwin-amd64
   - gog-darwin-arm64

6. Click "Publish release"

## Test the Fix

After publishing the release:

```powershell
# Uninstall old version
iwr gog-installer.up.railway.app/uninstall.ps1 | iex

# Install new version
iwr gog-installer.up.railway.app/install.ps1 | iex

# Test browser opening
gog auth add test@example.com
# Browser should now open automatically!
```

## What Changed

**Before (v1.0.0):**
```go
case "windows":
    return "rundll32", []string{"url.dll,FileProtocolHandler", u}
```

**After (v1.0.1):**
```go
case "windows":
    return "cmd", []string{"/c", "start", "", u}
```

The `cmd /c start` method is more reliable because:
- It's the standard Windows way to open files/URLs
- Works in more contexts (PowerShell, cmd, etc.)
- Less likely to be blocked by security settings
- Handles URLs with special characters better

## Binaries Ready

All 6 binaries have been rebuilt with the fix:
- ✅ gog-windows-amd64.exe (25.2 MB)
- ✅ gog-windows-arm64.exe (23.1 MB)
- ✅ gog-darwin-amd64 (25.3 MB)
- ✅ gog-darwin-arm64 (23.7 MB)
- ✅ gog-linux-amd64 (24.9 MB)
- ✅ gog-linux-arm64 (23.1 MB)

Ready to upload to GitHub release!
