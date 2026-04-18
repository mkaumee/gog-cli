# How to Release Your Binaries

Your binaries are compiled and ready in the `dist/` folder. Here's how to release them.

## ✅ What's Ready

All binaries compiled with embedded OAuth credentials:
- ✅ Windows (AMD64 & ARM64)
- ✅ Linux (AMD64 & ARM64)  
- ✅ macOS (Intel & Apple Silicon)

## Option 1: GitHub Release (Recommended)

### Step 1: Commit Your Code (Without Binaries)

```bash
# Make sure credentials.json is NOT committed
git status

# If credentials.json shows up, it shouldn't be committed
# It should be in .gitignore

# Add and commit your code changes
git add .
git commit -m "Add embedded OAuth and distribution setup"
git push origin main
```

### Step 2: Create a Git Tag

```bash
# Create and push a version tag
git tag v1.0.0
git push origin v1.0.0
```

### Step 3: Create GitHub Release

1. Go to your repository on GitHub
2. Click "Releases" (right sidebar)
3. Click "Create a new release"
4. Choose tag: `v1.0.0`
5. Release title: `v1.0.0 - Initial Release`
6. Description:
   ```markdown
   ## Gmail CLI v1.0.0
   
   Command-line tool for Gmail, Calendar, Drive, and Docs.
   
   ### Features
   - Gmail: Send, search, manage emails
   - Calendar: Manage events and invitations
   - Drive: Upload, download, manage files
   - Docs: Create and edit documents
   
   ### Installation
   
   **Quick Install:**
   
   macOS/Linux:
   ```bash
   curl -fsSL https://raw.githubusercontent.com/YOUR_USERNAME/gogcli/main/scripts/install.sh | bash
   ```
   
   Windows:
   ```powershell
   iwr https://raw.githubusercontent.com/YOUR_USERNAME/gogcli/main/scripts/install.ps1 | iex
   ```
   
   **Manual Download:**
   Download the binary for your platform below and follow the installation instructions.
   
   ### Quick Start
   ```bash
   gog auth add your-email@gmail.com
   gog gmail list
   ```
   ```

7. Upload binaries:
   - Drag and drop all files from `dist/` folder
   - Or click "Attach binaries" and select all 6 files

8. Click "Publish release"

### Step 4: Test Installation

Test that users can install:

```bash
# macOS/Linux
curl -fsSL https://raw.githubusercontent.com/YOUR_USERNAME/gogcli/main/scripts/install.sh | bash

# Windows
iwr https://raw.githubusercontent.com/YOUR_USERNAME/gogcli/main/scripts/install.ps1 | iex
```

## Option 2: Direct Distribution

If you don't want to use GitHub releases:

### Share Binaries Directly

1. Upload binaries to your own server/cloud storage
2. Share download links with users
3. Provide installation instructions from `dist/README.md`

### Example: Google Drive

1. Upload all binaries to Google Drive
2. Make them publicly accessible
3. Share the links

### Example: Dropbox

1. Upload to Dropbox
2. Get public links
3. Share with users

## Option 3: Internal Distribution

For company-internal use:

### Network Share

```bash
# Copy to network share
copy dist\* \\company-server\tools\gog\
```

### Email Distribution

1. Zip the appropriate binary
2. Email to users with instructions
3. Include the installation guide

## What NOT to Commit to Git

❌ Do NOT commit these to your repository:
- `dist/` folder (binaries are large)
- `internal/config/credentials.json` (your actual credentials)

✅ DO commit:
- All source code
- `scripts/install.sh` and `scripts/install.ps1`
- Documentation files
- `.gitignore` (which excludes credentials.json)

## Updating .gitignore for Binaries

Add this to `.gitignore` if not already there:

```
# Build outputs
dist/
bin/
*.exe
gog
```

## After Release

### Update Your README

Add installation instructions to your main README.md:

```markdown
## Installation

### Quick Install

**macOS/Linux:**
```bash
curl -fsSL https://raw.githubusercontent.com/YOUR_USERNAME/gogcli/main/scripts/install.sh | bash
```

**Windows:**
```powershell
iwr https://raw.githubusercontent.com/YOUR_USERNAME/gogcli/main/scripts/install.ps1 | iex
```

### Manual Download

Download from [releases page](https://github.com/YOUR_USERNAME/gogcli/releases/latest)
```

### Announce to Users

Send an email or message:

```
New Gmail CLI Tool Available!

We've created a command-line tool for Gmail, Calendar, Drive, and Docs.

Install with one command:
[installation command here]

Get started:
gog auth add your-email@company.com
gog gmail list

Documentation: [your repo URL]
```

## Troubleshooting

### "Binaries too large for GitHub"

GitHub has a 2GB limit per file. Your binaries are ~25MB each, so you're fine.

### "Install script can't find binaries"

Make sure:
1. GitHub release is published (not draft)
2. Binaries are attached to the release
3. Repository is public (or users have access)

### "Users see wrong OAuth consent screen"

The binaries have YOUR credentials embedded. Users should see YOUR company's consent screen.

### "Need to update binaries"

1. Make code changes
2. Rebuild: Run the build commands again
3. Create new release with new version (v1.0.1, v1.1.0, etc.)
4. Upload new binaries

## Quick Commands Reference

```bash
# Commit code (without binaries)
git add .
git commit -m "Your message"
git push origin main

# Create release tag
git tag v1.0.0
git push origin v1.0.0

# Rebuild binaries (if needed)
$env:GOOS="windows"; $env:GOARCH="amd64"; go build -ldflags="-s -w" -o dist/gog-windows-amd64.exe ./cmd/gog
$env:GOOS="linux"; $env:GOARCH="amd64"; go build -ldflags="-s -w" -o dist/gog-linux-amd64 ./cmd/gog
$env:GOOS="darwin"; $env:GOARCH="arm64"; go build -ldflags="-s -w" -o dist/gog-darwin-arm64 ./cmd/gog
```

## Next Steps

1. ✅ Binaries are compiled
2. ⬜ Commit code to git (without binaries)
3. ⬜ Create git tag
4. ⬜ Create GitHub release
5. ⬜ Upload binaries to release
6. ⬜ Test installation
7. ⬜ Announce to users

Good luck! 🚀
