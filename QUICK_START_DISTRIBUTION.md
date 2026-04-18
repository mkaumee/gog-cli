# Quick Start: Distribution in 5 Minutes

## Step 1: Add Your OAuth Credentials (1 min)

Edit `internal/config/credentials.json`:

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

## Step 2: Test Locally (1 min)

```bash
# Build
go build -o gog.exe ./cmd/gog

# Test OAuth flow
./gog.exe auth add test@example.com

# Verify your consent screen appears with only:
# - Gmail scopes
# - Calendar scope
# - Drive scope
# - Docs scope
```

## Step 3: Update CHANGELOG (1 min)

Edit `CHANGELOG.md` and add:

```markdown
## 1.0.0 - 2024-01-15

- Initial release with embedded OAuth credentials
- Gmail, Calendar, Drive, and Docs support
- Easy one-line installation
```

## Step 4: Create Release (1 min)

```bash
# This creates the tag and GitHub release
./scripts/release.sh 1.0.0
```

## Step 5: Build & Upload Binaries (1 min)

```bash
# Install goreleaser if you haven't
# macOS: brew install goreleaser
# Windows: scoop install goreleaser
# Linux: see https://goreleaser.com/install/

# Build and upload
goreleaser release --clean
```

## Done! 🎉

Your users can now install with:

**macOS/Linux:**
```bash
curl -fsSL https://raw.githubusercontent.com/YOUR_USERNAME/gogcli/main/scripts/install.sh | bash
```

**Windows:**
```powershell
iwr https://raw.githubusercontent.com/YOUR_USERNAME/gogcli/main/scripts/install.ps1 | iex
```

## What Your Users Will See

1. They run the install command
2. Binary downloads and installs automatically
3. They run: `gog auth add their-email@gmail.com`
4. Browser opens to YOUR company's OAuth consent screen
5. They see permissions for Gmail, Calendar, Drive, Docs only
6. They click "Allow"
7. They're authenticated and ready to use the CLI!

## Example User Flow

```bash
# Install
curl -fsSL https://raw.githubusercontent.com/YOUR_USERNAME/gogcli/main/scripts/install.sh | bash

# Authenticate
gog auth add john@example.com

# Use it
gog gmail list
gog calendar list
gog drive list
```

## Sharing with Your Team

Send them this message:

---

**New Gmail CLI Tool Available!**

We've created a command-line tool for Gmail, Calendar, Drive, and Docs.

**Install (one command):**

macOS/Linux:
```bash
curl -fsSL https://raw.githubusercontent.com/YOUR_USERNAME/gogcli/main/scripts/install.sh | bash
```

Windows:
```powershell
iwr https://raw.githubusercontent.com/YOUR_USERNAME/gogcli/main/scripts/install.ps1 | iex
```

**Get Started:**
```bash
gog auth add your-email@company.com
gog gmail list
```

**Documentation:**
https://github.com/YOUR_USERNAME/gogcli

---

## Troubleshooting

**"goreleaser not found"**
- Install it: https://goreleaser.com/install/
- Or build manually (see DISTRIBUTION.md)

**"credentials.json not found during build"**
- Make sure you created `internal/config/credentials.json`
- It should exist locally but not be committed to git

**"Release already exists"**
- Delete the tag: `git tag -d v1.0.0 && git push origin :refs/tags/v1.0.0`
- Delete the GitHub release from the web UI
- Try again

**"OAuth consent shows wrong scopes"**
- Check `internal/googleauth/service.go`
- `UserServices()` should only return: Gmail, Calendar, Drive, Docs
- Rebuild and test locally first

## Next Steps

- Customize `README_CUSTOM.md` and use it as your README
- Add your company branding
- Set up GitHub Actions for automated releases (see DISTRIBUTION.md)
- Monitor usage and gather feedback
