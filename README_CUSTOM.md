# Your Custom Gmail CLI

Fast, script-friendly CLI for Gmail, Calendar, Drive, and Docs. Built on gogcli with embedded OAuth credentials for easy setup.

## Features

- **Gmail** - Search, send, manage labels, filters, and more
- **Calendar** - List, create, update events and manage invitations
- **Drive** - Upload, download, search, and manage files
- **Docs** - Create, edit, and export documents
- **Multiple accounts** - Manage multiple Google accounts simultaneously
- **Secure storage** - Credentials stored in OS keyring
- **JSON output** - Perfect for scripting and automation

## Installation

### Quick Install

**macOS / Linux:**
```bash
curl -fsSL https://raw.githubusercontent.com/YOUR_USERNAME/gogcli/main/scripts/install.sh | bash
```

**Windows (PowerShell as Administrator):**
```powershell
iwr https://raw.githubusercontent.com/YOUR_USERNAME/gogcli/main/scripts/install.ps1 | iex
```

### Manual Download

Download the latest release for your platform:
- [macOS (Apple Silicon)](https://github.com/YOUR_USERNAME/gogcli/releases/latest/download/gogcli_latest_darwin_arm64.tar.gz)
- [macOS (Intel)](https://github.com/YOUR_USERNAME/gogcli/releases/latest/download/gogcli_latest_darwin_amd64.tar.gz)
- [Linux (x64)](https://github.com/YOUR_USERNAME/gogcli/releases/latest/download/gogcli_latest_linux_amd64.tar.gz)
- [Windows (x64)](https://github.com/YOUR_USERNAME/gogcli/releases/latest/download/gogcli_latest_windows_amd64.zip)

Extract and move to your PATH:

**macOS/Linux:**
```bash
tar -xzf gogcli_*.tar.gz
sudo mv gog /usr/local/bin/
```

**Windows:**
```powershell
Expand-Archive gogcli_*.zip
Move-Item gog.exe C:\Windows\System32\
```

## Quick Start

### 1. Authenticate

```bash
gog auth add your-email@gmail.com
```

This will open your browser to authorize the app. You'll see a consent screen requesting access to:
- Gmail (read, compose, send emails and manage settings)
- Calendar (full access)
- Drive (full access)
- Docs (full access)

Click "Allow" to continue.

### 2. Start Using

**Gmail:**
```bash
# List recent emails
gog gmail list

# Search emails
gog gmail search "from:boss@company.com"

# Send an email
gog gmail send --to friend@example.com --subject "Hello" --body "Hi there!"

# Get email as JSON
gog gmail get <message-id> --json
```

**Calendar:**
```bash
# List today's events
gog calendar list

# Create an event
gog calendar create --summary "Team Meeting" --start "2024-01-15T14:00:00" --duration 1h

# List events as JSON
gog calendar list --json
```

**Drive:**
```bash
# List files
gog drive list

# Upload a file
gog drive upload document.pdf

# Download a file
gog drive download <file-id> --out document.pdf

# Search files
gog drive search "name contains 'report'"
```

**Docs:**
```bash
# Create a document
gog docs create --title "My Document"

# Export as Markdown
gog docs export <doc-id> --format markdown --out document.md
```

## Advanced Usage

### Multiple Accounts

```bash
# Add another account
gog auth add work@company.com

# List accounts
gog auth list

# Use specific account
gog --account work@company.com gmail list
```

### JSON Output for Scripting

```bash
# Get emails as JSON
gog gmail list --json | jq '.messages[] | {subject, from}'

# Get calendar events as JSON
gog calendar list --json | jq '.events[] | {summary, start}'
```

### Read-Only Mode

```bash
# Authenticate with read-only permissions
gog auth add viewer@example.com --readonly
```

## Help

```bash
# General help
gog --help

# Command-specific help
gog gmail --help
gog calendar --help
gog drive --help
gog docs --help

# Full command list
GOG_HELP=full gog --help
```

## Troubleshooting

### "OAuth credentials missing"

The app should have embedded credentials. If you see this error, try reinstalling:
```bash
curl -fsSL https://raw.githubusercontent.com/YOUR_USERNAME/gogcli/main/scripts/install.sh | bash
```

### "Permission denied" errors

Make sure you've authenticated:
```bash
gog auth add your-email@gmail.com
```

### "Token expired" errors

Tokens refresh automatically. If you see this, try removing and re-adding your account:
```bash
gog auth remove your-email@gmail.com
gog auth add your-email@gmail.com
```

### Windows PATH issues

After installation, restart your terminal or PowerShell window for PATH changes to take effect.

## Privacy & Security

- Your credentials are stored securely in your OS keyring (Keychain on macOS, Credential Manager on Windows, Secret Service on Linux)
- OAuth tokens are encrypted at rest
- No data is sent to third parties - the app communicates directly with Google APIs
- You can revoke access anytime at https://myaccount.google.com/permissions

## Support

For issues, questions, or feature requests:
- Open an issue: https://github.com/YOUR_USERNAME/gogcli/issues
- Email: your-support@example.com

## License

Based on [gogcli](https://github.com/steipete/gogcli) by steipete.

[Your license here - MIT, Apache 2.0, etc.]
