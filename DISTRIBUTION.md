# Distribution Guide

This guide explains how to build and distribute your customized gog CLI with embedded OAuth credentials.

## Prerequisites

- Go 1.21 or later
- [GoReleaser](https://goreleaser.com/install/) (for automated releases)
- GitHub account with repository access
- Your OAuth credentials in `internal/config/credentials.json`

## Quick Release Process

### 1. Prepare Your Credentials

Replace the placeholder in `internal/config/credentials.json` with your actual OAuth credentials:

```json
{
  "installed": {
    "client_id": "YOUR_CLIENT_ID.apps.googleusercontent.com",
    "client_secret": "YOUR_CLIENT_SECRET",
    "auth_uri": "https://accounts.google.com/o/oauth2/auth",
    "token_uri": "https://oauth2.googleapis.com/token",
    "redirect_uris": ["http://localhost"]
  }
}
```

### 2. Update CHANGELOG.md

Add a new section for your version:

```markdown
## 1.0.0 - 2024-01-15

- Initial release with embedded OAuth credentials
- Gmail, Calendar, Drive, and Docs support
```

### 3. Create Release

```bash
# Run the release script (handles tagging and GitHub release)
./scripts/release.sh 1.0.0
```

This script will:
- Verify you're on the main branch
- Check for a clean working tree
- Validate CHANGELOG.md has the version
- Run tests and build
- Create and push git tag
- Create GitHub release with notes from CHANGELOG

### 4. Build Binaries with GoReleaser

```bash
# Build and upload release artifacts
goreleaser release --clean
```

This will:
- Build for all platforms (Linux, macOS, Windows - amd64 and arm64)
- Create archives (tar.gz for Unix, zip for Windows)
- Upload to GitHub release
- Generate checksums

## Manual Build Process

If you prefer to build manually without GoReleaser:

### Create dist directory
```bash
mkdir -p dist
```

### Build for all platforms

**macOS:**
```bash
GOOS=darwin GOARCH=arm64 go build -o dist/gog-darwin-arm64 ./cmd/gog
GOOS=darwin GOARCH=amd64 go build -o dist/gog-darwin-amd64 ./cmd/gog
```

**Linux:**
```bash
GOOS=linux GOARCH=amd64 go build -o dist/gog-linux-amd64 ./cmd/gog
GOOS=linux GOARCH=arm64 go build -o dist/gog-linux-arm64 ./cmd/gog
```

**Windows:**
```bash
GOOS=windows GOARCH=amd64 go build -o dist/gog-windows-amd64.exe ./cmd/gog
GOOS=windows GOARCH=arm64 go build -o dist/gog-windows-arm64.exe ./cmd/gog
```

### Create GitHub Release

1. Go to your repository on GitHub
2. Click "Releases" → "Create a new release"
3. Tag: `v1.0.0`
4. Title: `Release v1.0.0`
5. Upload all binaries from `dist/`
6. Publish release

## User Installation

Once released, users can install using these one-liners:

### macOS / Linux

```bash
curl -fsSL https://raw.githubusercontent.com/YOUR_USERNAME/gogcli/main/scripts/install.sh | bash
```

Or with a specific version:
```bash
GOG_VERSION=1.0.0 curl -fsSL https://raw.githubusercontent.com/YOUR_USERNAME/gogcli/main/scripts/install.sh | bash
```

### Windows (PowerShell)

```powershell
iwr https://raw.githubusercontent.com/YOUR_USERNAME/gogcli/main/scripts/install.ps1 | iex
```

Or with a specific version:
```powershell
$env:GOG_VERSION="1.0.0"; iwr https://raw.githubusercontent.com/YOUR_USERNAME/gogcli/main/scripts/install.ps1 | iex
```

### Manual Download

Users can also download binaries directly from:
```
https://github.com/YOUR_USERNAME/gogcli/releases/latest
```

## Updating Your README

Add installation instructions to your README.md:

```markdown
## Installation

### Quick Install

**macOS / Linux:**
```bash
curl -fsSL https://raw.githubusercontent.com/YOUR_USERNAME/gogcli/main/scripts/install.sh | bash
```

**Windows (PowerShell):**
```powershell
iwr https://raw.githubusercontent.com/YOUR_USERNAME/gogcli/main/scripts/install.ps1 | iex
```

### Manual Download

Download the latest release for your platform from the [releases page](https://github.com/YOUR_USERNAME/gogcli/releases/latest).

## Quick Start

```bash
# Authenticate with your Google account
gog auth add your-email@gmail.com

# List your Gmail messages
gog gmail list

# List calendar events
gog calendar list
```
```

## Distribution Checklist

Before releasing:

- [ ] OAuth credentials added to `internal/config/credentials.json`
- [ ] OAuth consent screen configured with correct scopes
- [ ] CHANGELOG.md updated with version notes
- [ ] All tests passing (`make test`)
- [ ] Build successful (`make build`)
- [ ] Version number decided (semantic versioning)
- [ ] GitHub repository is public (or users have access)
- [ ] Install scripts tested on target platforms

## Security Notes

1. **Never commit real credentials to git** - The `.gitignore` is configured to exclude `internal/config/credentials.json`
2. **Keep your repository private during development** - Only make it public after you've verified no credentials are in git history
3. **Rotate credentials if exposed** - If credentials are accidentally committed, revoke them in Google Cloud Console immediately
4. **Consider using GitHub Secrets** - For automated builds, store credentials as GitHub Secrets and inject during build

## Automated CI/CD (Optional)

You can automate releases using GitHub Actions. Create `.github/workflows/release.yml`:

```yaml
name: Release

on:
  push:
    tags:
      - 'v*'

jobs:
  goreleaser:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
        with:
          fetch-depth: 0
      
      - uses: actions/setup-go@v5
        with:
          go-version: '1.21'
      
      - name: Add credentials
        run: |
          echo '${{ secrets.OAUTH_CREDENTIALS }}' > internal/config/credentials.json
      
      - uses: goreleaser/goreleaser-action@v5
        with:
          version: latest
          args: release --clean
        env:
          GITHUB_TOKEN: ${{ secrets.GITHUB_TOKEN }}
```

Then add your credentials as a GitHub Secret named `OAUTH_CREDENTIALS`.

## Support

For issues with:
- **Building**: Check Go version and dependencies
- **OAuth**: Verify credentials and consent screen configuration
- **Distribution**: Ensure GitHub release is public and binaries are uploaded
