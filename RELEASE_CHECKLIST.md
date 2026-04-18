# Release Checklist

Use this checklist when preparing a new release.

## Pre-Release

- [ ] **Add OAuth Credentials**
  - Replace placeholder in `internal/config/credentials.json`
  - Verify client_id and client_secret are correct
  - Test locally: `go build ./cmd/gog && ./gog auth add test@example.com`

- [ ] **Verify OAuth Consent Screen**
  - Go to Google Cloud Console → OAuth consent screen
  - Confirm these scopes are enabled:
    - `https://www.googleapis.com/auth/gmail.modify`
    - `https://www.googleapis.com/auth/gmail.settings.basic`
    - `https://www.googleapis.com/auth/gmail.settings.sharing`
    - `https://www.googleapis.com/auth/calendar`
    - `https://www.googleapis.com/auth/drive`
    - `https://www.googleapis.com/auth/documents`

- [ ] **Update Version**
  - Decide version number (e.g., 1.0.0)
  - Update `CHANGELOG.md` with release notes
  - Remove "Unreleased" from version header

- [ ] **Test Build**
  ```bash
  make ci
  ```

- [ ] **Verify Credentials Not in Git**
  ```bash
  git status
  # Should NOT show internal/config/credentials.json
  ```

## Release

- [ ] **Create Release**
  ```bash
  ./scripts/release.sh 1.0.0
  ```
  This will:
  - Create git tag
  - Push to GitHub
  - Create GitHub release

- [ ] **Build and Upload Binaries**
  ```bash
  goreleaser release --clean
  ```
  Or manually:
  ```bash
  # Build for all platforms
  GOOS=darwin GOARCH=arm64 go build -o dist/gog-darwin-arm64 ./cmd/gog
  GOOS=darwin GOARCH=amd64 go build -o dist/gog-darwin-amd64 ./cmd/gog
  GOOS=linux GOARCH=amd64 go build -o dist/gog-linux-amd64 ./cmd/gog
  GOOS=linux GOARCH=arm64 go build -o dist/gog-linux-arm64 ./cmd/gog
  GOOS=windows GOARCH=amd64 go build -o dist/gog-windows-amd64.exe ./cmd/gog
  
  # Upload to GitHub release manually
  ```

## Post-Release

- [ ] **Test Installation Scripts**
  
  macOS/Linux:
  ```bash
  curl -fsSL https://raw.githubusercontent.com/YOUR_USERNAME/gogcli/main/scripts/install.sh | bash
  gog --version
  ```
  
  Windows:
  ```powershell
  iwr https://raw.githubusercontent.com/YOUR_USERNAME/gogcli/main/scripts/install.ps1 | iex
  gog --version
  ```

- [ ] **Test OAuth Flow**
  ```bash
  gog auth add test@example.com
  # Verify your company's consent screen appears
  # Verify only Gmail, Calendar, Drive, Docs scopes are requested
  ```

- [ ] **Update Documentation**
  - Update README with installation instructions
  - Update any version numbers in docs
  - Add release announcement

- [ ] **Announce Release**
  - Post to your team/company
  - Update any internal documentation
  - Send email to users if applicable

## Troubleshooting

### Build fails with "credentials.json not found"
- Make sure `internal/config/credentials.json` exists
- Check that it's not in `.gitignore` (it should be, but needs to exist locally)

### OAuth consent shows wrong scopes
- Check `internal/googleauth/service.go` → `UserServices()` function
- Should only return: Gmail, Calendar, Drive, Docs

### Install script fails
- Verify GitHub release is public
- Check that binaries were uploaded correctly
- Test download URL manually

### Users see "OAuth credentials missing"
- Credentials weren't embedded in binary
- Rebuild with credentials.json present
- Verify using: `strings gog | grep "client_id"`

## Version Numbers

Follow semantic versioning:
- **Major** (1.0.0): Breaking changes
- **Minor** (0.1.0): New features, backwards compatible
- **Patch** (0.0.1): Bug fixes

## Security Reminders

- ⚠️ Never commit `internal/config/credentials.json` to git
- ⚠️ Keep your OAuth client secret secure
- ⚠️ Rotate credentials if accidentally exposed
- ⚠️ Review git history before making repository public
- ⚠️ Consider using GitHub Secrets for CI/CD builds
