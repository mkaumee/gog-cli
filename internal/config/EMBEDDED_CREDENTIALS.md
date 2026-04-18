# Embedded OAuth Credentials

This directory contains support for embedding OAuth client credentials directly into the compiled binary.

## How It Works

1. Place your OAuth client credentials JSON file at `internal/config/credentials.json`
2. Build the CLI with `make build` or `go build ./cmd/gog`
3. The credentials are embedded at compile time using Go's `//go:embed` directive
4. When users run the CLI, it automatically uses the embedded credentials if no local credentials file exists

## OAuth Consent Screen Configuration

The CLI is configured to request only the following scopes (matching your OAuth consent screen):

### Enabled Services:
- **Gmail**: Read, compose, send emails and manage settings
  - `https://www.googleapis.com/auth/gmail.modify`
  - `https://www.googleapis.com/auth/gmail.settings.basic`
  - `https://www.googleapis.com/auth/gmail.settings.sharing`

- **Calendar**: Full calendar access
  - `https://www.googleapis.com/auth/calendar`

- **Drive**: Full Drive access
  - `https://www.googleapis.com/auth/drive`

- **Docs**: Document access
  - `https://www.googleapis.com/auth/documents`

Users will only see these scopes when they authenticate. Other services (Sheets, Slides, Tasks, etc.) are not available unless you add their scopes to your OAuth consent screen.

## Setup Instructions

1. Download your OAuth client credentials from Google Cloud Console
2. Replace the placeholder content in `internal/config/credentials.json` with your actual credentials:

```json
{
  "installed": {
    "client_id": "YOUR_ACTUAL_CLIENT_ID.apps.googleusercontent.com",
    "client_secret": "YOUR_ACTUAL_CLIENT_SECRET",
    "auth_uri": "https://accounts.google.com/o/oauth2/auth",
    "token_uri": "https://oauth2.googleapis.com/token",
    "redirect_uris": ["http://localhost"]
  }
}
```

3. Build the binary: `make build`
4. Distribute the compiled binary to your users

## Fallback Behavior

The CLI follows this priority order for credentials:

1. User's local credentials file (`~/.config/gogcli/credentials.json`)
2. Embedded credentials (if present in the binary)
3. Error if neither exists

This means users can still override the embedded credentials by providing their own credentials file if needed.

## Security Notes

- The `credentials.json` file is added to `.gitignore` to prevent accidental commits
- Only commit the placeholder version to version control
- Keep your actual credentials secure and never commit them to the repository
- The client secret is not highly sensitive (it's used for OAuth flows), but should still be treated as confidential
